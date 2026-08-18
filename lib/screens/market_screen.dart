import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:crazy_block_online/providers/game_state.dart';
import 'package:crazy_block_online/app_strings.dart';
import 'package:crazy_block_online/theme/app_theme.dart';
import 'package:provider/provider.dart';

@NowaGenerated()
class MarketScreen extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const MarketScreen({Key? key});

  @override
  State<MarketScreen> createState() {
    return _MarketScreenState();
  }
}

@NowaGenerated()
class _MarketScreenState extends State<MarketScreen> {
  int _selectedTab = 0;

  final Set<String> _unlockedItems = {
    'Classic Color Blocks',
    'Classic Navy',
    'Default Laser',
  };

  final List<Map<String, dynamic>> _blockStyles = [
    {
      'id': 'Classic Color Blocks',
      'name': 'Classic Puzzle Blocks',
      'rarity': 'COMMON',
      'rarityColor': const Color(0xFF42A5F5),
      'price': 0,
      'previewColors': [const Color(0xFF42A5F5), const Color(0xFF1976D2)],
      'desc': 'Clean vibrant puzzle cubes with glossy rounded finish.',
    },
    {
      'id': 'Emerald Candy',
      'name': 'Emerald Candy',
      'rarity': 'RARE',
      'rarityColor': const Color(0xFF66BB6A),
      'price': 150,
      'previewColors': [const Color(0xFF81C784), const Color(0xFF388E3C)],
      'desc': 'Sweet emerald jelly blocks with smooth shine.',
    },
    {
      'id': 'Ruby Gem',
      'name': 'Ruby Crystals',
      'rarity': 'RARE',
      'rarityColor': const Color(0xFFEF5350),
      'price': 250,
      'previewColors': [const Color(0xFFEF5350), const Color(0xFFC62828)],
      'desc': 'Faceted jewel blocks with warm crimson glow.',
    },
    {
      'id': 'Amethyst Royale',
      'name': 'Amethyst Royale',
      'rarity': 'EPIC',
      'rarityColor': const Color(0xFFBA68C8),
      'price': 400,
      'previewColors': [const Color(0xFFBA68C8), const Color(0xFF7B1FA2)],
      'desc': 'Majestic royal purple cubes for elite puzzlers.',
    },
    {
      'id': 'Golden Champion',
      'name': 'Golden Champion',
      'rarity': 'LEGENDARY',
      'rarityColor': const Color(0xFFFFD54F),
      'price': 800,
      'previewColors': [const Color(0xFFFFE082), const Color(0xFFFF8F00)],
      'desc': 'Shimmering gold blocks for grand champions.',
    },
  ];

  final List<Map<String, dynamic>> _backgroundStyles = [
    {
      'id': 'Classic Navy',
      'name': 'Midnight Navy',
      'rarity': 'COMMON',
      'rarityColor': const Color(0xFF42A5F5),
      'price': 0,
      'previewColors': [const Color(0xFF1E88E5), const Color(0xFF0D47A1)],
      'desc': 'Deep balanced sky to royal blue puzzle atmosphere.',
    },
    {
      'id': 'Emerald Forest',
      'name': 'Emerald Grove',
      'rarity': 'RARE',
      'rarityColor': const Color(0xFF66BB6A),
      'price': 200,
      'previewColors': [const Color(0xFF2E7D32), const Color(0xFF1B5E20)],
      'desc': 'Calm organic green forest aura.',
    },
    {
      'id': 'Sunset Coral',
      'name': 'Sunset Coral',
      'rarity': 'EPIC',
      'rarityColor': const Color(0xFFFF7043),
      'price': 450,
      'previewColors': [const Color(0xFFFF7043), const Color(0xFFD84315)],
      'desc': 'Warm twilight orange and crimson gradient.',
    },
    {
      'id': 'Cosmic Purple',
      'name': 'Cosmic Violet',
      'rarity': 'LEGENDARY',
      'rarityColor': const Color(0xFFAB47BC),
      'price': 750,
      'previewColors': [const Color(0xFF8E24AA), const Color(0xFF4A148C)],
      'desc': 'Deep starry night with rich purple hue.',
    },
  ];

  final List<Map<String, dynamic>> _effectStyles = [
    {
      'id': 'Default Laser',
      'name': 'Color Burst FX',
      'rarity': 'COMMON',
      'rarityColor': const Color(0xFF42A5F5),
      'price': 0,
      'previewColors': [const Color(0xFF42A5F5), const Color(0xFF1976D2)],
      'desc': 'Crisp line clear burst with pop sounds.',
    },
    {
      'id': 'Arcade Chime',
      'name': 'Arcade Chimes',
      'rarity': 'RARE',
      'rarityColor': const Color(0xFFFFD54F),
      'price': 180,
      'previewColors': [const Color(0xFFFFD54F), const Color(0xFFFF8F00)],
      'desc': 'Retro melodic chimes on line clears.',
    },
    {
      'id': 'Cosmic Shockwave',
      'name': 'Sonic Pop FX',
      'rarity': 'EPIC',
      'rarityColor': const Color(0xFFAB47BC),
      'price': 350,
      'previewColors': [const Color(0xFFAB47BC), const Color(0xFF26C6DA)],
      'desc': 'Deep bass blast audio and particle shockwave.',
    },
  ];

