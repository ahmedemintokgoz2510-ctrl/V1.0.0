import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:crazy_block_online/providers/game_state.dart';
import 'package:crazy_block_online/app_strings.dart';
import 'package:crazy_block_online/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:crazy_block_online/screens/account_screen.dart';
import 'package:crazy_block_online/screens/language_screen.dart';
import 'package:crazy_block_online/screens/about_screen.dart';

@NowaGenerated()
class SettingsScreen extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const SettingsScreen({Key? key});

  @override
  State<SettingsScreen> createState() {
    return _SettingsScreenState();
  }
}

@NowaGenerated()
class _SettingsScreenState extends State<SettingsScreen> {
  void _showLogoutConfirmation(
    BuildContext context,
    GameStateProvider gameState,
    String lang,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF155E9E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
          side: const BorderSide(color: Color(0xFF64B5F6), width: 2.0),
        ),
        title: Center(
          child: Text(
            AppStrings.tr('logout', lang),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 20.0,
            ),
          ),
        ),
        content: const Text(
          'Are you sure you want to log out from this session?',
          style: TextStyle(color: Colors.white70, fontSize: 14.0),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              AppStrings.tr('cancel', lang),
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53935),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 10.0,
              ),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
              gameState.logout();
            },
            child: Text(
              AppStrings.tr('logout', lang),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
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
              return Column(
                children: [
                  _buildHeader(lang),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildSectionTitle(
                            AppStrings.tr('audio_settings', lang),
                          ),
                          const SizedBox(height: 8.0),
                          _buildAudioCard(gameState, lang),
                          const SizedBox(height: 18.0),
                          _buildSectionTitle(
                            AppStrings.tr('preferences_system', lang),
                          ),
                          const SizedBox(height: 8.0),
                          _buildNavigationCard(gameState, lang),
                          const SizedBox(height: 20.0),
                          _buildLogoutButton(gameState, lang),
                          const SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String lang) {
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
              const Text('⚙️', style: TextStyle(fontSize: 18.0)),
              const SizedBox(width: 6.0),
              Text(
                AppStrings.tr('settings', lang).toUpperCase(),
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
          const SizedBox(width: 44.0),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 11.5,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.0,
      ),
    );
  }

  Widget _buildAudioCard(GameStateProvider gameState, String lang) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF155E9E).withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(22.0),
        border: Border.all(color: const Color(0xFF64B5F6), width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6.0,
            offset: Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildToggleRow(
            icon: Icons.music_note_rounded,
            title: AppStrings.tr('music', lang),
            value: gameState.isMusicOn,
            onChanged: () => gameState.toggleMusic(),
          ),
          Divider(color: Colors.white.withValues(alpha: 0.15), height: 1.0),
          _buildToggleRow(
            icon: Icons.volume_up_rounded,
            title: AppStrings.tr('sfx', lang),
            value: gameState.isSfxOn,
            onChanged: () => gameState.toggleSfx(),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleRow({
    required IconData icon,
    required String title,
    required bool value,
    required void Function() onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 36.0,
                height: 36.0,
                decoration: BoxDecoration(
                  color: const Color(0xFF0E3D70),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Icon(icon, color: const Color(0xFF90CAF9), size: 20.0),
              ),
              const SizedBox(width: 12.0),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: onChanged,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 52.0,
              height: 28.0,
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: value
                    ? const Color(0xFF7CB342)
                    : const Color(0xFF0E3D70),
                border: Border.all(
                  color: value ? const Color(0xFF9CCC65) : Colors.white24,
                  width: 1.5,
                ),
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 200),
                alignment: value ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 22.0,
                  height: 22.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 2.0,
                        offset: Offset(0.0, 1.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationCard(GameStateProvider gameState, String lang) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF155E9E).withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(22.0),
        border: Border.all(color: const Color(0xFF64B5F6), width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6.0,
            offset: Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildNavTile(
            icon: Icons.person_rounded,
            title: AppStrings.tr('account', lang),
            trailingText:
                gameState.currentPlayer?.name ?? AppStrings.tr('player', lang),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AccountScreen()),
              );
            },
          ),
          Divider(color: Colors.white.withValues(alpha: 0.15), height: 1.0),
          _buildNavTile(
            icon: Icons.language_rounded,
            title: AppStrings.tr('language', lang),
            trailingText: lang,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const LanguageScreen()),
              );
            },
          ),
          Divider(color: Colors.white.withValues(alpha: 0.15), height: 1.0),
          _buildNavTile(
            icon: Icons.info_outline_rounded,
            title: AppStrings.tr('about', lang),
            trailingText: 'v0.9',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AboutScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavTile({
    required IconData icon,
    required String title,
    required String trailingText,
    required void Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 36.0,
                  height: 36.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0E3D70),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Icon(icon, color: const Color(0xFF90CAF9), size: 20.0),
                ),
                const SizedBox(width: 12.0),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  trailingText,
                  style: const TextStyle(
                    color: Color(0xFFFFD54F),
                    fontSize: 13.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 6.0),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white60,
                  size: 14.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(GameStateProvider gameState, String lang) {
    return GestureDetector(
      onTap: () => _showLogoutConfirmation(context, gameState, lang),
      child: Container(
        height: 48.0,
        decoration: BoxDecoration(
          color: const Color(0xFFC62828),
          borderRadius: BorderRadius.circular(18.0),
          border: Border.all(color: const Color(0xFFEF5350), width: 1.5),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.logout_rounded, color: Colors.white, size: 20.0),
            const SizedBox(width: 8.0),
            Text(
              AppStrings.tr('logout', lang).toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
