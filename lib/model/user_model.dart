import 'dart:convert';

class User {
  final String id;
  final String name;
  final String surname;
  final String email;
  final String password;
  final String role;
  final int coins;
  final String avatar;
  final String token;
  // ignore: non_constant_identifier_names
  final List<String> bought_products;
  final List<String> events;

  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
    required this.role,
    required this.coins,
    required this.avatar,
    required this.token,
    // ignore: non_constant_identifier_names
    required this.bought_products,
    required this.events,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'email': email,
      'password': password,
      'role': role,
      'avatar': avatar,
      'coins': coins,
      'token': token,
      'bought_products': bought_products,
      'events': events,
    };
  }

  // Parse the JSON string into a Dart object

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      surname: map['surname'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      role: map['role'] ?? 'user',
      avatar: map['avatar'] ?? '',
      coins: map['coins'] ?? 0,
      token: map['token'] ?? '',
      // create for array of strings
      bought_products: List<String>.from(map['bought_products'] ?? []),
      events: List<String>.from(map['events'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? name,
    String? surname,
    String? email,
    String? password,
    String? role,
    String? avatar,
    int? coins,
    String? token,
    // ignore: non_constant_identifier_names
    List<String>? bought_products,
    List<String>? events,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
      avatar: avatar ?? this.avatar,
      coins: coins ?? this.coins,
      token: token ?? this.token,
      bought_products: bought_products ?? this.bought_products,
      events: events ?? this.events,
    );
  }
}
