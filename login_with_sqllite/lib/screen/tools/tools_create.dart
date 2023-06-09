import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:login_with_sqllite/common/messages/messages.dart';
import 'package:login_with_sqllite/common/routes/view_routes.dart';
import 'package:login_with_sqllite/components/user_login_header.dart';
import 'package:login_with_sqllite/components/user_text_field.dart';
import 'package:login_with_sqllite/external/database/db_sql_lite.dart';
import 'package:login_with_sqllite/model/tools/tool_model.dart';

import '../../model/users/user_model.dart';

class ToolsCreate extends StatefulWidget {
  const ToolsCreate({super.key});

  @override
  State<ToolsCreate> createState() => _ToolsCreateState();
}

class _ToolsCreateState extends State<ToolsCreate> {

  late final UserModel user;
  final _toolNameController = TextEditingController();
  final _toolAmountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    user = ModalRoute.of(context)!.settings.arguments as UserModel;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _toolNameController.dispose();
    _toolAmountController.dispose();
    super.dispose();
  }

  void createTool(BuildContext context) async {

    if (_formKey.currentState!.validate()) {

      final db = SqlLiteDb();

      ToolModel tool = ToolModel(
        toolName: _toolNameController.text.trim(),
        toolAmount: _toolAmountController.text.trim(),
        toolUserId: user.userId
      );

      db.saveTool(tool).then(
        (value) {
          AwesomeDialog(
            context: context,
            headerAnimationLoop: false,
            dialogType: DialogType.success,
            title: MessagesApp.successToolInsert,
            btnOkOnPress: () => Navigator.pushNamed(
              context, RoutesApp.toolsView, arguments: user),
            btnOkText: 'OK',
          ).show();
        },
      ).catchError((error) {
        if (error.toString().contains('UNIQUE constraint failed')) {
          MessagesApp.showCustom(
            context,
            MessagesApp.errorToolExist,
          );
        } else {
          MessagesApp.showCustom(
            context,
            MessagesApp.errorDefault,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Cadastro de Ferramentas'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 20),
          child: Center(
            child: Column(
              children: <Widget>[
                const UserLoginHeader('Cadastrar Ferramenta'),
                UserTextField(
                  hintName: 'Nome',
                  icon: Icons.handyman,
                  controller: _toolNameController,
                ),
                UserTextField(
                  hintName: 'Quantidade',
                  icon: Icons.density_small_sharp,
                  controller: _toolAmountController,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 30, left: 80, right: 80),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => createTool(context),
                    style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                    child: const Text(
                      'Cadastrar',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 10,
                    right: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context,
                              RoutesApp.toolsView, arguments: user);
                        },
                        child: const Text('Voltar'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}