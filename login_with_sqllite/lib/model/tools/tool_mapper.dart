import 'package:login_with_sqllite/external/database/tool_table_schema.dart';
import 'package:login_with_sqllite/model/tools/tool_model.dart';

abstract class ToolMapper {

  static Map<String, dynamic> toMapBD(ToolModel tool) {
    return {
      ToolTableSchema.toolIdColumn: tool.toolId,
      ToolTableSchema.toolUserIdColumn: tool.toolUserId,
      ToolTableSchema.toolNameColumn: tool.toolName,
      ToolTableSchema.toolAmountColumn: tool.toolAmount
    };
  }

  static ToolModel fromMapBD(Map<String, dynamic> map) {
    return ToolModel(
      toolId: map[ToolTableSchema.toolIdColumn],
      toolUserId: map[ToolTableSchema.toolUserIdColumn],
      toolName: map[ToolTableSchema.toolNameColumn],
      toolAmount: map[ToolTableSchema.toolAmountColumn]
    );
  }

  static ToolModel cloneTool(ToolModel tool) {
    return ToolModel(
      toolId: tool.toolId,
      toolUserId: tool.toolUserId,
      toolName: tool.toolName,
      toolAmount: tool.toolAmount
    );
  }

}