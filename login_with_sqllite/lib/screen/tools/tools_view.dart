import 'package:flutter/material.dart';
import 'package:login_with_sqllite/common/routes/view_routes.dart';
import 'package:login_with_sqllite/model/tools/tool_model.dart';
import 'package:login_with_sqllite/model/users/user_model.dart';

import '../../external/database/db_sql_lite.dart';

class ToolsView extends StatefulWidget {
  const ToolsView({super.key});

  @override
  State<ToolsView> createState() => _ToolsViewState();
}


class _ToolsViewState extends State<ToolsView> {

  late final UserModel user;
  List<ToolModel> userTools = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = ModalRoute.of(context)!.settings.arguments as UserModel;
    _fetchUserTools();
  }

  @override
  void initState() {
    super.initState();
    
  }

  Future<void> _fetchUserTools() async {
    final db = SqlLiteDb();
    List<ToolModel> tools = await db.getUserTools(user.userId) ;
    setState(() {
      userTools = tools;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Tools - ${user.userName}'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context, 
                    RoutesApp.toolsCreate,
                    arguments: user,
                  );
                },
                child: const Text('Cadastrar Ferramenta'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context,
                      RoutesApp.home, arguments: user);
                },
                child: const Text('Sair'),
              )
            ],
          ),
          if (userTools.isEmpty) ...[
            const SizedBox(height: 20),
            const Center(
              child: Text('Nenhuma ferramenta encontrada'),
            ),
          ] else ...[
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: userTools.length,
                itemBuilder: (context, index) {
                  ToolModel tool = userTools[index];
                  return Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context, 
                          RoutesApp.toolsUpdate,
                          arguments: {
                            'user': user,
                            'tool': tool
                          },
                        );
                      },
                      child: ListTile(
                        title: Text(
                          '${tool.toolName}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text('Quantidade: ${tool.toolAmount}'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ]
        ],
      ),
    );
  }

}