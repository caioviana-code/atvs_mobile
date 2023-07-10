import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:login_with_firebase/app/modules/my_application/src/tools/data/use_cases/create_tool_use_case_impl.dart';
import 'package:login_with_firebase/app/modules/my_application/src/tools/domain/use_cases_interfaces/idelete_tool_use_case.dart';
import 'package:login_with_firebase/app/modules/my_application/src/tools/domain/use_cases_interfaces/iget_tool_by_id_use_case.dart';
import 'package:login_with_firebase/app/modules/my_application/src/tools/domain/use_cases_interfaces/iupdate_tool_case_use.dart';

import 'modules/my_application/my_application.dart';
import 'modules/my_application/src/tools/data/services/tool_firestore_service_impl.dart';
import 'modules/my_application/src/tools/data/use_cases/delete_tool_use_case_impl.dart';
import 'modules/my_application/src/tools/data/use_cases/get_tool_by_id_use_case.dart';
import 'modules/my_application/src/tools/data/use_cases/update_tool_use_case_impl.dart';
import 'modules/my_application/src/tools/domain/tool_services_interfaces/tool_service.dart';
import 'modules/my_application/src/tools/domain/use_cases_interfaces/icreate_tool_use_case.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    
    ];
  @override
  List<ModularRoute> routes = [
    ModuleRoute(
      '/',
      module: MyApplication(),
    ),
  ];
}
