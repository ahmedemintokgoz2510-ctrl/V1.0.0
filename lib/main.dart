import 'package:shared_preferences/shared_preferences.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crazy_block_online/globals/app_state.dart';
import 'package:crazy_block_online/providers/game_state.dart';
import 'package:crazy_block_online/screens/loading_screen.dart';
import 'package:crazy_block_online/screens/login_screen.dart';
import 'package:crazy_block_online/pages/main_menu_screen.dart';

late SharedPreferences sharedPrefs;

@NowaGenerated()
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPrefs = await SharedPreferences.getInstance();

  runApp(const CrazyBlockOnlineApp());
}

@NowaGenerated()
class CrazyBlockOnlineApp extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const CrazyBlockOnlineApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
        ChangeNotifierProvider(create: (_) => GameStateProvider()),
      ],
      child: Consumer<AppState>(
        builder: (context, appState, child) => MaterialApp(
          title: 'Crazy Block Online',
          theme: appState.theme,
          debugShowCheckedModeBanner: false,
          home: const AppHome(),
        ),
      ),
    );
  }
}

@NowaGenerated()
class AppHome extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const AppHome({Key? key});

  @override
  State<AppHome> createState() {
    return _AppHomeState();
  }
}

@NowaGenerated()
class _AppHomeState extends State<AppHome> {
  bool _isLoading = true;

  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _startApp();
  }

  Future<void>? _startApp() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleLoginSuccess() {
    setState(() {
      _isLoggedIn = true;
    });
  }

  void _handleLogout() {
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return LoadingScreen(
        onLoadingComplete: () {
          setState(() {
            _isLoading = false;
          });
        },
      );
    }
    if (!_isLoggedIn) {
      return LoginScreen(onLoginSuccess: _handleLoginSuccess);
    }
    return MainMenuScreen(onLogout: _handleLogout);
  }
}
