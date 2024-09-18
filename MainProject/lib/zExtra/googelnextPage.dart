// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// class NextPage extends StatefulWidget {
//   final String displayName;
//   final String email;
//   final String photoUrl;
//   final GoogleSignIn googleSignIn;
//
//   NextPage({
//     required this.displayName,
//     required this.email,
//     required this.photoUrl,
//     required this.googleSignIn,
//   });
//
//   @override
//   State<NextPage> createState() => _NextPageState();
// }
//
// class _NextPageState extends State<NextPage> {
//   Future<void> handleSignOut(BuildContext context) async {
//     await widget.googleSignIn.disconnect();
//     Navigator.pop(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Details'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             CircleAvatar(
//               backgroundImage: NetworkImage(widget.photoUrl),
//               radius: 40,
//             ),
//             SizedBox(height: 20),
//             Text(widget.displayName, style: TextStyle(fontSize: 20)),
//             Text(widget.email, style: TextStyle(fontSize: 16)),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => handleSignOut(context),
//               child: Text('SIGN OUT'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
