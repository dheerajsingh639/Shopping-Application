import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Authorization/API.dart';
import '04.1Loginpage.dart';

class NewPass extends StatelessWidget {
  final Authorization = Get.put(AuthorizationController());
  final _formKey = GlobalKey<FormState>();

  NewPass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 180,
                ),
                Container(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Create New Password',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 35),
                    ),
                  ),
                ),
                Text(
                    'Your new password is must be different from previosu password'),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: Authorization.mobileController,
                  decoration: InputDecoration(labelText: 'Mobile'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: Authorization.passwordController,
                  decoration: InputDecoration(labelText: 'newp'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an mobile';
                    }
                    if (value.isEmpty) {
                      // explain
                      return 'Please enter a valid mobile .no';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      Authorization.ForgetPassword();
                      Get.to(Loginpage());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    textStyle: TextStyle(fontSize: 16), // Customize text style
                  ),
                  child: const Text(
                    'Sumbit',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
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
