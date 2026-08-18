import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:crazy_block_online/providers/game_state.dart';
import 'package:crazy_block_online/app_strings.dart';
import 'package:crazy_block_online/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:crazy_block_online/models/friend.dart';

@NowaGenerated()
class SocialScreen extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const SocialScreen({Key? key});

  @override
  State<SocialScreen> createState() {
    return _SocialScreenState();
  }
}

@NowaGenerated()
class _SocialScreenState extends State<SocialScreen> {
  int _selectedTab = 0;

  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearch(GameStateProvider gameState, String lang) {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      gameState.searchAndAddFriend(query);
      _searchController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${query} ${AppStrings.tr('friend_added', lang)}'),
          backgroundColor: const Color(0xFF689F38),
          duration: const Duration(seconds: 2),
        ),
      );
      setState(() {
        _selectedTab = 0;
      });
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
              final playerId = player?.id.isNotEmpty == true
                  ? player!.id
                  : gameState.persistentPlayerId;
              return Column(
                children: [
                  _buildHeader(lang, playerId),
                  const SizedBox(height: 12.0),
                  _buildTabBar(lang, gameState),
                  const SizedBox(height: 12.0),
                  Expanded(child: _buildTabContent(gameState, lang)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String lang, String playerId) {
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
              const Text('👥', style: TextStyle(fontSize: 18.0)),
              const SizedBox(width: 6.0),
              Text(
                AppStrings.tr('social', lang).toUpperCase(),
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
            onTap: () {
              Clipboard.setData(ClipboardData(text: '#${playerId}'));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppStrings.tr('id_copied', lang)),
                  backgroundColor: const Color(0xFF155E9E),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF155E9E),
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(color: const Color(0xFF64B5F6)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.copy_rounded,
                    color: Color(0xFFFFD54F),
                    size: 13.0,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    '#${playerId}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(String lang, GameStateProvider gameState) {
    final tabs = [
      {
        'title': AppStrings.tr('my_friends', lang),
        'badge': gameState.friends.isNotEmpty
            ? gameState.friends.length.toString()
            : null,
      },
      {'title': AppStrings.tr('find_friends', lang), 'badge': null},
      {
        'title': AppStrings.tr('invitations', lang),
        'badge': gameState.friendRequests.isNotEmpty
            ? gameState.friendRequests.length.toString()
            : null,
      },
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          tabs[idx]['title'] as String,
                          style: TextStyle(
                            color: _selectedTab == idx
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.7),
                            fontSize: 11.5,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.4,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (tabs[idx]['badge'] != null) ...[
                        const SizedBox(width: 4.0),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6.0,
                            vertical: 1.5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0D47A1),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            tabs[idx]['badge'] as String,
                            style: const TextStyle(
                              color: Color(0xFFFFD54F),
                              fontSize: 9.5,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(GameStateProvider gameState, String lang) {
    if (_selectedTab == 0) {
      return _buildFriendsList(gameState, lang);
    } else if (_selectedTab == 1) {
      return _buildFindFriendsView(gameState, lang);
    } else {
      return _buildInvitationsView(gameState, lang);
    }
  }

  Widget _buildFriendsList(GameStateProvider gameState, String lang) {
    final friends = gameState.friends;
    if (friends.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 72.0,
                height: 72.0,
                decoration: BoxDecoration(
                  color: const Color(0xFF155E9E),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF64B5F6),
                    width: 2.0,
                  ),
                ),
                child: const Center(
                  child: Text('👥', style: TextStyle(fontSize: 34.0)),
                ),
              ),
              const SizedBox(height: 14.0),
              Text(
                AppStrings.tr('no_friends_yet', lang),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                AppStrings.tr('find_friends_hint', lang),
                style: const TextStyle(color: Colors.white70, fontSize: 12.5),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7CB342),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22.0,
                    vertical: 12.0,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _selectedTab = 1;
                  });
                },
                child: Text(
                  AppStrings.tr('find_friends', lang),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      itemCount: friends.length,
      itemBuilder: (context, index) {
        final friend = friends[index];
        final isOnline = friend.status == FriendStatus.online;
        return Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: const Color(0xFF155E9E).withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: const Color(0xFF64B5F6), width: 1.2),
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 44.0,
                    height: 44.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: isOnline
                            ? [const Color(0xFF42A5F5), const Color(0xFF1E88E5)]
                            : [
                                const Color(0xFF78909C),
                                const Color(0xFF455A64),
                              ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        friend.name.isNotEmpty
                            ? friend.name[0].toUpperCase()
                            : 'F',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0.0,
                    bottom: 0.0,
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      decoration: BoxDecoration(
                        color: isOnline
                            ? const Color(0xFF7CB342)
                            : const Color(0xFF90A4AE),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF155E9E),
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      friend.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Row(
                      children: [
                        const Icon(
                          Icons.emoji_events_rounded,
                          color: Color(0xFFFFD54F),
                          size: 13.0,
                        ),
                        const SizedBox(width: 3.0),
                        Text(
                          '${friend.highScore} ${AppStrings.tr('score_pts', lang)}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 11.5,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          '#${friend.id}',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 10.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${friend.name} ${AppStrings.tr('friend_invited', lang)}',
                      ),
                      backgroundColor: const Color(0xFF689F38),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: const [Color(0xFF8BC34A), Color(0xFF689F38)],
                    ),
                    borderRadius: BorderRadius.circular(14.0),
                    border: Border.all(color: Colors.white30, width: 1.0),
                  ),
                  child: Text(
                    AppStrings.tr('invite', lang),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFindFriendsView(GameStateProvider gameState, String lang) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 4.0,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF0E3D70),
              borderRadius: BorderRadius.circular(18.0),
              border: Border.all(color: const Color(0xFF42A5F5), width: 1.5),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.search_rounded,
                  color: Color(0xFF90CAF9),
                  size: 22.0,
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(color: Colors.white, fontSize: 14.0),
                    decoration: InputDecoration(
                      hintText: AppStrings.tr('search_player_hint', lang),
                      hintStyle: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 12.5,
                      ),
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) => _handleSearch(gameState, lang),
                  ),
                ),
                GestureDetector(
                  onTap: () => _handleSearch(gameState, lang),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: const [Color(0xFF42A5F5), Color(0xFF1E88E5)],
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      AppStrings.tr('search', lang),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),
          Container(
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              color: const Color(0xFF155E9E).withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(22.0),
              border: Border.all(color: const Color(0xFF64B5F6), width: 1.5),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline_rounded,
                  color: Color(0xFFFFD54F),
                  size: 24.0,
                ),
                const SizedBox(width: 12.0),
                const Expanded(
                  child: Text(
                    'Search for friends using their unique Player ID (e.g., #CBO-58291) to add them to your puzzle circle!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.5,
                      height: 1.4,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvitationsView(GameStateProvider gameState, String lang) {
    final requests = gameState.friendRequests;
    if (requests.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 72.0,
                height: 72.0,
                decoration: BoxDecoration(
                  color: const Color(0xFF155E9E),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF64B5F6),
                    width: 2.0,
                  ),
                ),
                child: const Center(
                  child: Text('📬', style: TextStyle(fontSize: 34.0)),
                ),
              ),
              const SizedBox(height: 14.0),
              Text(
                AppStrings.tr('no_invitations', lang),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                AppStrings.tr('no_invitations_hint', lang),
                style: const TextStyle(color: Colors.white70, fontSize: 12.5),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final req = requests[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: const Color(0xFF155E9E),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: const Color(0xFF64B5F6), width: 1.2),
          ),
          child: Row(
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: const [Color(0xFF42A5F5), Color(0xFF1E88E5)],
                  ),
                ),
                child: Center(
                  child: Text(
                    req.name[0],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      req.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'ID: #${req.id}',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 11.0,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  gameState.addFriend(req);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${req.name} ${AppStrings.tr('friend_added', lang)}',
                      ),
                      backgroundColor: const Color(0xFF689F38),
                    ),
                  );
                },
                child: Container(
                  width: 38.0,
                  height: 38.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFF7CB342),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 20.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              GestureDetector(
                onTap: () {
                  gameState.removeFriendRequest(req.id);
                },
                child: Container(
                  width: 38.0,
                  height: 38.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE53935),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 20.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
