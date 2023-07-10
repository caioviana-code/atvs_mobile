
import '../../domain/tool_entity.dart';
import '../../domain/tool_services_interfaces/tool_service.dart';
import '../../domain/use_cases_interfaces/icreate_tool_use_case.dart';


class CreateToolUseCaseImpl implements ICreateToolUseCase {
  final ToolService toolService;

  CreateToolUseCaseImpl(this.toolService);

  @override
  Future<void> createTool(ToolEntity tool) async {
    await toolService.createTool(tool);
  }
}