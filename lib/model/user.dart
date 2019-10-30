import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class User {
  static String id;
  static String name;
  static String imageUrl;
  static String email;

  User.fromMap(Map<String, dynamic> map) {
    User.id = map['userid'];
    User.name = map['name'];
    // image = map['image'];
    User.imageUrl = map['image_url'];
  }
}

class UserService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  // final FacebookLogin _facebookLogin = new FacebookLogin();

  signIn(BuildContext context) async {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text("Sign In"),
    ));
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseUser userDetails =
        await _firebaseAuth.signInWithCredential(credential);

    User.id = userDetails.providerId;
    User.name = userDetails.displayName;
    User.imageUrl = userDetails.photoUrl;
    User.email = userDetails.email;
    print(userDetails);
  }

  // signInWithFb(BuildContext context) async {
  //   Scaffold.of(context).showSnackBar(new SnackBar(
  //     content: new Text("Sign In With Facebook"),
  //   ));
  //   final FacebookLoginResult result = await _facebookLogin.logIn([]);
  //   FacebookAccessToken myToken = result.accessToken;
  //   final AuthCredential credential =
  //       FacebookAuthProvider.getCredential(accessToken: myToken.token);

  //   FirebaseUser userDetails =
  //       (await _firebaseAuth.signInWithCredential(credential));
  //   print(userDetails);
  //   User.id = userDetails.providerId;
  //   User.name = userDetails.displayName;
  //   User.imageUrl = userDetails.photoUrl;
  //   User.email = userDetails.email;
  // }

  signOut() async {
    // await _facebookLogin.logOut();
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut().then((_) {
      User.id = null;
      User.name = null;
      User.imageUrl = null;
      User.email = null;
    });
  }
}
