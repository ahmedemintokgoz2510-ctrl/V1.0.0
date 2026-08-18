import 'package:flutter/material.dart';
import 'package:crazy_block_online/theme/app_theme.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:crazy_block_online/providers/game_state.dart';
import 'package:provider/provider.dart';
import 'package:crazy_block_online/app_strings.dart';

@NowaGenerated()
class GameScreen extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() {
    return _GameScreenState();
  }
}

@NowaGenerated()
class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  late List<Color?> _boardCells;

  late List<List<List<int>>> _availablePieces;

  int _selectedPieceIndex = -1;

  int _comboCount = 0;

  String _lastComboText = '';

  // V1.0.0 新增
  int _playerHighScore = 0;
  
  bool _isGameOver = false;
  
  bool _showGameOverAnimation = false;
  
  int? _previewRow;
  
  int? _previewCol;
  
  AnimationController? _gameOverAnimationController;
  
  late Map<int, double> _cellFadeValues;

  final List<List<List<int>>> _pieceTemplates = [
    [
      [1, 1],
      [1, 1],
    ],
    [
      [1, 1, 1],
    ],
    [
      [1],
      [1],
      [1],
    ],
    [
      [1, 0],
      [1, 1],
    ],
    [
      [0, 1],
      [1, 1],
    ],
    [
      [1, 1, 1],
      [0, 1, 0],
    ],
    [
      [1, 1],
    ],
    [
      [1],
      [1],
    ],
    [
      [1],
    ],
  ];

  final List<Color> _pieceColors = [
    AppTheme.blockCyan,
    AppTheme.blockOrange,
    AppTheme.blockGreen,
    AppTheme.blockPurple,
    AppTheme.blockYellow,
    AppTheme.blockRed,
    AppTheme.blockBlue,
  ];

  static const int gridSize = 8;

  @override
  void initState() {
    super.initState();
        _boardCells = List<Color?>.filled(gridSize * gridSize, null);
            _cellFadeValues = {
      for (var i = 0; i < gridSize * gridSize; i++) i: 1.0
    };



    _generateNextPieces();
    Future.microtask(() {
      final gameState = Provider.of<GameStateProvider>(context, listen: false);
      gameState.resetGameScore();
      _playerHighScore = gameState.currentPlayer?.highScore ?? 0;
    });
    _gameOverAnimationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
  }
  
  @override
  void dispose() {
    _gameOverAnimationController?.dispose();
    super.dispose();
  }

  void _generateNextPieces() {
    final now = DateTime.now().millisecondsSinceEpoch;
    _availablePieces = [
      _pieceTemplates[now % _pieceTemplates.length],
      _pieceTemplates[(now ~/ 3 + 2) % _pieceTemplates.length],
      _pieceTemplates[(now ~/ 7 + 4) % _pieceTemplates.length],
    ];
    _selectedPieceIndex = -1;
  }

  bool _isPieceEmpty(List<List<int>> piece) {
    for (var row in piece) {
      for (var cell in row) {
        if (cell == 1) {
          return false;
        }
      }
    }
    return true;
  }

  void _onBoardCellTap(int cellIndex) {
    if (_selectedPieceIndex < 0 ||
        _selectedPieceIndex >= _availablePieces.length) {
      final gameState = Provider.of<GameStateProvider>(context, listen: false);
      final lang = gameState.selectedLanguage;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppStrings.tr('select_piece_hint', lang)),
          duration: const Duration(milliseconds: 900),
          backgroundColor: const Color(0xFF155E9E),
        ),
      );
      return;
    }
    final piece = _availablePieces[_selectedPieceIndex];
    if (_isPieceEmpty(piece)) {
      return;
    }
    final targetRow = cellIndex ~/ gridSize;
    final targetCol = cellIndex % gridSize;
    final pRows = piece.length;
    final pCols = piece[0].length;
    if (targetRow + pRows > gridSize || targetCol + pCols > gridSize) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Piece does not fit here!'),
          duration: Duration(milliseconds: 700),
          backgroundColor: AppTheme.buttonRed,
        ),
      );
      return;
    }
    for (int r = 0; r < pRows; r++) {
      for (int c = 0; c < pCols; c++) {
        if (piece[r][c] == 1) {
          final boardIdx = (targetRow + r) * gridSize + (targetCol + c);
          if (_boardCells[boardIdx] != null) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Space is occupied!'),
                duration: Duration(milliseconds: 700),
                backgroundColor: AppTheme.buttonRed,
              ),
            );
            return;
          }
        }
      }
    }
    final color =
        _pieceColors[(_selectedPieceIndex * 2 + targetRow) %
            _pieceColors.length];
    final gameState = Provider.of<GameStateProvider>(context, listen: false);
    setState(() {
      int blockCount = 0;
      for (int r = 0; r < pRows; r++) {
        for (int c = 0; c < pCols; c++) {
          if (piece[r][c] == 1) {
            final boardIdx = (targetRow + r) * gridSize + (targetCol + c);
            _boardCells[boardIdx] = color;
            blockCount++;
          }
        }
      }
      _availablePieces[_selectedPieceIndex] = [];
      _selectedPieceIndex = -1;
      gameState.addScore(blockCount * 10);
      _checkLineClears(gameState);
      final allUsed = _availablePieces.every((p) => _isPieceEmpty(p));
      if (allUsed) {
        _generateNextPieces();
      }
      _checkGameContinuity();
    });
  }

  void _checkGameContinuity() {
    bool anyCanFit = false;
    for (var piece in _availablePieces) {
      if (_isPieceEmpty(piece)) {
        continue;
      }
      final pRows = piece.length;
      final pCols = piece[0].length;
      for (int r = 0; r <= gridSize - pRows; r++) {
        for (int c = 0; c <= gridSize - pCols; c++) {
          bool canFit = true;
          for (int pr = 0; pr < pRows; pr++) {
            for (int pc = 0; pc < pCols; pc++) {
              if (piece[pr][pc] == 1 &&
                  _boardCells[(r + pr) * gridSize + (c + pc)] != null) {
                canFit = false;
                break;
              }
            }
            if (!canFit) {
              break;
            }
          }
          if (canFit) {
            anyCanFit = true;
            break;
          }
        }
        if (anyCanFit) {
          break;
        }
      }
      if (anyCanFit) {
        break;
      }
    }
    final remainingPieces = _availablePieces
        .where((p) => !_isPieceEmpty(p))
        .toList();
    if (remainingPieces.isNotEmpty && !anyCanFit) {
      final gameState = Provider.of<GameStateProvider>(context, listen: false);
      Future.delayed(const Duration(milliseconds: 600), () {
        if (mounted) {
          _showGameOverDialog(gameState.selectedLanguage);
        }
      });
    }
  }

  void _checkLineClears(GameStateProvider gameState) {
    final rowsToClear = <int>[];
    final colsToClear = <int>[];
    for (int r = 0; r < gridSize; r++) {
      bool rowFull = true;
      for (int c = 0; c < gridSize; c++) {
        if (_boardCells[r * gridSize + c] == null) {
          rowFull = false;
          break;
        }
      }
      if (rowFull) {
        rowsToClear.add(r);
      }
    }
    for (int c = 0; c < gridSize; c++) {
      bool colFull = true;
      for (int r = 0; r < gridSize; r++) {
        if (_boardCells[r * gridSize + c] == null) {
          colFull = false;
          break;
        }
      }
      if (colFull) {
        colsToClear.add(c);
      }
    }
    final clearedTotal = rowsToClear.length + colsToClear.length;
    if (clearedTotal > 0) {
      for (final r in rowsToClear) {
        for (int c = 0; c < gridSize; c++) {
          _boardCells[r * gridSize + c] = null;
        }
      }
      for (final c in colsToClear) {
        for (int r = 0; r < gridSize; r++) {
          _boardCells[r * gridSize + c] = null;
        }
      }
      _comboCount++;
      final bonus = clearedTotal * 100 * _comboCount;
      gameState.addScore(bonus);
      gameState.addCoins(clearedTotal * 5);
      _lastComboText = 'COMBO x${_comboCount}! +${bonus} PTS';
    } else {
      _comboCount = 0;
      _lastComboText = '';
    }
  }

  void _showPauseDialog(String lang) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF155E9E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26.0),
          side: const BorderSide(color: Color(0xFF64B5F6), width: 2.5),
        ),
        title: Center(
          child: Text(
            AppStrings.tr('paused', lang),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 22.0,
              letterSpacing: 1.0,
            ),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 14.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF0E3D70),
                borderRadius: BorderRadius.circular(18.0),
                border: Border.all(color: const Color(0xFF42A5F5), width: 1.5),
              ),
              child: Consumer<GameStateProvider>(
                builder: (context, gameState, child) => Column(
                  children: [
                    Text(
                      '${AppStrings.tr('score', lang)}: ${gameState.currentScore}',
                      style: const TextStyle(
                        color: Color(0xFFFFD54F),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      '${AppStrings.tr('high_score', lang)}: ${gameState.currentPlayer?.highScore ?? 0}',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.75),
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            _buildDialogButton(
              title: AppStrings.tr('resume', lang),
              topColor: const Color(0xFF8BC34A),
              bottomColor: const Color(0xFF689F38),
              onTap: () => Navigator.pop(ctx),
            ),
            const SizedBox(height: 10.0),
            _buildDialogButton(
              title: AppStrings.tr('restart', lang),
              topColor: const Color(0xFF42A5F5),
              bottomColor: const Color(0xFF1E88E5),
              onTap: () {
                Navigator.pop(ctx);
                _resetGame();
              },
            ),
            const SizedBox(height: 10.0),
            _buildDialogButton(
              title: AppStrings.tr('main_menu', lang),
              topColor: const Color(0xFF0E3D70),
              bottomColor: const Color(0xFF0A2E66),
              onTap: () {
                Navigator.pop(ctx);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _resetGame() {
    setState(() {
      _boardCells = List<Color?>.filled(gridSize * gridSize, null);
      _generateNextPieces();
      _comboCount = 0;
      _lastComboText = '';
      _selectedPieceIndex = -1;
    });
    Provider.of<GameStateProvider>(context, listen: false).resetGameScore();
  }

  Widget _buildDialogButton({
    required String title,
    required Color topColor,
    required Color bottomColor,
    required void Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 48.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [topColor, bottomColor],
          ),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.35),
            width: 1.2,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 14.5,
              letterSpacing: 0.6,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppTheme.bgGradient),
        child: SafeArea(
          child: Consumer<GameStateProvider>(
            builder: (context, gameState, child) {
              final lang = gameState.selectedLanguage;
              final score = gameState.currentScore;
              final best = gameState.currentPlayer?.highScore ?? 0;
              return Column(
                children: [
                  _buildHeader(lang, score, best),
                  if (_lastComboText.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: 4.0),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 5.0,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: const [Color(0xFFFFD54F), Color(0xFFFFA000)],
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6.0,
                            offset: Offset(0.0, 3.0),
                          ),
                        ],
                      ),
                      child: Text(
                        _lastComboText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.8,
                          shadows: const [
                            Shadow(
                              color: Colors.black38,
                              blurRadius: 3.0,
                              offset: Offset(0.0, 1.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 8.0),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: _buildGameBoard(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  _buildNextPiecesDock(lang),
                  const SizedBox(height: 16.0),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String lang, int score, int best) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => _showPauseDialog(lang),
            child: Container(
              width: 44.0,
              height: 44.0,
              decoration: BoxDecoration(
                color: const Color(0xFF155E9E),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: const Color(0xFF64B5F6), width: 2.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6.0,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: const Icon(
                Icons.pause_rounded,
                color: Colors.white,
                size: 24.0,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 8.0,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF155E9E).withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: const Color(0xFF64B5F6), width: 2.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8.0,
                  offset: Offset(0.0, 3.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${score}',
                  style: const TextStyle(
                    color: Color(0xFFFFD54F),
                    fontSize: 26.0,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                    shadows: const [
                      Shadow(
                        color: Colors.black38,
                        blurRadius: 4.0,
                        offset: Offset(0.0, 2.0),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${AppStrings.tr('best', lang).toUpperCase()}: ${best}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 44.0),
        ],
      ),
    );
  }

  Widget _buildGameBoard() {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color(0xFF0E3D70),
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(color: const Color(0xFF42A5F5), width: 2.5),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 14.0,
              offset: Offset(0.0, 6.0),
            ),
          ],
        ),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: gridSize * gridSize,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridSize,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemBuilder: (context, index) {
            final cellColor = _boardCells[index];
            return GestureDetector(
              onTap: () => _onBoardCellTap(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                decoration: BoxDecoration(
                  color:
                      cellColor ??
                      const Color(0xFF145899).withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(
                    color: cellColor != null
                        ? Colors.white.withValues(alpha: 0.45)
                        : Colors.white.withValues(alpha: 0.08),
                    width: 1.0,
                  ),
                  boxShadow: cellColor != null
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.25),
                            blurRadius: 3.0,
                            offset: const Offset(0.0, 2.0),
                          ),
                        ]
                      : null,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNextPiecesDock(String lang) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFF155E9E).withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: const Color(0xFF64B5F6), width: 2.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.tr('next_pieces', lang),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.8,
                ),
              ),
              Text(
                _selectedPieceIndex >= 0
                    ? 'TAP GRID TO PLACE'
                    : 'TAP TO SELECT',
                style: TextStyle(
                  color: _selectedPieceIndex >= 0
                      ? const Color(0xFFFFD54F)
                      : Colors.white70,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              _availablePieces.length,
              (idx) => _buildPiecePreviewSlot(idx),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPiecePreviewSlot(int idx) {
    final piece = _availablePieces[idx];
    final isEmpty = _isPieceEmpty(piece);
    final isSelected = _selectedPieceIndex == idx && !isEmpty;
    final color = _pieceColors[(idx * 2 + 1) % _pieceColors.length];
    if (isEmpty) {
      return Container(
        width: 82.0,
        height: 72.0,
        decoration: BoxDecoration(
          color: const Color(0xFF0E3D70).withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
      );
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedPieceIndex == idx) {
            _selectedPieceIndex = -1;
          } else {
            _selectedPieceIndex = idx;
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 82.0,
        height: 72.0,
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF0E3D70)
              : const Color(0xFF0E3D70).withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(18.0),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFFFD54F)
                : const Color(0xFF42A5F5),
            width: isSelected ? 2.5 : 1.5,
          ),
          boxShadow: isSelected
              ? [
                  const BoxShadow(
                    color: Color(0xFFFFD54F),
                    blurRadius: 8.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ]
              : const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              piece.length,
              (r) => Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  piece[r].length,
                  (c) => Container(
                    width: 13.0,
                    height: 13.0,
                    margin: const EdgeInsets.all(1.5),
                    decoration: BoxDecoration(
                      color: piece[r][c] == 1 ? color : Colors.transparent,
                      borderRadius: BorderRadius.circular(3.5),
                      boxShadow: piece[r][c] == 1
                          ? const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 2.0,
                                offset: Offset(0.0, 1.0),
                              ),
                            ]
                          : null,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showGameOverDialog(String lang) {
    final gameState = Provider.of<GameStateProvider>(context, listen: false);
    final score = gameState.currentScore;
    final best = gameState.currentPlayer?.highScore ?? 0;
    final isNewRecord = score > _playerHighScore && score > 0;
    final coinsEarned = (score ~/ 50) + 10;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF155E9E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26.0),
          side: const BorderSide(color: Color(0xFFFFD54F), width: 2.5),
        ),
        title: Column(
          children: [
            Icon(
              isNewRecord
                  ? Icons.emoji_events_rounded
                  : Icons.sports_score_rounded,
              color: const Color(0xFFFFD54F),
              size: 52.0,
            ),
            const SizedBox(height: 8.0),
            Text(
              isNewRecord
                  ? AppStrings.tr('new_record', lang)
                  : AppStrings.tr('game_over', lang),
              style: TextStyle(
                color: isNewRecord ? const Color(0xFFFFD54F) : Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 24.0,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 16.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF0E3D70),
                borderRadius: BorderRadius.circular(18.0),
                border: Border.all(color: const Color(0xFF42A5F5), width: 1.5),
              ),
              child: Column(
                children: [
                  Text(
                    AppStrings.tr('final_score', lang),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    '${score}',
                    style: const TextStyle(
                      color: Color(0xFFFFD54F),
                      fontSize: 32.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Divider(color: Colors.white24, height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.tr('coins_earned', lang),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.monetization_on_rounded,
                            color: Color(0xFFFFD54F),
                            size: 18.0,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            '+${coinsEarned}',
                            style: const TextStyle(
                              color: Color(0xFFFFD54F),
                              fontWeight: FontWeight.w900,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            _buildDialogButton(
              title: AppStrings.tr('play_classic', lang),
              topColor: const Color(0xFF8BC34A),
              bottomColor: const Color(0xFF689F38),
              onTap: () {
                Navigator.pop(ctx);
                _resetGame();
              },
            ),
            const SizedBox(height: 10.0),
            _buildDialogButton(
              title: AppStrings.tr('main_menu', lang),
              topColor: const Color(0xFF0E3D70),
              bottomColor: const Color(0xFF0A2E66),
              onTap: () {
                Navigator.pop(ctx);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
