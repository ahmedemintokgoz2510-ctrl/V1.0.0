import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:crazy_block_online/providers/game_state.dart';
import 'package:crazy_block_online/app_strings.dart';
import 'package:crazy_block_online/theme/app_theme.dart';
import 'package:provider/provider.dart';

@NowaGenerated()
class AccountScreen extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() {
    return _AccountScreenState();
  }
}

@NowaGenerated()
class _AccountScreenState extends State<AccountScreen> {
  void _showEditProfileDialog(
    BuildContext context,
    GameStateProvider gameState,
    String lang,
  ) {
    final player = gameState.currentPlayer;
    final nameController = TextEditingController(text: player?.name ?? '');
    final emailController = TextEditingController(text: player?.email ?? '');
    final phoneController = TextEditingController(text: player?.phone ?? '');
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
            AppStrings.tr('edit_profile', lang),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 19.0,
            ),
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  labelText: AppStrings.tr('username', lang),
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: const Color(0xFF0E3D70),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 12.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.0),
                    borderSide: const BorderSide(color: Color(0xFF1E88E5)),
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: emailController,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  labelText: AppStrings.tr('email', lang),
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: const Color(0xFF0E3D70),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 12.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.0),
                    borderSide: const BorderSide(color: Color(0xFF1E88E5)),
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: phoneController,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  labelText: 'Telefon / Phone',
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: const Color(0xFF0E3D70),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 12.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.0),
                    borderSide: const BorderSide(color: Color(0xFF1E88E5)),
                  ),
                ),
              ),
            ],
          ),
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
              backgroundColor: const Color(0xFF7CB342),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 10.0,
              ),
            ),
            onPressed: () {
              if (nameController.text.trim().isNotEmpty) {
                gameState.initializePlayer(
                  nameController.text.trim(),
                  emailController.text.trim(),
                  phone: phoneController.text.trim(),
                );
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profile updated successfully!'),
                    backgroundColor: Color(0xFF689F38),
                  ),
                );
              }
            },
            child: Text(
              AppStrings.tr('save', lang),
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

  void _showDeleteAccountDialog(
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
          side: const BorderSide(color: Color(0xFFEF5350), width: 2.0),
        ),
        title: Center(
          child: Text(
            AppStrings.tr('delete_account', lang),
            style: const TextStyle(
              color: Color(0xFFFF8A80),
              fontWeight: FontWeight.bold,
              fontSize: 19.0,
            ),
          ),
        ),
        content: Text(
          AppStrings.tr('delete_account_confirm', lang),
          style: const TextStyle(color: Colors.white70, fontSize: 13.5),
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
              backgroundColor: const Color(0xFFC62828),
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
              AppStrings.tr('delete', lang),
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
              final player = gameState.currentPlayer;
              final playerName = player?.name.isNotEmpty == true
                  ? player!.name
                  : AppStrings.tr('player', lang);
              final playerId = player?.id.isNotEmpty == true
                  ? player!.id
                  : gameState.persistentPlayerId;
              final highScore = player?.highScore ?? gameState.currentScore;
              final coins = gameState.currentCoins;
              final leagueKey = player?.leagueKey ?? 'league_bronze';
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
                          _buildProfileCard(
                            playerName,
                            playerId,
                            leagueKey,
                            lang,
                            gameState,
                          ),
                          const SizedBox(height: 14.0),
                          _buildCareerStatsCard(
                            highScore,
                            coins,
                            leagueKey,
                            lang,
                          ),
                          const SizedBox(height: 14.0),
                          _buildAccountSecurityCard(gameState, lang),
                          const SizedBox(height: 14.0),
                          _buildDangerZoneCard(gameState, lang),
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
              const Text('👤', style: TextStyle(fontSize: 18.0)),
              const SizedBox(width: 6.0),
              Text(
                AppStrings.tr('account', lang).toUpperCase(),
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

  Widget _buildProfileCard(
    String playerName,
    String playerId,
    String leagueKey,
    String lang,
    GameStateProvider gameState,
  ) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: const Color(0xFF155E9E).withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: const Color(0xFF64B5F6), width: 1.5),
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
          Container(
            width: 56.0,
            height: 56.0,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: const [Color(0xFF42A5F5), Color(0xFF1E88E5)],
              ),
              borderRadius: BorderRadius.circular(18.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4.0,
                  offset: Offset(0.0, 2.0),
                ),
              ],
            ),
            child: Center(
              child: Text(
                playerName.isNotEmpty ? playerName[0].toUpperCase() : 'P',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  playerName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3.0),
                Text(
                  'ID: #${playerId}',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 3.0,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0E3D70),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: const Color(0xFFFFD54F),
                      width: 1.0,
                    ),
                  ),
                  child: Text(
                    AppStrings.tr(leagueKey, lang).toUpperCase(),
                    style: const TextStyle(
                      color: Color(0xFFFFD54F),
                      fontSize: 10.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _showEditProfileDialog(context, gameState, lang),
            child: Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: const Color(0xFF0E3D70),
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(color: const Color(0xFF42A5F5), width: 1.5),
              ),
              child: const Icon(
                Icons.edit_rounded,
                color: Color(0xFF90CAF9),
                size: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCareerStatsCard(
    int highScore,
    int coins,
    String leagueKey,
    String lang,
  ) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: const Color(0xFF155E9E).withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(24.0),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.tr('career_stats', lang),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11.5,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  icon: Icons.emoji_events_rounded,
                  iconColor: const Color(0xFFFFD54F),
                  title: AppStrings.tr('high_score', lang),
                  value: '${highScore}',
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.monetization_on_rounded,
                  iconColor: const Color(0xFFFFD54F),
                  title: AppStrings.tr('coins', lang),
                  value: '${coins}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFF0E3D70),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFF1E88E5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 22.0),
          const SizedBox(height: 6.0),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19.0,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.75),
              fontSize: 10.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSecurityCard(GameStateProvider gameState, String lang) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: const Color(0xFF155E9E).withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(24.0),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.tr('security', lang),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11.5,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 12.0),
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Password update link sent to your email!'),
                  backgroundColor: Color(0xFF155E9E),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14.0,
                vertical: 12.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF0E3D70),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: const Color(0xFF1E88E5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.lock_reset_rounded,
                        color: Color(0xFF90CAF9),
                        size: 20.0,
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        AppStrings.tr('change_password', lang),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white60,
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

  Widget _buildDangerZoneCard(GameStateProvider gameState, String lang) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: const Color(0xFFB71C1C).withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: const Color(0xFFEF5350).withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.tr('danger_zone', lang),
            style: const TextStyle(
              color: Color(0xFFFF8A80),
              fontSize: 11.5,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 10.0),
          GestureDetector(
            onTap: () => _showDeleteAccountDialog(context, gameState, lang),
            child: Container(
              height: 44.0,
              decoration: BoxDecoration(
                color: const Color(0xFFC62828),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: const Color(0xFFEF5350)),
              ),
              child: Center(
                child: Text(
                  AppStrings.tr('delete_account', lang).toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
