import '../domain/tool_entity.dart';
import '../domain/use_cases_interfaces/icreate_tool_use_case.dart';
import '../domain/use_cases_interfaces/idelete_tool_use_case.dart';
import '../domain/use_cases_interfaces/iget_tool_by_id_use_case.dart';
import '../domain/use_cases_interfaces/iupdate_tool_case_use.dart';

class ToolManager {
  final ICreateToolUseCase createToolUseCase;
  final IDeleteToolUseCase deleteToolUseCase;
  final IGetToolByIdUseCase getToolByIdUseCase;
  final IUpdateToolUseCase updateToolUseCase;

  ToolManager(
    this.createToolUseCase,
    this.deleteToolUseCase,
    this.getToolByIdUseCase,
    this.updateToolUseCase,
  );

  Future<void> createTool(ToolEntity tool) async {
    await createToolUseCase.createTool(tool);
  }

  Future<void> deleteTool(String toolId) async {
    await deleteToolUseCase.deleteTool(toolId);
  }

  Future<ToolEntity?> getToolById(String toolId) async {
    return await getToolByIdUseCase.getToolById(toolId);
  }

  Future<void> updateTool(ToolEntity tool) async {
    await updateToolUseCase.updateTool(tool);
  }
}
