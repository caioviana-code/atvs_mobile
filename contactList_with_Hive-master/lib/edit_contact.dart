import 'package:contact_crud_hive/form_contact_fielder.dart';
import 'package:contact_crud_hive/home_contact.dart';
import 'package:flutter/material.dart';

import 'common/box_user.dart';
import 'model/user.dart';

class EditContact extends StatefulWidget {
  const EditContact({super.key});
  
  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  final _formKey = GlobalKey<FormState>();

  final idUserControl = TextEditingController();
  final nameUserControl = TextEditingController();
  final numberUserControl =  TextEditingController();
  final emailUserControl = TextEditingController();

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
      box.add(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Editar Contato'),
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
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => HomeContact()),
                          )
                        },
                        child: const Text('Atualizar'),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}