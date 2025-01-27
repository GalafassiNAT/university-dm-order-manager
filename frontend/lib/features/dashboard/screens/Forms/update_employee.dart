import 'package:flutter/material.dart';
import 'package:frontend/features/controllers/user_controller.dart';
import 'package:frontend/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/colors.dart';

class UpdateEmployeeForm extends StatefulWidget {
  final Map<String, dynamic> employee;
  const UpdateEmployeeForm({super.key, required this.employee});

  @override
  State<UpdateEmployeeForm> createState() => _UpdateEmployeeFormState();
}

class _UpdateEmployeeFormState extends State<UpdateEmployeeForm> {
  final UserController userController = Get.put(UserController());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
  TextEditingController();

  bool _obscurePassword = true;
  bool _obscurePasswordConfirmation = true;
  String? _selectedRole;

  final List<Map<String, String>> roles = [
    {'display': 'Administrador', 'value': 'ADM'},
    {'display': 'Chefe', 'value': 'CHEF'},
    {'display': 'Garçom', 'value': 'WAITER'},
  ];

  @override
  void initState() {
    super.initState();
    nameController.text = widget.employee['name'];
    _selectedRole = widget.employee['profileTypeName'];
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = MyHelperFunctions.isDarkMode(context);
    final iconColor = darkMode ? MyColors.white : MyColors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Employee'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: iconColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: 'Nome',
                  prefixIcon: Icon(
                      Icons.person,
                      color: iconColor,),
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Senha',
                prefixIcon: Icon(
                  Icons.lock,
                  color: iconColor,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              obscureText: _obscurePassword,
            ),
            TextFormField(
              controller: passwordConfirmationController,
              validator: (value) {
                if (value != passwordController.text) {
                  return 'As senhas não coincidem';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Confirmar Senha',
                prefixIcon: Icon(
                  Icons.lock,
                  color: iconColor,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePasswordConfirmation
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePasswordConfirmation =
                      !_obscurePasswordConfirmation;
                    });
                  },
                ),
              ),
              obscureText: _obscurePasswordConfirmation,
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Cargo',
                prefixIcon: Icon(
                  Icons.work,
                  color: iconColor,
                ),
              ),
              items: roles.map((role) {
                return DropdownMenuItem<String>(
                  value: role['value'],
                  child: Text(role['display']!),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedRole = value;
                });
              },
              value: _selectedRole,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200,50),
              ),
              onPressed: () {
                if (_selectedRole != null) {
                  if (passwordController.text != passwordConfirmationController.text) {
                    MyHelperFunctions.showSnackBar("As senhas não coincidem",
                        "Red");
                    return;
                  }
                  userController.updateEmployee(widget.employee['id'],
                    nameController.text,
                    passwordController.text,
                    _selectedRole!,
                  );
                }
              },
              child: const Text('Atualizar'),
            ),
          ],
        ),
      ),
    );
  }
}