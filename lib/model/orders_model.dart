import 'dart:convert';

class Orders {
  final String id;
  final String user_id;
  final String product_id;
  final int amount;
  final String explanation;

  Orders({
    required this.id,
    required this.user_id,
    required this.product_id,
    required this.amount,
    required this.explanation,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': user_id,
      'product_id': product_id,
      'amount': amount,
      'explanation': explanation,
    };
  }

  factory Orders.fromMap(Map<String, dynamic> map) {
    return Orders(
      id: map['id'] ?? '',
      user_id: map['user_id'] ?? '',
      product_id: map['product_id'] ?? '',
      amount: map['amount'] ?? 0,
      explanation: map['explanation'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Orders.fromJson(String source) => Orders.fromMap(json.decode(source));

  Orders copyWith({
    String? id,
    String? user_id,
    String? product_id,
    int? amount,
    String? explanation,
  }) {
    return Orders(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      product_id: product_id ?? this.product_id,
      amount: amount ?? this.amount,
      explanation: explanation ?? this.explanation,
    );
  }
}
