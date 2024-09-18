import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../Authorization/API.dart';


class pass extends StatelessWidget {
   pass({super.key});

  final Authorization = Get.put(AuthorizationController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          key: _formKey,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Forget Password?',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 35),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            const Text(
                'Enter Mobile associate with your account and we will send an mobile OTP with instruction to change reset your password'),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: Authorization.mobileController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.phone),
                labelText: 'Enter 10-digit number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
                onPressed: () {
                  Authorization.generateOTP();
                },
                child: const Text('send OTP')),
          ],
        ),
      ),
    );
  }
}
