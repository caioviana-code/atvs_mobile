import '../tool_entity.dart';

abstract class IUpdateToolUseCase {
  Future<void> updateTool(ToolEntity tool);
}