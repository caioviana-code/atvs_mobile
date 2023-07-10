class ToolEntity {
  final String tId;
  final String name;
  final String type;
  final int amount;
  final String userId;

  ToolEntity({
    required this.tId,
    required this.name,
    required this.type,
    required this.amount,
    required this.userId,
  });

  ToolEntity copyWith({
    String? tId,
    String? name,
    String? type,
    int? amount,
    String? userId,
  }) {
    return ToolEntity(
      tId: tId ?? this.tId,
      name: name ?? this.name,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      userId: userId ?? this.userId,
    );
  }
}
