import '../../domain/tool_entity.dart';
import '../../domain/tool_services_interfaces/tool_service.dart';
import '../../domain/use_cases_interfaces/iget_tool_by_id_use_case.dart';

class GetToolByIdUseCase implements IGetToolByIdUseCase {
  final ToolService toolService;

  GetToolByIdUseCase(this.toolService);

  @override
  Future<ToolEntity?> getToolById(String toolId) async {
    return await toolService.getToolById(toolId);
  }
}