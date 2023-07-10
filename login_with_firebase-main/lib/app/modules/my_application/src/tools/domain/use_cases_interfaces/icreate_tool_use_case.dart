import '../tool_entity.dart';

abstract class ICreateToolUseCase {
  Future<void> createTool(ToolEntity tool);
}