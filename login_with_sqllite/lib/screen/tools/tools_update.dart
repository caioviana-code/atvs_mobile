import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:login_with_sqllite/common/messages/messages.dart';
import 'package:login_with_sqllite/common/routes/view_routes.dart';
import 'package:login_with_sqllite/external/database/db_sql_lite.dart';
import 'package:login_with_sqllite/model/tools/tool_model.dart';
import 'package:login_with_sqllite/model/users/user_model.dart';

import '../../components/user_login_header.dart';
import '../../components/user_text_field.dart';

class ToolsUpdate extends StatefulWidget {
  const ToolsUpdate({super.key});

  @override
  State<ToolsUpdate> createState() => _ToolsUpdateState();
}

class _ToolsUpdateState extends State<ToolsUpdate> {

  final _formKey = GlobalKey<FormState>();
  final _toolNameController = TextEditingController();
  final _toolAmountController = TextEditingController();
  late final UserModel user;
  late final ToolModel tool;

  @override
  void didChangeDependencies() {
    final Map<String,dynamic> arguments = ModalRoute.of(context)?.settings.arguments as Map<String,dynamic>;
    user = arguments['user'];
    tool = arguments['tool'];
    _getToolData(tool);
    super.didChangeDependencies();
  }

  _getToolData(ToolModel tool) async {
    setState(() {
      _toolNameController.text = tool.toolName;
      _toolAmountController.text = tool.toolAmount;
    });
  }

  _updateToolData(BuildContext context) {

    if (_formKey.currentState!.validate()) {

      ToolModel toolUpdated = ToolModel(
        toolId: tool.toolId,
        toolName: _toolNameController.text.trim(),
        toolAmount: _toolAmountController.text.trim(),
        toolUserId: tool.toolUserId,
      );

      final db = SqlLiteDb();
      db.updateTool(toolUpdated).then(
        (value) {
          AwesomeDialog(
            context: context,
            headerAnimationLoop: false,
            dialogType: DialogType.success,
            title: MessagesApp.successToolUpdate,
            btnOkOnPress: () => Navigator.pushNamed(context, RoutesApp.toolsView, arguments: user),
            btnOkText: 'OK',
          ).show();
        },
      ).catchError((error) {
        AwesomeDialog(
          context: context,
          headerAnimationLoop: false,
          dialogType: DialogType.error,
          title: MessagesApp.errorToolNoUpdate,
          btnCancelOnPress: () => Navigator.pop(context),
          btnCancelText: 'OK',
        ).show();
      });
    }
  }

  _deleteToolData(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      headerAnimationLoop: false,
      // animType: AnimType.topSlide,
      title: 'Confirma Exclusão???',
      btnCancelOnPress: () => Navigator.pop(context),
      btnOkText: 'Sim',
      btnOkOnPress: () {
        final db = SqlLiteDb();
        db.deleteTool(tool.toolId).then(
          (value) {
            AwesomeDialog(
              context: context,
              headerAnimationLoop: false,
              dialogType: DialogType.success,
              title: MessagesApp.successToolDelete,
              btnOkOnPress: () => Navigator.pushNamed(context, RoutesApp.toolsView, arguments: user),
              btnOkText: 'OK',
            ).show();
          },
        ).catchError((error) {
          AwesomeDialog(
            context: context,
            headerAnimationLoop: false,
            dialogType: DialogType.error,
            title: MessagesApp.errorDefault,
            btnCancelOnPress: () => Navigator.pop(context),
            btnCancelText: 'OK',
          ).show();
        });
      },
      btnCancelText: 'Cancelar',
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Atualizar Ferramenta'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 20),
          child: Center(
            child: Column(
              children: <Widget>[
                const UserLoginHeader('Atualizar Ferramenta'),
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
                  padding: const EdgeInsets.only(top: 30, left: 40, right: 40),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _updateToolData(context),
                          style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                          child: const Text(
                            'Atualizar',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _deleteToolData(context),
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: Theme.of(context).colorScheme.error,
                          ),
                          child: const Text(
                            'Deletar',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pushNamed(context,
                          RoutesApp.toolsView, arguments: user),
                          style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                          child: const Text(
                            'Voltar',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}