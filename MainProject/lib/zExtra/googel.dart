import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(MaterialApp(home: SignInDemo()));
}

class SignInDemo extends StatefulWidget {
  @override
  _SignInDemoState createState() => _SignInDemoState();
}

class _SignInDemoState extends State<SignInDemo> {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      // You may want to keep this to handle silent sign-ins
      if (_currentUser != null) {
        _printUserData(_currentUser!);
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn() async {
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        setState(() {
          _currentUser = account;
        });
        _printUserData(account);
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() async {
    await _googleSignIn.disconnect();
    setState(() {
      _currentUser = null;
    });
  }

  void _printUserData(GoogleSignInAccount account) {
    print(">>>>>>>>>>>>>>>>>>>>>>Name: ${account.displayName}");
    print(">>>>>>>>>>>>>>>>>>>>>>pic: ${account.photoUrl}"); // Fixed the photo URL print
    print(">>>>>>>>>>>>>>>>>>>>>>Email: ${account.email}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: _currentUser == null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("You are not signed in."),
            ElevatedButton(
              onPressed: _handleSignIn,
              child: Text('Sign In'),
            ),
          ],
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Signed in as: ${_currentUser!.displayName}"),
            Text("Email: ${_currentUser!.email}"),
            ElevatedButton(
              onPressed: _handleSignOut,
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
