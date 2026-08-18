import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:crazy_block_online/theme/app_theme.dart';

@NowaGenerated()
class LoadingScreen extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const LoadingScreen({Key? key, required this.onLoadingComplete});

  final void Function() onLoadingComplete;

  @override
  State<LoadingScreen> createState() {
    return _LoadingScreenState();
  }
}

@NowaGenerated()
class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.96, end: 1.04).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _startLoadingSequence();
  }

  Future<void>? _startLoadingSequence() async {
    await Future.delayed(const Duration(milliseconds: 1800));
    if (mounted) {
      widget.onLoadingComplete();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppTheme.bgGradient),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 40.0,
                left: 30.0,
                child: _buildFloatingBlock(
                  const Color(0xFFEF5350),
                  const Color(0xFFC62828),
                  -0.2,
                  26.0,
                ),
              ),
              Positioned(
                top: 25.0,
                right: 40.0,
                child: _buildFloatingBlock(
                  const Color(0xFFFFB300),
                  const Color(0xFFFF8F00),
                  0.3,
                  30.0,
                ),
              ),
              Positioned(
                top: 100.0,
                right: 20.0,
                child: _buildFloatingBlock(
                  const Color(0xFFAB47BC),
                  const Color(0xFF7B1FA2),
                  -0.15,
                  24.0,
                ),
              ),
              Positioned(
                top: 140.0,
                left: 20.0,
                child: _buildFloatingBlock(
                  const Color(0xFF42A5F5),
                  const Color(0xFF1976D2),
                  0.25,
                  22.0,
                ),
              ),
              Positioned(
                bottom: 140.0,
                left: 35.0,
                child: _buildFloatingBlock(
                  const Color(0xFFFFCA28),
                  const Color(0xFFFFA000),
                  -0.3,
                  28.0,
                ),
              ),
              Positioned(
                bottom: 150.0,
                right: 30.0,
                child: _buildFloatingBlock(
                  const Color(0xFFEF5350),
                  const Color(0xFFC62828),
                  0.2,
                  26.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 20.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(14.0),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.25),
                            width: 1.0,
                          ),
                        ),
                        child: const Text(
                          'v0.9',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) => Transform.scale(
                        scale: _pulseAnimation.value,
                        child: _buildOfficialStyledLogo(),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildColorDotSpinner(),
                        const SizedBox(height: 16.0),
                        const Text(
                          'Loading...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                            shadows: const [
                              Shadow(
                                color: Color(0xFF0D47A1),
                                blurRadius: 8.0,
                                offset: Offset(0.0, 2.0),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24.0),
                        Text(
                          'Made by Zodiac',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.6),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingBlock(
    Color topColor,
    Color bottomColor,
    double angle,
    double size,
  ) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [topColor, bottomColor],
          ),
          borderRadius: BorderRadius.circular(size * 0.25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 8.0,
              offset: const Offset(0.0, 4.0),
            ),
          ],
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.35),
            width: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _buildOfficialStyledLogo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      decoration: BoxDecoration(
        color: const Color(0xFF104F8A).withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(32.0),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0D47A1).withValues(alpha: 0.35),
            blurRadius: 20.0,
            offset: const Offset(0.0, 8.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildJellyLetter('C', const Color(0xFF29B6F6)),
              _buildJellyLetter('R', const Color(0xFF66BB6A)),
              _buildJellyLetter('A', const Color(0xFFFF9800)),
              _buildJellyLetter('Z', const Color(0xFFEC407A)),
              _buildJellyLetter('Y', const Color(0xFFAB47BC)),
            ],
          ),
          const SizedBox(height: 6.0),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildBlockLetter('B', const Color(0xFF00BCD4)),
              _buildBlockLetter('L', const Color(0xFFFF9800)),
              _buildBlockLetter('O', const Color(0xFF4CAF50)),
              _buildBlockLetter('C', const Color(0xFFFFC107)),
              _buildBlockLetter('K', const Color(0xFFE91E63)),
            ],
          ),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 4.0,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF0D47A1).withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: const Text(
              'ONLINE',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 6.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJellyLetter(String char, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 4.0,
            offset: const Offset(0.0, 3.0),
          ),
        ],
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.4),
          width: 1.5,
        ),
      ),
      child: Text(
        char,
        style: const TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          shadows: const [
            Shadow(
              color: Colors.black38,
              blurRadius: 4.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlockLetter(String char, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 4.0,
            offset: const Offset(0.0, 3.0),
          ),
        ],
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.4),
          width: 1.5,
        ),
      ),
      child: Text(
        char,
        style: const TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          shadows: const [
            Shadow(
              color: Colors.black38,
              blurRadius: 4.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorDotSpinner() {
    final colors = [
      const Color(0xFFEF5350),
      const Color(0xFFFFA726),
      const Color(0xFFFFEE58),
      const Color(0xFF66BB6A),
      const Color(0xFF29B6F6),
      const Color(0xFFAB47BC),
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        colors.length,
        (i) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
            color: colors[i],
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: colors[i].withValues(alpha: 0.6),
                blurRadius: 4.0,
                offset: const Offset(0.0, 2.0),
              ),
            ],
            border: Border.all(color: Colors.white, width: 1.0),
          ),
        ),
      ),
    );
  }
}
