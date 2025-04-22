import 'package:firebase_auth/firebase_auth.dart';
import '../models/loginuser.dart';
import '../models/firebaseuser.dart';

//-------------------------------------------------------
//          FIREBASE AUTH SERVICE
//-------------------------------------------------------
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser? _firebaseUser(User? user) {
    print("_firebaseUser called with: ${user?.uid}");

    if (user == null) {
      print("_firebaseUser is returning NULL");
      return null;
    }
    // Ensure we return a single firebaseUser object, not a list
    FirebaseUser firebaseUser = FirebaseUser(uid: user.uid);
    print("_firebaseUser created: ${firebaseUser.uid}");

    return firebaseUser;
  }

  Stream<FirebaseUser?> get user {
    return _auth.authStateChanges().map(_firebaseUser);
  }

  get authStateChanges => null;

  // Sign in with email and password using FirebaseAuth
  Future signInEmailPassword(LoginUser login) async {
    print("signInEmailPassword() started...");

    try {
      print("Calling Firebase sign-in...");

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: login.email.trim(), password: login.password.trim());
      // Login success
      print("Firebase sign-in completed");

      User? user = userCredential.user;

      if (user == null) {
        print("ERROR: Firebase returned NULL user!");
        return null;
      }

      FirebaseUser? firebaseUser = _firebaseUser(user);

      print("_firebaseUser returned: ${firebaseUser?.uid}");

      return firebaseUser;
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Error: ${e.code}");
      return FirebaseUser(code: e.code, uid: null);
    } catch (e) {
      print("General Error in signInEmailPassword(): $e");
      return FirebaseUser(code: e.toString(), uid: null);
    }
  }

  // Register user's account
  Future registerEmailPassword(LoginUser login) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: login.email.trim(), password: login.password.trim());
      User? user = userCredential.user;

      print("Registered User UID: ${user?.uid}");

      return _firebaseUser(user);
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Error: ${e.code}");
      return FirebaseUser(code: e.code, uid: null);
    } catch (e) {
      print("General Error: $e");
      return FirebaseUser(code: e.toString(), uid: null);
    }
  }

  // Sign out Method
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      print("SIGN OUT: Success");
    } catch (e) {
      print("SIGN OUT: Fail. $e");
    }
  }
}
