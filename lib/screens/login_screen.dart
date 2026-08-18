import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:crazy_block_online/providers/game_state.dart';
import 'package:provider/provider.dart';
import 'package:crazy_block_online/app_strings.dart';
import 'package:crazy_block_online/theme/app_theme.dart';
import 'package:crazy_block_online/screens/language_screen.dart';
import 'package:crazy_block_online/screens/create_account_screen.dart';

@NowaGenerated()
class LoginScreen extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const LoginScreen({Key? key, required this.onLoginSuccess});

  final void Function() onLoginSuccess;

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

@NowaGenerated()
class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      final emailText = _emailController.text.trim();
      final username = emailText.contains('@')
          ? emailText.split('@').first
          : emailText;
      final gameState = Provider.of<GameStateProvider>(context, listen: false);
      gameState.initializePlayer(username, emailText);
      widget.onLoginSuccess();
    }
  }

  void _handleGuestLogin() {
    final gameState = Provider.of<GameStateProvider>(context, listen: false);
    final lang = gameState.selectedLanguage;
    final playerId = gameState.persistentPlayerId;
    gameState.initializePlayer(
      '${AppStrings.tr('player', lang)}_${playerId.replaceAll('CBO-', '')}',
      'guest_${playerId}@crazyblock.io',
    );
    widget.onLoginSuccess();
  }

  void _handleGoogleLogin() {
    final gameState = Provider.of<GameStateProvider>(context, listen: false);
    gameState.initializePlayer('Google_Player', 'player@gmail.com');
    widget.onLoginSuccess();
  }

  void _showForgotPasswordDialog(String lang) {
    showDialog(
      context: context,
      builder: (dialogCtx) {
        final emailResetController = TextEditingController(
          text: _emailController.text,
        );
        return AlertDialog(
          backgroundColor: const Color(0xFF155E9E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
            side: const BorderSide(color: Color(0xFF64B5F6), width: 2.0),
          ),
          title: Center(
            child: Text(
              AppStrings.tr('forgot_password', lang),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 19.0,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.tr('enter_email', lang),
                style: const TextStyle(color: Colors.white, fontSize: 13.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 14.0),
              TextField(
                controller: emailResetController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'email@domain.com',
                  hintStyle: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                  filled: true,
                  fillColor: const Color(0xFF0E3D70),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 14.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: const BorderSide(color: Color(0xFF1E88E5)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: const BorderSide(color: Color(0xFF1E88E5)),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogCtx),
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
                  borderRadius: BorderRadius.circular(14.0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 10.0,
                ),
              ),
              onPressed: () {
                Navigator.pop(dialogCtx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Password reset instructions sent!'),
                    backgroundColor: Color(0xFF155E9E),
                  ),
                );
              },
              child: Text(
                AppStrings.tr('confirm', lang),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        );
      },
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
              return Stack(
                children: [
                  Positioned(
                    top: 20.0,
                    left: 20.0,
                    child: _buildSmallCandyBlock(const Color(0xFFEF5350), 22.0),
                  ),
                  Positioned(
                    top: 40.0,
                    right: 25.0,
                    child: _buildSmallCandyBlock(const Color(0xFFFFB300), 24.0),
                  ),
                  Positioned(
                    bottom: 30.0,
                    left: 25.0,
                    child: _buildSmallCandyBlock(const Color(0xFFAB47BC), 20.0),
                  ),
                  Positioned(
                    bottom: 40.0,
                    right: 20.0,
                    child: _buildSmallCandyBlock(const Color(0xFF66BB6A), 24.0),
                  ),
                  Center(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 14.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTopBar(lang),
                          const SizedBox(height: 12.0),
                          _buildAuthCard(gameState, lang),
                          const SizedBox(height: 14.0),
                          _buildGuestButton(lang),
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

  Widget _buildSmallCandyBlock(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(size * 0.25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 6.0,
            offset: const Offset(0.0, 3.0),
          ),
        ],
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.4),
          width: 1.0,
        ),
      ),
    );
  }

  Widget _buildTopBar(String lang) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
          ),
          child: const Text(
            'v0.9',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Text(
          AppStrings.tr('login', lang).toUpperCase(),
          style: const TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: 1.0,
            shadows: const [
              Shadow(
                color: Color(0xFF0D47A1),
                blurRadius: 6.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LanguageScreen()),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 4.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.language_rounded,
                  color: Colors.white,
                  size: 14.0,
                ),
                const SizedBox(width: 4.0),
                Text(
                  lang,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAuthCard(GameStateProvider gameState, String lang) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 22.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1E88E5).withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(28.0),
        border: Border.all(color: const Color(0xFF90CAF9), width: 2.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0A2E66).withValues(alpha: 0.4),
            blurRadius: 18.0,
            offset: const Offset(0.0, 8.0),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 44.0,
                height: 44.0,
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D47A1),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: Colors.white30, width: 1.2),
                ),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 3.0,
                  crossAxisSpacing: 3.0,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildMiniBlock(const Color(0xFFEF5350)),
                    _buildMiniBlock(const Color(0xFF4CAF50)),
                    _buildMiniBlock(const Color(0xFFFFCA28)),
                    _buildMiniBlock(const Color(0xFF29B6F6)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Center(
              child: Text(
                AppStrings.tr('welcome_back', lang),
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  shadows: const [
                    Shadow(
                      color: Colors.black26,
                      blurRadius: 4.0,
                      offset: Offset(0.0, 2.0),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18.0),
            _buildCustomInput(
              controller: _emailController,
              hintText: AppStrings.tr('email', lang),
              icon: Icons.mail_outline_rounded,
              keyboardType: TextInputType.emailAddress,
              validator: (val) {
                if (val == null || val!.trim().isEmpty) {
                  return AppStrings.tr('enter_email', lang);
                }
                return null;
              },
            ),
            const SizedBox(height: 12.0),
            _buildCustomInput(
              controller: _passwordController,
              hintText: AppStrings.tr('password', lang),
              icon: Icons.lock_outline_rounded,
              obscureText: _obscurePassword,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.white70,
                  size: 20.0,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              validator: (val) {
                if (val == null || val!.trim().isEmpty) {
                  return AppStrings.tr('enter_password', lang);
                }
                if (val!.trim().length < 6) {
                  return AppStrings.tr('min_password_len', lang);
                }
                return null;
              },
            ),
            const SizedBox(height: 8.0),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => _showForgotPasswordDialog(lang),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D47A1).withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    AppStrings.tr('forgot_password', lang),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            _build3DButton(
              title: AppStrings.tr('login', lang).toUpperCase(),
              topColor: const Color(0xFF8BC34A),
              bottomColor: const Color(0xFF689F38),
              borderColor: const Color(0xFF33691E),
              onTap: _handleLogin,
            ),
            const SizedBox(height: 14.0),
            Row(
              children: [
                Expanded(
                  child: Divider(color: Colors.white.withValues(alpha: 0.3)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'OR',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 11.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(color: Colors.white.withValues(alpha: 0.3)),
                ),
              ],
            ),
            const SizedBox(height: 14.0),
            GestureDetector(
              onTap: _handleGoogleLogin,
              child: Container(
                height: 48.0,
                decoration: BoxDecoration(
                  color: const Color(0xFF0E3D70),
                  borderRadius: BorderRadius.circular(18.0),
                  border: Border.all(
                    color: const Color(0xFF42A5F5),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 6.0,
                      offset: const Offset(0.0, 3.0),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 24.0,
                      height: 24.0,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          'G',
                          style: TextStyle(
                            color: Color(0xFF4285F4),
                            fontWeight: FontWeight.w900,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      AppStrings.tr('continue_google', lang).toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.tr('no_account', lang),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CreateAccountScreen(
                          onAccountCreated: widget.onLoginSuccess,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    AppStrings.tr('create_account', lang).toUpperCase(),
                    style: const TextStyle(
                      color: Color(0xFFFFD54F),
                      fontSize: 12.5,
                      fontWeight: FontWeight.w900,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniBlock(Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }

  Widget _buildCustomInput({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14.5,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white.withValues(alpha: 0.55),
          fontSize: 13.5,
        ),
        prefixIcon: Icon(icon, color: Colors.white, size: 20.0),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: const Color(0xFF0E3D70),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 14.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: const BorderSide(color: Color(0xFF1E88E5), width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: const BorderSide(color: Color(0xFF1E88E5), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: const BorderSide(color: Color(0xFF90CAF9), width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: const BorderSide(color: Color(0xFFEF5350), width: 1.5),
        ),
      ),
    );
  }

  Widget _build3DButton({
    required String title,
    required Color topColor,
    required Color bottomColor,
    required Color borderColor,
    required void Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [topColor, bottomColor],
          ),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.4),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: borderColor,
              blurRadius: 0.0,
              offset: const Offset(0.0, 4.0),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 8.0,
              offset: const Offset(0.0, 6.0),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
              shadows: const [
                Shadow(
                  color: Colors.black38,
                  blurRadius: 4.0,
                  offset: Offset(0.0, 2.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGuestButton(String lang) {
    return GestureDetector(
      onTap: _handleGuestLogin,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: const Color(0xFF0D47A1).withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: Text(
          AppStrings.tr('continue_guest', lang),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13.0,
            fontWeight: FontWeight.w700,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
