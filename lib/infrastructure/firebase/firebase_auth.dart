import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthInfra {
  // 匿名認証
  Future<UserCredential> signInAnonymously() async {
    try {
      print("匿名認証開始");
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
    throw Exception("Unexpected error occurred."); // Add a throw statement to handle the case when the method doesn't return a value.
  }
}
