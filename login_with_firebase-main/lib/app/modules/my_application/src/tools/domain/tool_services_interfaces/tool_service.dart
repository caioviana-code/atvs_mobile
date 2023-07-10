import '../tool_entity.dart';

abstract class ToolService {
  Future<void> createTool(ToolEntity tool);
  Future<void> deleteTool(String bId);
  Future<ToolEntity?> getToolById(String bId);
  Future<void> updateTool(ToolEntity tool);
  Future<List<ToolEntity>> getToolList();
}
