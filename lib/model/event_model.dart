import 'dart:convert';

class Event {
  final String id;
  final String name;
  final int coins;
  final String date;
  final String location;
  final List<String> participants;

  Event({
    required this.id,
    required this.name,
    required this.coins,
    required this.date,
    required this.location,
    required this.participants,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'coins': coins,
      'date': date,
      'location': location,
      'participants': participants,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      coins: map['coins'] ?? 0,
      date: map['date'] ?? '',
      location: map['location'] ?? '',
      participants: List<String>.from(map['participants'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source));

  Event copyWith({
    String? id,
    String? name,
    int? coins,
    String? date,
    String? location,
    List<String>? participants,
  }) {
    return Event(
      id: id ?? this.id,
      name: name ?? this.name,
      coins: coins ?? this.coins,
      date: date ?? this.date,
      location: location ?? this.location,
      participants: participants ?? this.participants,
    );
  }
}
