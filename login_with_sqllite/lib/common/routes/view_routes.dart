import 'package:flutter/material.dart';
import 'package:login_with_sqllite/model/users/user_model.dart';
import 'package:login_with_sqllite/screen/tools/tools_create.dart';
import 'package:login_with_sqllite/screen/tools/tools_update.dart';
import 'package:login_with_sqllite/screen/users/login_form.dart';
import 'package:login_with_sqllite/screen/users/signup_form.dart';
import 'package:login_with_sqllite/screen/tools/tools_view.dart';
import 'package:login_with_sqllite/screen/users/update_form.dart';
import 'package:path/path.dart';

import '../../model/tools/tool_model.dart';

class RoutesApp {

  static const home = '/';
  static const loginSgnup = '/loginSignup';
  static const loginUpdate = '/loginUpdate';
  static const toolsView = '/ToolsView';
  static const toolsCreate = '/ToolsCreate';
  static const toolsUpdate = '/ToolsUpdate';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (context) => const LoginForm());

      case loginSgnup:
        return MaterialPageRoute(builder: (context) => const SignUp());

      case loginUpdate:
        if (arguments is UserModel) {
          return MaterialPageRoute(
            // builder: (context) => UdpateUser(arguments),
            builder: (context) => const UpdateUser(),
            settings: settings,
          );
        } else {
          return _errorRoute();
        }

      case toolsView:
        if (arguments is UserModel) {
          return MaterialPageRoute(
            builder: (context) => const ToolsView(),
            settings: settings
          );
        } else {
          return _errorRoute();
        }

      case toolsCreate:
       if (arguments is UserModel) {
          return MaterialPageRoute(
            builder: (context) => const ToolsCreate(),
            settings: settings
          );
        } else {
          return _errorRoute();
        }

      case toolsUpdate:
        return MaterialPageRoute(
          builder: (context) => const ToolsUpdate(),
          settings: settings
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
