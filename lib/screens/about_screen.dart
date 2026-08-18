import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:crazy_block_online/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:crazy_block_online/providers/game_state.dart';
import 'package:crazy_block_online/app_strings.dart';

@NowaGenerated()
class AboutScreen extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const AboutScreen({super.key});

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
                  _buildHeader(context, lang),
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
                          _buildBrandCard(lang),
                          const SizedBox(height: 14.0),
                          _buildInfoSection(lang),
                          const SizedBox(height: 14.0),
                          _buildCreditsSection(lang),
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

  Widget _buildHeader(BuildContext context, String lang) {
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
              const Text('ℹ️', style: TextStyle(fontSize: 18.0)),
              const SizedBox(width: 6.0),
              Text(
                AppStrings.tr('about', lang).toUpperCase(),
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

  Widget _buildBrandCard(String lang) {
    return Container(
      padding: const EdgeInsets.all(20.0),
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildMiniJelly('C', const Color(0xFF29B6F6)),
              _buildMiniJelly('R', const Color(0xFF66BB6A)),
              _buildMiniJelly('A', const Color(0xFFFF9800)),
              _buildMiniJelly('Z', const Color(0xFFEC407A)),
              _buildMiniJelly('Y', const Color(0xFFAB47BC)),
            ],
          ),
          const SizedBox(height: 6.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildMiniBlock('B', const Color(0xFF00BCD4)),
              _buildMiniBlock('L', const Color(0xFFFF9800)),
              _buildMiniBlock('O', const Color(0xFF4CAF50)),
              _buildMiniBlock('C', const Color(0xFFFFC107)),
              _buildMiniBlock('K', const Color(0xFFE91E63)),
            ],
          ),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 4.0,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF0D47A1),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Text(
              'ONLINE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.0,
                fontWeight: FontWeight.w900,
                letterSpacing: 4.0,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 3.0,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF7CB342),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              AppStrings.tr('version', lang),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11.5,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniJelly(String char, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 3.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.5),
          width: 1.0,
        ),
      ),
      child: Text(
        char,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildMiniBlock(String char, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 3.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.5),
          width: 1.0,
        ),
      ),
      child: Text(
        char,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildInfoSection(String lang) {
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
            AppStrings.tr('about_game', lang),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            AppStrings.tr('game_description', lang),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13.0,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16.0),
          _buildFeatureRow('Classic 8x8 Grid Puzzle Dynamics'),
          _buildFeatureRow('Shop: Blocks, Backgrounds & Sound Effects'),
          _buildFeatureRow('League Rankings & High Score Records'),
          _buildFeatureRow('Multi-language Localization (5 Languages)'),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_rounded,
            color: Color(0xFF7CB342),
            size: 18.0,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreditsSection(String lang) {
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
            AppStrings.tr('credits', lang),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            AppStrings.tr('made_by', lang),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            AppStrings.tr('made_with_love', lang),
            style: const TextStyle(color: Colors.white70, fontSize: 12.5),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: _buildSocialPill(
                  icon: Icons.language_rounded,
                  label: AppStrings.tr('website', lang),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: _buildSocialPill(
                  icon: Icons.headset_mic_rounded,
                  label: AppStrings.tr('support', lang),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialPill({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: const Color(0xFF0E3D70),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: const Color(0xFF42A5F5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFF90CAF9), size: 18.0),
          const SizedBox(width: 6.0),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
