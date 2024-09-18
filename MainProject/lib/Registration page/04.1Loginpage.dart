import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Authorization/API.dart';
import '../Home/05.1Gemstore.dart';
import '04.2createacc.dart';
import '04.3forgetpass.dart';

class Loginpage extends StatefulWidget {
  Loginpage({
    super.key,
  });

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  // Authorization is obj of class API.dart
  final Authorization = Get.put(AuthorizationController());

  // Check data is null or not
  final formKey = GlobalKey<FormState>();

  // Login loading
  late bool isLoading = false;

  // Google sign in main code Start
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  GoogleSignInAccount? currentUser;

  @override
  void initState() {
    super.initState();
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        currentUser = account;
      });
      // You may want to keep this to handle silent sign-ins
      if (currentUser != null) {
        printUserData(currentUser!);
      }
    });
    googleSignIn.signInSilently();
  }

  Future<void> handleSignIn() async {
    try {
      GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        setState(() {
          currentUser = account;
        });
        printUserData(account);
        Get.to(Gemstore());
      }
    } catch (error) {
      print(error);
      Get.snackbar(
        'Network Error',
        'Failed to sign in with Google. Please check your internet connection and try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }

  Future<void> handleSignOut() async {
    await googleSignIn.disconnect();
    setState(() {
      currentUser = null;
    });
  }

  void printUserData(GoogleSignInAccount account) {
    print(">>>>>>>>>>>>>>>>>>>>>>Name: ${account.displayName}");
    print(">>>>>>>>>>>>>>>>>>>>>>pic: ${account.photoUrl}");
    print(">>>>>>>>>>>>>>>>>>>>>>Email: ${account.email}");
  }

  // Google sign in main code End

 
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
                const SizedBox(
                  height: 180,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Log into',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 35),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'your Account'.tr,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 35),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: Authorization.emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an Email';
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
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.to(pass());
                      },
                      child: Text(
                        'Forget Password?',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      setState(() {
                        isLoading = true;
                      });
                      Authorization.loginUser();
                      Future.delayed(Duration(seconds: 3), () {
                        setState(() {
                          isLoading = false;
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
                          'Log In',
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 85,
                    ),
                    // Google sign in function code Start
                    GestureDetector(
                        onTap: () {
                          print("Google Tap");
                          handleSignIn();
                        },
                        child: Image.asset(
                          './images/Goo2.png',
                          height: 40,
                          width: 40,
                        )),
                    // Google sign in function code End
                    const SizedBox(
                      width: 70,
                    ),
                    GestureDetector(
                        onTap: () {
                          print("Facebook Tap");
                        },
                        child: Image.asset(
                          './images/fb2.png',
                          height: 65,
                          width: 65,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 70,
                ),
                Center(
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 60,
                        ),
                        Text('Don\'t have an account'),
                        TextButton(
                          onPressed: () {
                            Get.to(CreateAcc());
                          },
                          child: const Text(
                            ' Sign up',
                            style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
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
