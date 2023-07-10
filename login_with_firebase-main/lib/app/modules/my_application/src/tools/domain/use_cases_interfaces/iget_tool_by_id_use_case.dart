import '../tool_entity.dart';

abstract class IGetToolByIdUseCase {
  Future<ToolEntity?> getToolById(String toolId);
}