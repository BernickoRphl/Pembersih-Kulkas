part of 'services.dart';

// class AuthService {
//   static FirebaseAuth auth = FirebaseAuth.instance;

//   static Future<UserCredential> signInWithGoogle() async{
//     Firebase.initializeApp();
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//     final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     return await auth.signInWithCredential(credential);
//   }

//   static Future<bool> signOut() async{
//     Firebase.initializeApp();
//     await FirebaseAuth.instance.signOut();
//     await GoogleSignIn().signOut();
//     return true;
//   }
// }

class AuthService {
  static FirebaseAuth auth = FirebaseAuth.instance;

  // Google sign-in method for signing in or registering
  static Future<UserCredential> signInWithGoogle() async {
    await Firebase.initializeApp();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await auth.signInWithCredential(credential);
  }

  // Google sign-up method (if user is new, it will create a new user)
  static Future<UserCredential> registerWithGoogle() async {
    await Firebase.initializeApp();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Use Firebase Auth to register or sign in the user
    return await auth.signInWithCredential(credential);
  }

  // Sign out method
  static Future<bool> signOut() async {
    await Firebase.initializeApp();
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    return true;
  }
}
