import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:googlelogin/Home/05.1Gemstore.dart';
import 'package:googlelogin/Registration%20page/04.1Loginpage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Registration page/04.4VerficationCode.dart';


class AuthorizationController extends GetxController {


  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();


  // Server uploaded login Api give by sarwar sir  
  // Future<void> login() async {
  //   final String email = emailController.text;
  //   final String password = passwordController.text;
  //   final url = Uri.parse('https://thedheeraj.xyz/loginapi.php');
  //   try {
  //     final response = await http.post(
  //       url,
  //       body: {
  //         'email': email,
  //         'password': password,
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> responseData = json.decode(response.body);
  //       print('response status : ${response.statusCode}');
  //       print('response body : ${response.body}');
  //       if (responseData['data'] == "true") {
  //         SharedPreferences prefs = await SharedPreferences.getInstance();
  //         await prefs.setBool('isLogin', true);
  //         Get.to(Gemstore());
  //       } else {
  //         Get.snackbar(
  //           'Failed',
  //           responseData['msg'],
  //           snackPosition: SnackPosition.BOTTOM,
  //           backgroundColor: Colors.red,
  //           colorText: Colors.white,
  //           duration: const Duration(seconds: 2),
  //         );
  //       }
  //     } else {
  //       Get.snackbar(
  //         'Error',
  //         'Server error. Please try again later.',
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white,
  //         duration: const Duration(seconds: 2),
  //       );
  //     }
  //   } catch (e) {
  //     Get.snackbar(
  //       'Network Error',
  //       'Failed to connect to the server. Please check your internet connection and try again.',
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //       duration: const Duration(seconds: 2),
  //     );
  //   }
  // }


  // Server uploaded register Api give by sarwar sir  
  // Future<void> register() async {
  //   final String name = nameController.text;
  //   final String email = emailController.text;
  //   final String password = passwordController.text;
  //   final String mobile = mobileController.text;
  //   final url = Uri.parse('https://www.thedheeraj.xyz/singup.php');
  //   final response = await http.post(
  //     // headers: {},how to provide authorization key;
  //     url,
  //     body: {
  //       'name': name,
  //       'email': email,
  //       'password': password,
  //       'mobile': mobile,
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     if (kDebugMode) {
  //       print('Signup successful: ${response.body}');
  //     }
  //     Map<String, dynamic> responseData = jsonDecode(response.body);
  //     if (kDebugMode) {
  //       print("successfully register ${responseData['data']}");
  //     }
  //     if (responseData['data'] == true) {
  //       if (kDebugMode) {
  //         print("successful");
  //       }
  //     } else {
  //       if (kDebugMode) {
  //         print("data incorrect");
  //       }
  //     }
  //   } else {
  //     if (kDebugMode) {
  //       print('Signup failed: ${response.statusCode}');
  //     }
  //   }
  // }
   

  //Own made loginUser api localy in my node js server
  
  Future<void> loginUser() async {
     final String email = emailController.text;
     final String password = passwordController.text;
  final response = await http.post(
    Uri.parse('http://192.168.0.135:3000/login'), 
    body:({
      'email': email,
      'password': password,
    }),
  );
  if (response.statusCode == 200) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
           await prefs.setBool('isLogin', true);
           Get.to(Gemstore());
    final jsonResponse = jsonDecode(response.body);
    String message = jsonResponse['msg'];
     print(message);      
  }
   else {
    // Handle error response
    final jsonResponse = jsonDecode(response.body);
    String errorMessage = jsonResponse['msg'];
    print(errorMessage);
  }
}

  
  //Own made registerUser api localy in my node js server
  Future<void> registerUser() async {
  final String name = nameController.text;
  final String email = emailController.text;
  final String password = passwordController.text;
  final String mobile = mobileController.text;

  const String url = 'http://192.168.0.135/register';

  try {
    final response = await http.post(
      Uri.parse(url),
    
      body: ({
        'name': name,
        'email': email,
        'password': password,
        'mobile': mobile,
      }),
    );

    if (response.statusCode == 200) {
      // Registration successful, navigate to login page
      Get.to(Loginpage());
      print('Response: ${response.body}');
    } else if (response.statusCode == 400) {
      // Handle bad request
      final errorMsg = jsonDecode(response.body)['msg'];
      print('Error: $errorMsg');
    } 
    else {
      // Handle other errors
      print('Server Error: ${response.statusCode}');
    }
  } catch (e) {
    // Handle any exceptions
    print('Exception occurred: $e');
  }
}


  void generateOTP() async {


    final random = Random();
    final otps = StringBuffer();
    for (int i = 0; i < 4; i++) {
      otps.write(random.nextInt(10).toString());
      print('youtr otp is $otps');

    }
    String mobile = mobileController.text;
    if (mobile.length != 10) {
      Get.snackbar('Invalid', 'Please enter a 10-digit mobile number.');
      return;
    }

    final response = await http.post(
        Uri.parse('https://thedheeraj.xyz/mobilecheckIndatabase.php'),
        body: {
          'mobile': mobile,
        });

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      print('response status : ${response.statusCode}');
      print('response body : ${response.body}');

      if (responseData['success'] == true) {
        Get.to(Verifacaion(opts: otps.toString()));

        Get.snackbar(
          'Successfully',
          responseData['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 1),
        );
      } else {
        Get.snackbar(
          'No user found with that mobile number.',
          responseData['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    }

    // ignore: unused_element
    Future<void> sumbit() async {
      final String newp = passwordController.text;
      final String mobile = mobileController.text;
      final Url = Uri.parse('https://thedheeraj.xyz/forgetpassword.php');
      final response = await http.post(
        Url,
        body: {
          'newp': newp,
          'mobile': mobile,
        },
      );
      if (response.statusCode == 200) {
        print('Signup successful: ${response.body}');
      } else {
        print('Signup failed: ${response.statusCode}');
      }
    }
  }


  Future<void> ForgetPassword() async {
    final String mobile = mobileController.text;
    final String newPassword = passwordController.text;
    final response = await http.post(
      Uri.parse('https://thedheeraj.xyz/forgetpassword.php'),
      body: {
        'mobile': mobile,
        'newp': newPassword,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body); // Explain

      print('response status : ${response.statusCode}');
      print('response body : ${response.body}');

      if (responseData['data'] == true) {
        Get.snackbar(
          'Successfully',
          responseData['Password Has Been changed Successfully'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 1),
        );
      } else {
        Get.snackbar(
          'No user found with that mobile number.',
          responseData['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    }
  }


   Future<List<String>> fetchImageUrls() async {
    try {
      final response = await http.get(Uri.parse("http://192.168.0.103:3000/imageGet"));

      if (response.statusCode == 200) {
        
        
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse.map((url) => url.toString()).toList();
      }

       else  {
        throw Exception('No images found');
      }

    }
     catch (e) {
      throw Exception('Internal server error');
    }
  }

}
