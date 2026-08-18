import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:crazy_block_online/app_strings.dart';
import 'package:crazy_block_online/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:crazy_block_online/providers/game_state.dart';
import 'package:crazy_block_online/screens/game_screen.dart';
import 'package:crazy_block_online/screens/market_screen.dart';
import 'package:crazy_block_online/screens/social_screen.dart';
import 'package:crazy_block_online/screens/settings_screen.dart';

@NowaGenerated()
class MainMenuScreen extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const MainMenuScreen({Key? key, required this.onLogout});

  final void Function() onLogout;

  @override
  State<MainMenuScreen> createState() {
    return _MainMenuScreenState();
  }
}

@NowaGenerated()
class _MainMenuScreenState extends State<MainMenuScreen>
    with TickerProviderStateMixin {
  late AnimationController _slideController;

  late Animation<Offset> _slideAnimation;

  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.06), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));
    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  void _navigateTo(Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
  }

  String _getLeagueName(String leagueKey, String lang) {
    return AppStrings.tr(leagueKey, lang);
  }

  Color _getLeagueColor(String leagueKey) {
    switch (leagueKey) {
      case 'league_world':
        return const Color(0xFFEF5350);
      case 'league_diamond':
        return const Color(0xFF26C6DA);
      case 'league_gold':
        return const Color(0xFFFFB300);
      case 'league_silver':
        return const Color(0xFFB0BEC5);
      default:
        return const Color(0xFFFFA726);
    }
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
              final player = gameState.currentPlayer;
              final playerName = player?.name.isNotEmpty == true
                  ? player!.name
                  : AppStrings.tr('player', lang);
              final playerId = player?.id.isNotEmpty == true
                  ? player!.id
                  : gameState.persistentPlayerId;
              final highScore = player?.highScore ?? gameState.currentScore;
              final friendsCount = gameState.friends.length;
              final leagueKey = player?.leagueKey ?? 'league_bronze';
              final leagueColor = _getLeagueColor(leagueKey);
              return LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _buildPlayerHeader(
                                  playerName,
                                  playerId,
                                  highScore,
                                  lang,
                                ),
                                const SizedBox(height: 10.0),
                                _buildLeagueRankingBanner(
                                  leagueKey,
                                  leagueColor,
                                  highScore,
                                  lang,
                                ),
                                const SizedBox(height: 14.0),
                                _buildHeroPlayCard(highScore, lang),
                                const SizedBox(height: 12.0),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildSecondaryModeCard(
                                        title: AppStrings.tr('online', lang),
                                        subtitle: AppStrings.tr(
                                          'multiplayer',
                                          lang,
                                        ),
                                        icon: Icons.sports_esports_rounded,
                                        badgeText: AppStrings.tr('pvp', lang),
                                        topColor: const Color(0xFF42A5F5),
                                        bottomColor: const Color(0xFF1976D2),
                                        shadowColor: const Color(0xFF0D47A1),
                                        onTap: () {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                AppStrings.tr(
                                                  'coming_soon_online',
                                                  lang,
                                                ),
                                              ),
                                              duration: const Duration(
                                                seconds: 2,
                                              ),
                                              backgroundColor: const Color(
                                                0xFF155E9E,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Expanded(
                                      child: _buildSecondaryModeCard(
                                        title: AppStrings.tr(
                                          'mini_games',
                                          lang,
                                        ),
                                        subtitle: AppStrings.tr(
                                          'arcade_fun',
                                          lang,
                                        ),
                                        icon: Icons.videogame_asset_rounded,
                                        badgeText: AppStrings.tr(
                                          'new_badge',
                                          lang,
                                        ),
                                        topColor: const Color(0xFFAB47BC),
                                        bottomColor: const Color(0xFF7B1FA2),
                                        shadowColor: const Color(0xFF4A148C),
                                        onTap: () {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                AppStrings.tr(
                                                  'coming_soon_mini',
                                                  lang,
                                                ),
                                              ),
                                              duration: const Duration(
                                                seconds: 2,
                                              ),
                                              backgroundColor: const Color(
                                                0xFF155E9E,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14.0),
                                _buildQuickAccessSection(friendsCount, lang),
                                const SizedBox(height: 8.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerHeader(
    String playerName,
    String playerId,
    int highScore,
    String lang,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFF155E9E).withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(22.0),
        border: Border.all(color: const Color(0xFF64B5F6), width: 2.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0A2E66).withValues(alpha: 0.35),
            blurRadius: 12.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  playerName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.5,
                    fontWeight: FontWeight.w900,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2.0),
                Text(
                  'ID: #${playerId}',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 7.0,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF0E3D70),
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: const Color(0xFFFFD54F), width: 1.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.emoji_events_rounded,
                  color: Color(0xFFFFD54F),
                  size: 20.0,
                ),
                const SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppStrings.tr('high_score', lang).toUpperCase(),
                      style: const TextStyle(
                        fontSize: 9.0,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFFFD54F),
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      '${highScore}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeagueRankingBanner(
    String leagueKey,
    Color leagueColor,
    int highScore,
    String lang,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: const Color(0xFF104F8A).withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(
          color: leagueColor.withValues(alpha: 0.7),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: leagueColor.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.shield_rounded,
                  color: leagueColor,
                  size: 18.0,
                ),
              ),
              const SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.tr('league', lang).toUpperCase(),
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.65),
                      fontSize: 9.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                  ),
                  Text(
                    _getLeagueName(leagueKey, lang),
                    style: TextStyle(
                      color: leagueColor,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 4.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.leaderboard_rounded,
                  color: Colors.white,
                  size: 14.0,
                ),
                const SizedBox(width: 5.0),
                Text(
                  '#1 in ${_getLeagueName(leagueKey, lang)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroPlayCard(int highScore, String lang) {
    return GestureDetector(
      onTap: () => _navigateTo(const GameScreen()),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: const [Color(0xFF8BC34A), Color(0xFF689F38)],
          ),
          borderRadius: BorderRadius.circular(26.0),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.4),
            width: 2.0,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFF33691E),
              blurRadius: 0.0,
              offset: Offset(0.0, 5.0),
            ),
            BoxShadow(
              color: Colors.black26,
              blurRadius: 12.0,
              offset: Offset(0.0, 8.0),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 3.5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.bolt_rounded,
                          color: Color(0xFFFFD54F),
                          size: 14.0,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          AppStrings.tr('main_game_mode', lang),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    AppStrings.tr('play_classic', lang),
                    style: const TextStyle(
                      color: Colors.white,
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
                  const SizedBox(height: 3.0),
                  Text(
                    AppStrings.tr('play_classic_sub', lang),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12.0),
            Container(
              width: 58.0,
              height: 58.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8.0,
                    offset: Offset(0.0, 4.0),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: Color(0xFF558B2F),
                  size: 42.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecondaryModeCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required String badgeText,
    required Color topColor,
    required Color bottomColor,
    required Color shadowColor,
    required void Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100.0,
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [topColor, bottomColor],
          ),
          borderRadius: BorderRadius.circular(22.0),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.35),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 0.0,
              offset: const Offset(0.0, 4.0),
            ),
            const BoxShadow(
              color: Colors.black26,
              blurRadius: 8.0,
              offset: Offset(0.0, 6.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: Colors.white, size: 24.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7.0,
                    vertical: 2.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    badgeText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w900,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessSection(int friendsCount, String lang) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4.0,
              height: 14.0,
              decoration: BoxDecoration(
                color: const Color(0xFFFFD54F),
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              AppStrings.tr('quick_access', lang).toUpperCase(),
              style: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: _buildHubCard(
                title: AppStrings.tr('market', lang),
                subtitle: AppStrings.tr('market_sub', lang),
                icon: '🛍️',
                topColor: const Color(0xFF1E88E5),
                bottomColor: const Color(0xFF1565C0),
                onTap: () => _navigateTo(const MarketScreen()),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: _buildHubCard(
                title: AppStrings.tr('social', lang),
                subtitle: '${friendsCount} ${AppStrings.tr('friends', lang)}',
                icon: '👥',
                topColor: const Color(0xFF1E88E5),
                bottomColor: const Color(0xFF1565C0),
                onTap: () => _navigateTo(const SocialScreen()),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: _buildHubCard(
                title: AppStrings.tr('settings', lang),
                subtitle: AppStrings.tr('settings_sub', lang),
                icon: '⚙️',
                topColor: const Color(0xFF1E88E5),
                bottomColor: const Color(0xFF1565C0),
                onTap: () => _navigateTo(const SettingsScreen()),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHubCard({
    required String title,
    required String subtitle,
    required String icon,
    required Color topColor,
    required Color bottomColor,
    required void Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [topColor, bottomColor],
          ),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.3),
            width: 1.5,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFF0D47A1),
              blurRadius: 0.0,
              offset: Offset(0.0, 3.0),
            ),
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(icon, style: const TextStyle(fontSize: 18.0)),
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13.0,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2.0),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 10.0,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
