import 'package:contact_crud_hive/common/box_user.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';


import 'contact_listview.dart';
import 'form_contact_fielder.dart';
import 'model/user.dart';

class HomeContact extends StatefulWidget {
  const HomeContact({super.key});

  @override
  State<HomeContact> createState() => _HomeContactState();
}

class _HomeContactState extends State<HomeContact> {
  final _formKey = GlobalKey<FormState>();

  final idUserControl = TextEditingController();
  final nameUserControl = TextEditingController();
  final numberUserControl =  TextEditingController();
  final emailUserControl = TextEditingController();

  @override
  void dispose() {
    idUserControl.dispose();
    nameUserControl.dispose();
    numberUserControl.dispose();
    emailUserControl.dispose();
    Hive.close(); // fechar as boxes
    super.dispose();
  }

  Future<void> addUser(
      String id, String name, String email, String number) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final user = UserModel()
        ..user_id = id
        ..user_name = name
        ..email = email
        ..number = number;

      // pega a caixa aberta
      final box = UserBox.getUsers();
      box.add(user).then((value) => _clearTextControllers());
    }
  }

  Future<void> editUser(UserModel user) async {
    idUserControl.text = user.user_id;
    nameUserControl.text = user.user_name;
    numberUserControl.text = user.number;
    emailUserControl.text = user.email;
  }

  void _clearTextControllers() {
    idUserControl.clear();
    nameUserControl.clear();
    numberUserControl.clear();
    emailUserControl.clear();
  }

  @override
  Widget build(BuildContext context) {
  

    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Contatos'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              FormContactFielder(
                controller: idUserControl,
                iconData: Icons.person,
                hintTextName: 'Código',
              ),
              const SizedBox(height: 10),
              FormContactFielder(
                controller: nameUserControl,
                iconData: Icons.person_outline,
                hintTextName: 'Nome',
              ),
              const SizedBox(height: 10),
              FormContactFielder(
                controller: numberUserControl,
                iconData: Icons.numbers,
                textInputType: TextInputType.phone,
                hintTextName: 'Número',
              ),
              const SizedBox(height: 10),
              FormContactFielder(
                controller: emailUserControl,
                iconData: Icons.email_outlined,
                textInputType: TextInputType.emailAddress,
                hintTextName: 'Email',
              ),
              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.only(left: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => {
                          addUser(
                            idUserControl.text,
                            nameUserControl.text,
                            emailUserControl.text,
                            numberUserControl.text,
                          ),
                        },
                        child: const Text('Adicionar'),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _clearTextControllers,
                        child: const Text('Limpar Campos'),
                      ),
                    ),
                  ],
                ),
              ), 
              const SizedBox(height: 20),
              ValueListenableBuilder(
                valueListenable: UserBox.getUsers().listenable(),
                builder: (BuildContext context, Box userBox, Widget? child) {
                  final users = userBox.values.toList().cast<UserModel>();
                  if (users.isEmpty) {
                    return Center(
                      child: const Text(
                        'No Users Found',
                        style: const TextStyle(fontSize: 20),
                      ),
                    );
                  } else {
                    return ContactListView(
                      users: users,
                      onEditContact: editUser,
                    );
                  }
                },
              ),         //ContactListView(users: users)
            ],
          ),
        ),
      ),
    );
  }
}
