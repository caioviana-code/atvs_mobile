import '../../domain/tool_entity.dart';
import '../../domain/tool_services_interfaces/tool_service.dart';
import '../../domain/use_cases_interfaces/iupdate_tool_case_use.dart';

class UpdateToolUseCaseImpl implements IUpdateToolUseCase {
  final ToolService toolService;

  UpdateToolUseCaseImpl(this.toolService);

  @override
  Future<void> updateTool(ToolEntity tool) async {
    await toolService.updateTool(tool);
  }
}