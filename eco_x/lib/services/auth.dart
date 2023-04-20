import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

abstract class AuthBase {
  // getter to get User Info
  User? get currentUser;

  Stream<User?> authStateChanges();

  Future<User?> loginWithEmailAndPassword(String email, String password);

  Future<User?> signUpWithEmailAndPassword(String email, String password);

  Future<User?> signInWithGoogle();

  Future<User?> signINWithFaceBook();

  Future<void> logout();
}

class AppAuth implements AuthBase {
  final _fireBaseAuth = FirebaseAuth.instance;

  // Notifies about changes to the user's Auth state (such as sign-in or sign-out).
  @override
  Stream<User?> authStateChanges() => _fireBaseAuth.authStateChanges();

  @override
  User? get currentUser => _fireBaseAuth.currentUser;

  @override
  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    final userAuth = await _fireBaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return userAuth.user;
  }

  @override
  Future<User?> signINWithFaceBook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    final userAuth = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);

    return userAuth.user;
  }

  @override
  Future<User?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    final userAuth = await _fireBaseAuth.signInWithCredential(credential);

    return userAuth.user;
  }

  @override
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    final userAuth = await _fireBaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userAuth.user;
  }

  @override
  Future<void> logout() async => await _fireBaseAuth.signOut();
}
