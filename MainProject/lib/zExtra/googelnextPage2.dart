// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'googelnextPage.dart';
//
// void main() {
//   runApp(MaterialApp(home: trash1()));
// }
//
// class trash1 extends StatefulWidget {
//   @override
//   _trash1State createState() => _trash1State();
// }
//
// class _trash1State extends State<trash1> {
//   GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: [
//       'email',
//     ],
//   );
//
//   GoogleSignInAccount? currentUser;
//
//   @override
//   void initState() {
//     super.initState();
//     _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
//       setState(() {
//         currentUser = account;
//       });
//     });
//     _googleSignIn.signInSilently();
//   }
//
//   Future<void> _handleSignIn() async {
//     try {
//       await _googleSignIn.signIn();
//       if (_googleSignIn.currentUser != null) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => NextPage(
//               displayName: _googleSignIn.currentUser!.displayName ?? '',
//               email: _googleSignIn.currentUser!.email,
//               photoUrl: _googleSignIn.currentUser!.photoUrl ?? '',
//               googleSignIn: _googleSignIn,
//             ),
//           ),
//         );
//       }
//     } catch (error) {
//       print(error);
//     }
//   }
//
//   // Future<void> _handleSignOut() async {
//   //   await _googleSignIn.disconnect();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     // GoogleSignInAccount? user = currentUser;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Sign-In Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             //if (user != null)
//             Column(
//               children: <Widget>[
//                 // ListTile(
//                 //   leading: GoogleUserCircleAvatar(
//                 //     identity: user,
//                 //   ),
//                 //   title: Text(user.displayName ?? ''),
//                 //   subtitle: Text(user.email),
//                 // ),
//                 // ElevatedButton(
//                 //   onPressed: _handleSignOut,
//                 //   child: Text('SIGN OUT'),
//                 // ),
//               ],
//             ),
//             //else
//             ElevatedButton(
//               onPressed: _handleSignIn,
//               child: Text('SIGN IN'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
