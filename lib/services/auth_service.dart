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

// Auth 3
// class AuthService {
//   static const String _baseUrl = 'http://10.0.2.2:8000';

//   // Login dengan email dan password
//   static Future<http.Response> login(String email, String password) async {
//     final response = await http.post(
//       Uri.parse('$_baseUrl/login'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'email': email,
//         'password': password,
//       }),
//     );
//     return response;
//   }

//   // Login dengan Google
//   static Future<http.Response> googleLogin(
//       String uid, String email, String name) async {
//     final response = await http.post(
//       Uri.parse('$_baseUrl/google-login'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'uid': uid,
//         'email': email,
//         'name': name,
//       }),
//     );
//     return response;
//   }

//   // Registrasi dengan email dan password
//   static Future<Map<String, dynamic>> register(
//       String email, String password) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$_baseUrl/register'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'email': email,
//           'password': password,
//         }),
//       );

//       if (response.statusCode == 200) {
//         // Registrasi berhasil
//         return jsonDecode(response.body);
//       } else if (response.statusCode == 500) {
//         // Server error
//         throw "Server error: ${response.body}";
//       } else {
//         // Error lainnya
//         throw "Error: ${response.statusCode} - ${response.body}";
//       }
//     } catch (e) {
//       throw "Error during registration: $e";
//     }
//   }
// }

// Auth 4
class AuthService {
  final Dio _dio = Dio();
  final String _baseUrl = 'http://your-laravel-backend.com'; // Change this
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<Map<String, dynamic>> register(
      String name, String email, String password) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/api/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      await _saveToken(response.data['access_token']);
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/api/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      await _saveToken(response.data['access_token']);
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) throw 'Google Sign In was canceled';

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final response = await _dio.post(
        '$_baseUrl/api/google-auth',
        data: {
          'access_token': googleAuth.accessToken,
        },
      );

      await _saveToken(response.data['access_token']);
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> logout() async {
    try {
      final token = await _getToken();
      await _dio.post(
        '$_baseUrl/api/logout',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      await _clearToken();
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  String _handleError(dynamic error) {
    if (error is DioError) {
      if (error.response?.data != null) {
        return error.response?.data['message'] ?? 'An error occurred';
      }
      return error.message ?? 'An error occurred';
    }
    return error.toString();
  }
}
