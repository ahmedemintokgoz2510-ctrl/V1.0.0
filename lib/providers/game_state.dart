import 'package:flutter/material.dart';
import 'package:crazy_block_online/models/player.dart';
import 'package:crazy_block_online/models/friend.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crazy_block_online/app_strings.dart';

@NowaGenerated()
class GameStateProvider extends ChangeNotifier {
  GameStateProvider() {
    _loadFromPrefs();
  }

  Player? _currentPlayer;

  List<Friend> _friends = [];

  List<Friend> _friendRequests = [];

  int _currentScore = 0;

  int _currentCoins = 150;

  bool _isMusicOn = true;

  bool _isSfxOn = true;

  String _selectedLanguage = 'Türkçe';

  String _selectedBackground = 'Classic Navy';

  String _selectedBlockStyle = 'Classic Color Blocks';

  String _selectedGif = '';

  String _savedPlayerId = '';

  Player? get currentPlayer {
    return _currentPlayer;
  }

  List<Friend> get friends {
    return _friends;
  }

  List<Friend> get friendRequests {
    return _friendRequests;
  }

  int get currentScore {
    return _currentScore;
  }

  int get currentCoins {
    return _currentCoins;
  }

  bool get isMusicOn {
    return _isMusicOn;
  }

  bool get isSfxOn {
    return _isSfxOn;
  }

  String get selectedLanguage {
    return _selectedLanguage;
  }

  String get selectedBackground {
    return _selectedBackground;
  }

  String get selectedBlockStyle {
    return _selectedBlockStyle;
  }

  String get selectedGif {
    return _selectedGif;
  }

  String get persistentPlayerId {
    if (_savedPlayerId.isEmpty) {
      _savedPlayerId = _generatePlayerId();
    }
    return _savedPlayerId;
  }