  void _handleItemAction(
    Map<String, dynamic> item,
    GameStateProvider gameState,
    String lang,
  ) {
    final itemId = item['id'] as String;
    final price = item['price'] as int;
    final isUnlocked = _unlockedItems.contains(itemId) || price == 0;
    if (!isUnlocked) {
      if (gameState.currentCoins >= price) {
        final success = gameState.spendCoins(price);
        if (success) {
          setState(() {
            _unlockedItems.add(itemId);
          });
          _equipItem(itemId, gameState);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppStrings.tr('item_purchased', lang)),
              backgroundColor: const Color(0xFF689F38),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppStrings.tr('not_enough_coins', lang)),
            backgroundColor: AppTheme.buttonRed,
          ),
        );
      }
    } else {
      _equipItem(itemId, gameState);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppStrings.tr('item_equipped', lang)),
          backgroundColor: const Color(0xFF155E9E),
        ),
      );
    }
  }

  void _equipItem(String itemId, GameStateProvider gameState) {
    if (_selectedTab == 0) {
      gameState.setBlockStyle(itemId);
    } else if (_selectedTab == 1) {
      gameState.setBackground(itemId);
    } else {
      gameState.setGif(itemId);
    }
  }

  bool _isItemEquipped(String itemId, GameStateProvider gameState) {
    if (_selectedTab == 0) {
      return (gameState.selectedBlockStyle.isEmpty &&
              itemId == 'Classic Color Blocks') ||
          gameState.selectedBlockStyle == itemId;
    } else if (_selectedTab == 1) {
      return (gameState.selectedBackground.isEmpty &&
              itemId == 'Classic Navy') ||
          gameState.selectedBackground == itemId;
    } else {
      return (gameState.selectedGif.isEmpty && itemId == 'Default Laser') ||
          gameState.selectedGif == itemId;
    }
  }

  void _showCoinStoreModal(GameStateProvider gameState, String lang) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF155E9E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.0)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.monetization_on_rounded,
                      color: Color(0xFFFFD54F),
                      size: 24.0,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      AppStrings.tr('get_coins', lang),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded, color: Colors.white70),
                  onPressed: () => Navigator.pop(ctx),
                ),
              ],
            ),
            const SizedBox(height: 14.0),
            GestureDetector(
              onTap: () {
                Navigator.pop(ctx);
                gameState.watchAdForCoins();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppStrings.tr('ad_watched_reward', lang)),
                    backgroundColor: const Color(0xFF689F38),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: const [Color(0xFF8BC34A), Color(0xFF689F38)],
                  ),
                  borderRadius: BorderRadius.circular(18.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6.0,
                      offset: Offset(0.0, 3.0),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.play_circle_fill_rounded,
                      color: Colors.white,
                      size: 28.0,
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Text(
                        AppStrings.tr('watch_ad_coins', lang),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                      size: 16.0,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            _buildCoinPackageTile(500, '\$0.99', gameState, lang, ctx),
            const SizedBox(height: 8.0),
            _buildCoinPackageTile(1500, '\$2.49', gameState, lang, ctx),
            const SizedBox(height: 8.0),
            _buildCoinPackageTile(5000, '\$5.99', gameState, lang, ctx),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  Widget _buildCoinPackageTile(
    int coins,
    String price,
    GameStateProvider gameState,
    String lang,
    BuildContext modalCtx,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(modalCtx);
        gameState.buyCoinPackage(coins);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('+${coins} Coins Purchased! ◈'),
            backgroundColor: const Color(0xFF689F38),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: const Color(0xFF0E3D70),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: const Color(0xFF42A5F5), width: 1.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.monetization_on_rounded,
                  color: Color(0xFFFFD54F),
                  size: 20.0,
                ),
                const SizedBox(width: 8.0),
                Text(
                  '${coins} ${AppStrings.tr('coins', lang)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: const [Color(0xFFFFD54F), Color(0xFFFFA000)],
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                price,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 13.0,
                ),
              ),
            ),
          ],
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
              final coins = gameState.currentCoins;
              return Column(
                children: [
                  _buildHeader(lang, coins, gameState),
                  const SizedBox(height: 12.0),
                  _buildTabBar(lang),
                  const SizedBox(height: 12.0),
                  Expanded(child: _buildItemList(gameState, lang)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String lang, int coins, GameStateProvider gameState) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 44.0,
              height: 44.0,
              decoration: BoxDecoration(
                color: const Color(0xFF155E9E),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: const Color(0xFF64B5F6), width: 1.8),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 18.0,
              ),
            ),
          ),
          Row(
            children: [
              const Text('🛍️', style: TextStyle(fontSize: 18.0)),
              const SizedBox(width: 6.0),
              Text(
                AppStrings.tr('market', lang).toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 19.0,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.8,
                  shadows: const [
                    Shadow(
                      color: Color(0xFF0D47A1),
                      blurRadius: 6.0,
                      offset: Offset(0.0, 2.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => _showCoinStoreModal(gameState, lang),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: const [Color(0xFFFFD54F), Color(0xFFFFA000)],
                ),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                  width: 1.0,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6.0,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.monetization_on_rounded,
                    color: Colors.white,
                    size: 16.0,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    '${coins}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 13.5,
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  const Icon(
                    Icons.add_circle_outline_rounded,
                    color: Colors.white,
                    size: 14.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(String lang) {
    final tabs = [
      AppStrings.tr('blocks_tab', lang),
      AppStrings.tr('backgrounds_tab', lang),
      AppStrings.tr('effects_tab', lang),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: const Color(0xFF104F8A),
          borderRadius: BorderRadius.circular(18.0),
          border: Border.all(color: const Color(0xFF42A5F5), width: 1.5),
        ),
        child: Row(
          children: List.generate(
            tabs.length,
            (idx) => Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedTab = idx;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 9.0),
                  decoration: BoxDecoration(
                    gradient: _selectedTab == idx
                        ? const LinearGradient(
                            colors: const [
                              Color(0xFF42A5F5),
                              Color(0xFF1E88E5),
                            ],
                          )
                        : null,
                    borderRadius: BorderRadius.circular(14.0),
                    boxShadow: _selectedTab == idx
                        ? const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4.0,
                              offset: Offset(0.0, 2.0),
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      tabs[idx],
                      style: TextStyle(
                        color: _selectedTab == idx
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.7),
                        fontSize: 12.0,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
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

  Widget _buildItemList(GameStateProvider gameState, String lang) {
    List<Map<String, dynamic>> items;
    if (_selectedTab == 0) {
      items = _blockStyles;
    } else if (_selectedTab == 1) {
      items = _backgroundStyles;
    } else {
      items = _effectStyles;
    }
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final itemId = item['id'] as String;
        final name = item['name'] as String;
        final rarity = item['rarity'] as String;
        final rarityColor = item['rarityColor'] as Color;
        final price = item['price'] as int;
        final desc = item['desc'] as String;
        final previewColors = item['previewColors'] as List<Color>;
        final isUnlocked = _unlockedItems.contains(itemId) || price == 0;
        final isEquipped = _isItemEquipped(itemId, gameState);
        return Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: const Color(0xFF155E9E).withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(22.0),
            border: Border.all(
              color: isEquipped
                  ? const Color(0xFFFFD54F)
                  : const Color(0xFF42A5F5),
              width: isEquipped ? 2.2 : 1.2,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8.0,
                offset: Offset(0.0, 4.0),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 56.0,
                height: 56.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: previewColors),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6.0,
                      offset: Offset(0.0, 3.0),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.4),
                    width: 1.2,
                  ),
                ),
                child: Center(
                  child: Icon(
                    _selectedTab == 0
                        ? Icons.grid_view_rounded
                        : _selectedTab == 1
                        ? Icons.wallpaper_rounded
                        : Icons.auto_fix_high_rounded,
                    color: Colors.white,
                    size: 26.0,
                  ),
                ),
              ),
              const SizedBox(width: 14.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.5,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 6.0),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6.0,
                            vertical: 2.0,
                          ),
                          decoration: BoxDecoration(
                            color: rarityColor.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Text(
                            rarity,
                            style: TextStyle(
                              color: rarityColor,
                              fontSize: 8.5,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3.0),
                    Text(
                      desc,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 11.0,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10.0),
              _buildItemActionButton(
                isEquipped: isEquipped,
                isUnlocked: isUnlocked,
                price: price,
                lang: lang,
                onTap: () => _handleItemAction(item, gameState, lang),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildItemActionButton({
    required bool isEquipped,
    required bool isUnlocked,
    required int price,
    required String lang,
    required void Function() onTap,
  }) {
    if (isEquipped) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: const Color(0xFF689F38),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.4),
            width: 1.0,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_rounded, color: Colors.white, size: 14.0),
            const SizedBox(width: 4.0),
            Text(
              AppStrings.tr('equipped', lang),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11.0,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      );
    }
    if (isUnlocked) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: const Color(0xFF0E3D70),
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: const Color(0xFF42A5F5), width: 1.5),
          ),
          child: Text(
            AppStrings.tr('equip', lang),
            style: const TextStyle(
              color: Color(0xFF90CAF9),
              fontSize: 12.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: const [Color(0xFFFFD54F), Color(0xFFFFA000)],
          ),
          borderRadius: BorderRadius.circular(14.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.monetization_on_rounded,
              color: Colors.white,
              size: 14.0,
            ),
            const SizedBox(width: 4.0),
            Text(
              '${price}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12.5,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
