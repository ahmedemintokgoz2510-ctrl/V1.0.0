import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:crazy_block_online/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:crazy_block_online/providers/game_state.dart';
import 'package:crazy_block_online/app_strings.dart';

@NowaGenerated()
class LanguageScreen extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const LanguageScreen({Key? key});

  @override
  State<LanguageScreen> createState() {
    return _LanguageScreenState();
  }
}

@NowaGenerated()
class _LanguageScreenState extends State<LanguageScreen> {
  final List<Map<String, String>> _languages = [
    {'name': 'Türkçe', 'native': 'Türkçe', 'flag': '🇹🇷'},
    {'name': 'English', 'native': 'English', 'flag': '🇬🇧'},
    {'name': 'Deutsch', 'native': 'Deutsch', 'flag': '🇩🇪'},
    {'name': 'Español', 'native': 'Español', 'flag': '🇪🇸'},
    {'name': 'Français', 'native': 'Français', 'flag': '🇫🇷'},
  ];

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
              final currentLang = gameState.selectedLanguage;
              return Column(
                children: [
                  _buildHeader(currentLang),
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
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFF155E9E,
                              ).withValues(alpha: 0.95),
                              borderRadius: BorderRadius.circular(24.0),
                              border: Border.all(
                                color: const Color(0xFF64B5F6),
                                width: 1.5,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6.0,
                                  offset: Offset(0.0, 3.0),
                                ),
                              ],
                            ),
                            child: Column(
                              children: List.generate(_languages.length, (
                                index,
                              ) {
                                final langItem = _languages[index];
                                final langName = langItem['name'];
                                final native = langItem['native'];
                                final flag = langItem['flag'];
                                final isSelected = currentLang == langName;
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        gameState.setLanguage(langName!);
                                      },
                                      child: Container(
                                        color: Colors.transparent,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                          vertical: 14.0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  flag!,
                                                  style: const TextStyle(
                                                    fontSize: 24.0,
                                                  ),
                                                ),
                                                const SizedBox(width: 14.0),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      native!,
                                                      style: TextStyle(
                                                        color: isSelected
                                                            ? Colors.white
                                                            : Colors.white70,
                                                        fontSize: 15.5,
                                                        fontWeight: isSelected
                                                            ? FontWeight.w900
                                                            : FontWeight.w600,
                                                      ),
                                                    ),
                                                    Text(
                                                      langName!,
                                                      style: const TextStyle(
                                                        color: Colors.white38,
                                                        fontSize: 11.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            if (isSelected)
                                              Container(
                                                width: 30.0,
                                                height: 30.0,
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                    0xFF7CB342,
                                                  ),
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 1.5,
                                                  ),
                                                ),
                                                child: const Icon(
                                                  Icons.check_rounded,
                                                  color: Colors.white,
                                                  size: 20.0,
                                                ),
                                              )
                                            else
                                              Container(
                                                width: 24.0,
                                                height: 24.0,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: Colors.white30,
                                                    width: 1.5,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (index < _languages.length - 1)
                                      Divider(
                                        color: Colors.white.withValues(
                                          alpha: 0.12,
                                        ),
                                        height: 1.0,
                                      ),
                                  ],
                                );
                              }),
                            ),
                          ),
                          const SizedBox(height: 18.0),
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFF155E9E,
                              ).withValues(alpha: 0.6),
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                color: const Color(0xFF42A5F5),
                              ),
                            ),
                            child: const Row(
                              children: const [
                                Icon(
                                  Icons.auto_awesome_rounded,
                                  color: Color(0xFFFFD54F),
                                  size: 22.0,
                                ),
                                SizedBox(width: 12.0),
                                Expanded(
                                  child: Text(
                                    'Language changes are applied instantly throughout menus, gameplay, and dialogs.',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.5,
                                      height: 1.3,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
              const Text('🌐', style: TextStyle(fontSize: 18.0)),
              const SizedBox(width: 6.0),
              Text(
                AppStrings.tr('language', lang).toUpperCase(),
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
}
