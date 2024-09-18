import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../Authorization/API.dart';
import '04.5newpass.dart';



class Verifacaion extends StatelessWidget {
  String opts;
  bool isotpcorrect = true;
  Verifacaion({ required this.opts});
  final Authorization = Get.put(AuthorizationController());
  final TextEditingController OtpController = TextEditingController(); // <<==   use of Get.put


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 40),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Verfication Code',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 35),
                      ),
                    ),
                    const Text(
                        'Please Enter the Varfication code we sent to your Mobile no.'),
                    Text(
                     opts,
                      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),


                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          PinCodeTextField(
                            controller: OtpController,
                            length: 4,
                            appContext: context,
                            onChanged: (value) {
                              if (value==opts){
                                Get.to(NewPass());
                              }

                            },
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.circle,
                              fieldHeight: 60,
                              fieldWidth: 60,
                              activeColor: Colors.black26, // Border color when the field is active
                              selectedColor: Colors.black, // Border color when the field is selected
                              inactiveColor: Colors.black26, // Border color when the field is inactive
                              activeFillColor: Colors.white,
                              selectedFillColor: Colors.white,
                              inactiveFillColor: Colors.white,
                            ),
                            enableActiveFill: true,
                            keyboardType: TextInputType.number,
                            autoDismissKeyboard: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
