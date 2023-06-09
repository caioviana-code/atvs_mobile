class ToolModel {

  int? toolId;
  String toolUserId;
  String toolName;
  String toolAmount;

  ToolModel({
    this.toolId,
    required this.toolUserId,
    required this.toolName,
    required this.toolAmount
  });

  @override
  String toString() {
    return 'ToolModel(toolId: $toolId, toolUserId: $toolUserId, toolName $toolName, toolAmount: $toolAmount)';
  }

}