import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/data/use_cases/auth_signin_user_case_impl.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/data/use_cases/auth_signout_user_case_impl.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/data/use_cases/auth_signup_user_case_impl.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/domain/user_credencial_entity.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/external/cache/auth_local_cache_sp_impl.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/external/services/email_auth_service_impl.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/manager/auth_service_manager.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/presenter/controller/auth_store.dart';
import 'package:login_with_firebase/app/modules/my_application/src/tools/data/services/tool_firestore_service_impl.dart';
import 'package:login_with_firebase/app/modules/my_application/src/tools/data/use_cases/create_tool_use_case_impl.dart';
import 'package:login_with_firebase/app/modules/my_application/src/tools/data/use_cases/delete_tool_use_case_impl.dart';
import 'package:login_with_firebase/app/modules/my_application/src/tools/data/use_cases/get_tool_by_id_use_case.dart';
import 'package:login_with_firebase/app/modules/my_application/src/tools/data/use_cases/update_tool_use_case_impl.dart';
import 'package:login_with_firebase/app/modules/my_application/src/tools/domain/tool_services_interfaces/tool_service.dart';
import 'package:login_with_firebase/app/modules/my_application/src/tools/domain/use_cases_interfaces/icreate_tool_use_case.dart';
import 'package:login_with_firebase/app/modules/my_application/src/tools/domain/use_cases_interfaces/idelete_tool_use_case.dart';
import 'package:login_with_firebase/app/modules/my_application/src/tools/domain/use_cases_interfaces/iget_tool_by_id_use_case.dart';
import 'package:login_with_firebase/app/modules/my_application/src/tools/domain/use_cases_interfaces/iupdate_tool_case_use.dart';
import 'package:login_with_firebase/app/modules/my_application/src/views/tool_view.dart';
import 'package:login_with_firebase/app/modules/my_application/src/views/signin_view.dart';
import 'package:login_with_firebase/app/modules/my_application/src/views/signup_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_guard.dart';

class MyApplication extends Module {
  @override
  List<Bind> binds = [
    //AsyncBind((i) => SharedPreferences.getInstance()),
    Bind.lazySingleton((i) => AuthServiceManager(AuthType.email)),
    Bind.lazySingleton((i) => EmailAuthServiceImpl()),
    Bind.singleton((i) => AuthLocalCacheSharedPrefsImpl()),
    
    //   Bind.lazySingleton((i) => AuthLocalCacheSharedPrefsImpl()),
    
    Bind.lazySingleton((i) => AuthSignInUserCaseImpl(i())),
    Bind.lazySingleton((i) => AuthSignOutUserCaseImpl(i())),
    Bind.lazySingleton((i) => AuthSignUpUserCaseImpl(i())),
    Bind.singleton<AuthStore>(
      (i) => AuthStore(
        userSignIn: i(),
        userSignOut: i(),
        userSignUp: i(),
        localCache: i(),
      ),
      onDispose: (store) => store.destroy,
      selector: (store) => store.state,
    ),

    Bind<ToolService>((i) => ToolFirestoreServiceImpl(FirebaseFirestore.instance,i.get<AuthStore>(),)),

    Bind<ICreateToolUseCase>((i) => CreateToolUseCaseImpl(i.get<ToolService>())),
 
    Bind<IGetToolByIdUseCase>((i) => GetToolByIdUseCase(i.get<ToolService>())),
  
    Bind<IUpdateToolUseCase>((i) => UpdateToolUseCaseImpl(i.get<ToolService>())),

    Bind<IDeleteToolUseCase>((i) => DeleteToolUseCaseImpl(i.get<ToolService>())),
  ];

  @override
  List<ModularRoute> routes = [
    ChildRoute('/', child: (ctx, args) =>SignInPage(), guards: [HomeGuard()]),
    ChildRoute(
      '/home-page',
      child: (context, args) => ToolView( ),
    ),
    ChildRoute(
      '/signin-page',
      child: (context, args) => SignInPage(),
    ),
    ChildRoute(
      '/signup-page',
      child: (context, args) => SignUpPage(),
    ),
  ];
}
