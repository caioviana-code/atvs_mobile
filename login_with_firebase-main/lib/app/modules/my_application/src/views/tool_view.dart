import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../authentication/domain/user_credencial_entity.dart';
import '../authentication/presenter/controller/auth_store.dart';
import '../tools/domain/tool_entity.dart';
import '../tools/domain/tool_services_interfaces/tool_service.dart';

class ToolView extends StatefulWidget {
  @override
  _ToolViewState createState() => _ToolViewState();
}

class _ToolViewState extends State<ToolView> {
  final ToolService toolService = Modular.get<ToolService>();
  List<ToolEntity> tools = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadTools();
  }

  Future<void> loadTools() async {
    tools = await toolService.getToolList();
    setState(() {});
  }

  Future<void> createTool(ToolEntity tool) async {
    await toolService.createTool(tool);
    loadTools();
  }

  Future<void> updateTool(ToolEntity tool) async {
    await toolService.updateTool(tool);
    loadTools();
  }

  Future<void> deleteTool(String tId) async {
    await toolService.deleteTool(tId);
    setState(() {
      tools.removeWhere((tool) => tool.tId == tId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthStore authStore = Modular.get<AuthStore>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tools'),
        backgroundColor: const Color.fromARGB(255, 0, 85, 255),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 0, 85, 255),
                    Colors.white,
                    Colors.grey.shade300,
                    Color.fromARGB(255, 66, 137, 174),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0.0, 0.3, 0.6, 0.9],
                ),
              ),
              child: ScopedBuilder<AuthStore, UserCredentialApp?>(
                store: authStore,
                onLoading: ((_) => const CircularProgressIndicator()),
                onState: (context, authState) {
                  var user = authState;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        'ToolTrack',
                        style: TextStyle(fontSize: 30),
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            maxRadius: 35,
                            child: (authStore.isAuth)
                                ? Text(
                                    user!.name!.substring(0, 1).toUpperCase(),
                                    style: const TextStyle(fontSize: 50),
                                  )
                                : const Icon(Icons.question_mark, size: 40),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              (authStore.isAuth)
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(user!.name!),
                                        const SizedBox(height: 5),
                                        Text(user.email),
                                      ],
                                    )
                                  : const Icon(Icons.login, size: 40),
                              TextButton(
                                onPressed: () async {
                                  await authStore.userSignOut();  
                                  Modular.to.pushNamed('/signin-page');
                                  
                                },
                                child: const Text("Sair"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: tools.length,
        itemBuilder: (context, index) {
          final tool = tools[index];
          return ToolItem(
            tool: tool,
            onUpdate: (updatedTool) => updateTool(updatedTool),
            onDelete: () => deleteTool(tool.tId),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateToolDialog(),
        backgroundColor: const Color.fromARGB(255, 0, 85, 255),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showCreateToolDialog() async {
    final AuthStore authStore = Modular.get<AuthStore>();
    final userId = authStore.state?.uId ?? ''; // Obtenha o ID do usuário

    await showDialog(
      context: context,
      builder: (context) {
        final TextEditingController nameController = TextEditingController();
        final TextEditingController typeController = TextEditingController();
        final TextEditingController amountController =
            TextEditingController();

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Ferramenta nova:'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nome:',
                    ),
                  ),
                  TextField(
                    controller: typeController,
                    decoration: const InputDecoration(
                      labelText: 'Tipo:',
                    ),
                  ),
                  TextField(
                    controller: amountController,
                    decoration: const InputDecoration(
                      labelText: 'Quantidade:',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 246, 8, 8)), // Defina a cor de fundo como preto
                  ),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final tool = ToolEntity(
                      tId: UniqueKey().toString(),
                      name: nameController.text,
                      type: typeController.text,
                      amount: int.parse(amountController.text),
                      userId: userId, // Set the user ID accordingly
                    );
                    createTool(tool);
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 0, 85, 255)), // Defina a cor de fundo como preto
                  ),
                  child: const Text('Salvar'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class ToolItem extends StatefulWidget {
  final ToolEntity tool;
  final Function(ToolEntity) onUpdate;
  final Function onDelete;

  const ToolItem({
    Key? key,
    required this.tool,
    required this.onUpdate,
    required this.onDelete,
  }) : super(key: key);

  @override
  _ToolItemState createState() => _ToolItemState();
}

class _ToolItemState extends State<ToolItem> {

  @override
  void initState() {
    super.initState();

  }
  
@override
Widget build(BuildContext context) {
  return Column(
    children: [
      ListTile(
        title: Row(
          children: [
            const SizedBox(width: 8), 
            Text(widget.tool.name),
          ],
        ),
        subtitle: Text(widget.tool.type),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.delete),
              color: const Color.fromARGB(255, 252, 0, 0),
              onPressed: () => widget.onDelete(),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              color: const Color.fromARGB(255, 0, 85, 255),
              onPressed: () => _showEditToolDialog(context),
            ),
          ],
        ),
      ),
      const Divider(
        color: Color.fromARGB(255, 0, 247, 255), // Define a cor do Divider
        thickness: 1.0, // Define a espessura do Divider
      ),
    ],
  );
}

  Future<void> _showEditToolDialog(BuildContext context) async {
    final TextEditingController nameController = TextEditingController(text: widget.tool.name);
    final TextEditingController typeController = TextEditingController(text: widget.tool.type);
    final TextEditingController amountController = TextEditingController(text: widget.tool.amount.toString());

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Editando Ferramenta:'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nome:',
                    ),
                  ),
                  TextField(
                    controller: typeController,
                    decoration: const InputDecoration(
                      labelText: 'Tipo:',
                    ),
                  ),
                  TextField(
                    controller: amountController,
                    decoration: const InputDecoration(
                      labelText: 'Quantidade:',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 246, 8, 8)), // Defina a cor de fundo como preto
                  ),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final updatedTool = widget.tool.copyWith(
                      name: nameController.text,
                      type: typeController.text,
                      amount: int.parse(amountController.text),
                      
                    );
                    widget.onUpdate(updatedTool);
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 0, 85, 255)), // Defina a cor de fundo como preto
                  ),
                  child: const Text('Salvar'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class DrawerListTile extends StatelessWidget {
  String title;
  String page;
  IconData iconData;
  DrawerListTile(
      {super.key,
      required this.title,
      required this.page,
      required this.iconData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Modular.to.pushNamed(page),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 5),
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(fontSize: 20),
          ),
          leading: Icon(iconData),
        ),
      ),
    );
  }
}

