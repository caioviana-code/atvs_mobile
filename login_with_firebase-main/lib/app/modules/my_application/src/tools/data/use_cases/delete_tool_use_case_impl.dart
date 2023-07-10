import '../../domain/tool_services_interfaces/tool_service.dart';
import '../../domain/use_cases_interfaces/idelete_tool_use_case.dart';

class DeleteToolUseCaseImpl implements IDeleteToolUseCase {
  final ToolService toolService;

  DeleteToolUseCaseImpl(this.toolService);

  @override
  Future<void> deleteTool(String bId) async {
    await toolService.deleteTool(bId);
  }
}