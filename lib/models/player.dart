import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class Player {
  Player({
    required this.id,
    required this.name,
    required this.email,
    this.phone = '',
    this.coins = 0,
    this.highScore = 0,
    this.isVerified = false,
  });

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      coins: map['coins'] ?? 0,
      highScore: map['highScore'] ?? 0,
      isVerified: map['isVerified'] ?? false,
    );
  }

  final String id;

  final String name;

  final String email;

  final String phone;

  final int coins;

  final int highScore;

  final bool isVerified;

  String get leagueKey {
    if (highScore >= 50000) {
      return 'league_world';
    }
    if (highScore >= 15000) {
      return 'league_diamond';
    }
    if (highScore >= 5000) {
      return 'league_gold';
    }
    if (highScore >= 1000) {
      return 'league_silver';
    }
    return 'league_bronze';
  }

  Player copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    int? coins,
    int? highScore,
    bool? isVerified,
  }) {
    return Player(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      coins: coins ?? this.coins,
      highScore: highScore ?? this.highScore,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'coins': coins,
      'highScore': highScore,
      'isVerified': isVerified,
    };
  }
}