  Future<void> _loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var savedId = prefs.getString('player_id');
      final savedName = prefs.getString('player_name');
      final savedEmail = prefs.getString('player_email');
      final savedPhone = prefs.getString('player_phone') ?? '';
      final savedCoins = prefs.getInt('player_coins') ?? 150;
      final savedHighScore = prefs.getInt('player_high_score') ?? 0;
      final savedLang = prefs.getString('selected_language') ?? 'Türkçe';
      final savedMusic = prefs.getBool('music_on') ?? true;
      final savedSfx = prefs.getBool('sfx_on') ?? true;
      final savedBlockStyle =
          prefs.getString('block_style') ?? 'Classic Color Blocks';
      final savedBg = prefs.getString('selected_bg') ?? 'Classic Navy';
      if (savedId == null || savedId!.isEmpty) {
        savedId = _generatePlayerId();
        await prefs.setString('player_id', savedId!);
      }
      _savedPlayerId = savedId!;
      _currentCoins = savedCoins;
      _selectedLanguage = savedLang;
      _isMusicOn = savedMusic;
      _isSfxOn = savedSfx;
      _selectedBlockStyle = savedBlockStyle;
      _selectedBackground = savedBg;
      if (savedName != null && savedName!.isNotEmpty) {
        _currentPlayer = Player(
          id: savedId!,
          name: savedName,
          email: savedEmail ?? '',
          phone: savedPhone,
          coins: savedCoins,
          highScore: savedHighScore,
        );
      }
      notifyListeners();
    } catch (_) {}
  }

  Future<void> _saveToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (_currentPlayer != null) {
        await prefs.setString('player_id', _currentPlayer!.id);
        await prefs.setString('player_name', _currentPlayer!.name);
        await prefs.setString('player_email', _currentPlayer!.email);
        await prefs.setString('player_phone', _currentPlayer!.phone);
        await prefs.setInt('player_coins', _currentPlayer!.coins);
        await prefs.setInt('player_high_score', _currentPlayer!.highScore);
      }
      await prefs.setString('player_id', persistentPlayerId);
      await prefs.setInt('player_coins', _currentCoins);
      await prefs.setString('selected_language', _selectedLanguage);
      await prefs.setBool('music_on', _isMusicOn);
      await prefs.setBool('sfx_on', _isSfxOn);
      await prefs.setString('block_style', _selectedBlockStyle);
      await prefs.setString('selected_bg', _selectedBackground);
    } catch (_) {}
  }

  String _generatePlayerId() {
    final now = DateTime.now().millisecondsSinceEpoch;
    final numStr = (now % 89999 + 10000).toString();
    return 'CBO-${numStr}';
  }

  void initializePlayer(String name, String email, {String phone = ''}) {
    final idToUse = _currentPlayer?.id.isNotEmpty == true
        ? _currentPlayer!.id
        : persistentPlayerId;
    final currentHigh = _currentPlayer?.highScore ?? 0;
    _currentPlayer = Player(
      id: idToUse,
      name: name,
      email: email,
      phone: phone,
      coins: _currentCoins,
      highScore: currentHigh,
    );
    _saveToPrefs();
    notifyListeners();
  }

  void resetGameScore() {
    _currentScore = 0;
    notifyListeners();
  }

  void addScore(int points) {
    _currentScore += points;
    final best = _currentPlayer?.highScore ?? 0;
    if (_currentScore > best) {
      if (_currentPlayer != null) {
        _currentPlayer = _currentPlayer?.copyWith(highScore: _currentScore);
      } else {
        _currentPlayer = Player(
          id: persistentPlayerId,
          name: AppStrings.tr('player', _selectedLanguage),
          email: '',
          coins: _currentCoins,
          highScore: _currentScore,
        );
      }
      _saveToPrefs();
    }
    notifyListeners();
  }

  void addCoins(int amount) {
    _currentCoins += amount;
    if (_currentPlayer != null) {
      _currentPlayer = _currentPlayer?.copyWith(coins: _currentCoins);
    }
    _saveToPrefs();
    notifyListeners();
  }

  bool spendCoins(int amount) {
    if (_currentCoins >= amount) {
      _currentCoins -= amount;
      if (_currentPlayer != null) {
        _currentPlayer = _currentPlayer?.copyWith(coins: _currentCoins);
      }
      _saveToPrefs();
      notifyListeners();
      return true;
    }
    return false;
  }

  void watchAdForCoins() {
    addCoins(50);
  }

  void buyCoinPackage(int coins) {
    addCoins(coins);
  }

  void toggleMusic() {
    _isMusicOn = !_isMusicOn;
    _saveToPrefs();
    notifyListeners();
  }

  void toggleSfx() {
    _isSfxOn = !_isSfxOn;
    _saveToPrefs();
    notifyListeners();
  }

  void setLanguage(String language) {
    _selectedLanguage = language;
    _saveToPrefs();
    notifyListeners();
  }

  void setBackground(String background) {
    _selectedBackground = background;
    _saveToPrefs();
    notifyListeners();
  }

  void setBlockStyle(String blockStyle) {
    _selectedBlockStyle = blockStyle;
    _saveToPrefs();
    notifyListeners();
  }

  void setGif(String gif) {
    _selectedGif = gif;
    notifyListeners();
  }

  void addFriend(Friend friend) {
    if (!_friends.any((f) => f.id == friend.id)) {
      _friends.add(friend);
      _friendRequests.removeWhere((f) => f.id == friend.id);
      notifyListeners();
    }
  }

  void removeFriendRequest(String friendId) {
    _friendRequests.removeWhere((f) => f.id == friendId);
    notifyListeners();
  }

  void searchAndAddFriend(String searchQuery) {
    final cleanQuery = searchQuery.trim();
    if (cleanQuery.isEmpty) {
      return;
    }
    final friendId = cleanQuery.startsWith('#')
        ? cleanQuery.replaceAll('#', '')
        : (cleanQuery.contains('CBO-')
              ? cleanQuery
              : 'CBO-${(DateTime.now().millisecondsSinceEpoch % 89999 + 10000)}');
    final mockSearchResult = Friend(
      id: friendId,
      name: cleanQuery.replaceAll('#', ''),
      status: FriendStatus.online,
      highScore: 1200,
    );
    addFriend(mockSearchResult);
  }

  void logout() {
    _currentPlayer = null;
    _friends = [];
    _friendRequests = [];
    _currentScore = 0;
    _saveToPrefs();
    notifyListeners();
  }
}
