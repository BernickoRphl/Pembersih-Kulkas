part of 'services.dart';

class AuthService {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static Future<UserCredential> signInWithGoogle() async{
    Firebase.initializeApp();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await auth.signInWithCredential(credential);
  }

  static Future<bool> signOut() async{
    Firebase.initializeApp();
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    return true;
  }

}