import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_sign_in/app/landing_page.dart';
import 'package:flutter_google_sign_in/services/auth.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mano',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: LandingPage(
        auth: Auth(),
      )
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';
 
// void main() => runApp(MyApp());
 
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(
//         auth: Auth(),
//       ),
//     );
//   }
// }
 
// class MyHomePage extends StatelessWidget {
//   const MyHomePage({Key key, this.auth}) : super(key: key);
//   final Auth auth;
 
//   Future<void> _signInWithGoogle() async {
//     try {
//       final user = await auth.signInWithGoogle();
//       print('Success! uid: ${user.uid}');
//     } catch (e) {
//       print(e.toString());
//     }
//   }
 
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: RaisedButton(
//           child: Text('Sign in with Google'),
//           onPressed: _signInWithGoogle,
//         ),
//       ),
//     );
//   }
// }
 
// class Auth {
//   Future<User> signInWithGoogle() async {
//     GoogleSignIn googleSignIn = GoogleSignIn();
//     GoogleSignInAccount googleUser = await googleSignIn.signIn();
 
//     if (googleUser != null) {
//       GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//       if (googleAuth.idToken != null && googleAuth.accessToken != null) {
//         final _user = await FirebaseAuth.instance
//             .signInWithCredential(GoogleAuthProvider.credential(
//           idToken: googleAuth.idToken,
//           accessToken: googleAuth.accessToken,
//         ));
//         return _user.user;
//       } else {
//         throw Exception('Missing Google Auth Token');
//       }
//     } else {
//       throw Exception('Google sign in aborted');
//     }
//   }
// }