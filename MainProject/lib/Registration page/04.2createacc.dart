import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../Authorization/API.dart';
import '04.1Loginpage.dart';

class CreateAcc extends StatefulWidget {
  CreateAcc({super.key});

  @override
  State<CreateAcc> createState() => _CreateAccState();
}

class _CreateAccState extends State<CreateAcc> {
  final Authorization = Get.put(AuthorizationController());

  // Problem same acc re create then push notification account already exit   <<======

  // Check data is null or not
  final formKey = GlobalKey<FormState>();

  // Login loading
  late bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              // what is the use of Widget

              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Create',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 35),
                ),
              ),

              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'your Account',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 35),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: Authorization.nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an Name';
                  }
                  if (value.isEmpty) {
                    return 'Please enter a valid Name address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: Authorization.emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    // explain
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: Authorization.passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true, // use to hiding the password;
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: Authorization.mobileController,
                decoration: InputDecoration(labelText: 'mobile no.'),
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
              SizedBox(height: 20),


              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    setState(() {
                      isLoading = true; // Start showing the loading indicator
                    });

                    // Add a delay of 3 seconds before executing the registration process
                    Future.delayed(Duration(seconds: 3), () {
                      Authorization.registerUser();

                      setState(() {
                        isLoading = false; // Stop showing the loading indicator
                      });
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: isLoading
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        'Sign up',
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
              ),

              Center(
                child: Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      Get.to(Loginpage());
                    },
                    child: Text(
                      'Already have an account login up',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
