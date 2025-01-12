part of 'services.dart';

// Auth 1
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

// Auth 2
// class AuthService {
//   static FirebaseAuth auth = FirebaseAuth.instance;

//   // Google sign-in method for signing in or registering
//   static Future<UserCredential> signInWithGoogle() async {
//     await Firebase.initializeApp();
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//     final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     return await auth.signInWithCredential(credential);
//   }

//   // Google sign-up method (if user is new, it will create a new user)
//   static Future<UserCredential> registerWithGoogle() async {
//     await Firebase.initializeApp();
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//     final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     // Use Firebase Auth to register or sign in the user
//     return await auth.signInWithCredential(credential);
//   }

//   // Sign out method
//   static Future<bool> signOut() async {
//     await Firebase.initializeApp();
//     await FirebaseAuth.instance.signOut();
//     await GoogleSignIn().signOut();
//     return true;
//   }
// }

class AuthService {
  static const String _baseUrl = 'http://10.0.2.2:8000';

  // Login dengan email dan password
  static Future<http.Response> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    return response;
  }

  // Login dengan Google
  static Future<http.Response> googleLogin(
      String uid, String email, String name) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/google-login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'uid': uid,
        'email': email,
        'name': name,
      }),
    );
    return response;
  }

  // Registrasi dengan email dan password
  static Future<http.Response> register(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    return response;
  }
}
