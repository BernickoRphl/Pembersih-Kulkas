part of '../pages/pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginKey = GlobalKey<FormState>();
  final ctrlEmail = TextEditingController();
  final ctrlPass = TextEditingController();
  bool isHide = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign-In Page"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.all(24),
            child: Center(
              child: Form(
                key: _loginKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 48),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: ctrlEmail,
                      decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(Icons.mail),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)))),
                      validator: (value) {
                        return !EmailValidator.validate(value.toString())
                            ? 'Email is not valid!'
                            : null;
                      },
                    ),
                    SizedBox(height: 24),
                    TextFormField(
                      obscureText: isHide,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: ctrlPass,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        suffixIcon: new GestureDetector(
                          onTap: () {
                            setState(() {
                              isHide = !isHide;
                            });
                          },
                          child: Icon(
                            isHide ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                      ),
                      validator: (value) {
                        return value!.length < 6
                            ? "Password must at least 6 characters"
                            : null;
                      },
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (_loginKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });

                              // final response = await AuthService.login(
                              //   ctrlEmail.text.trim(),
                              //   ctrlPass.text.trim(),
                              // );

                              setState(() {
                                isLoading = false;
                              });

                              // if (response.statusCode == 200) {
                              //   UiToast.toastSuccess("Login successful!");
                              //   Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(builder: (context) => MenuPage()),
                              //   );
                              // } else {
                              //   UiToast.toastError("Login failed: ${response.body}");
                              // }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              elevation: 0,
                              textStyle: TextStyle(
                                fontSize: 16,
                              ),
                              padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              )),
                          child: Text("Sign In", style: TextStyle(color: Colors.white),)),
                    ),
                    SizedBox(height: 16),
                    Divider(thickness: 2),
                    SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });

                          final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
                          if (googleUser != null) {
                            final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
                            final AuthCredential credential = GoogleAuthProvider.credential(
                              accessToken: googleAuth.accessToken,
                              idToken: googleAuth.idToken,
                            );
                            final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
                            final User? user = userCredential.user;

                            if (user != null) {
                              // final response = await AuthService.googleLogin(
                              //   user.uid,
                              //   user.email ?? '',
                              //   user.displayName ?? '',
                              // );

                              setState(() {
                                isLoading = false;
                              });

                            //   if (response.statusCode == 200) {
                            //     UiToast.toastSuccess("Welcome back ${user.displayName}");
                            //     Navigator.pushReplacement(
                            //       context,
                            //       MaterialPageRoute(builder: (context) => MenuPage()),
                            //     );
                            //   } else {
                            //     UiToast.toastError("Google login failed: ${response.body}");
                            //   }
                            }
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                            UiToast.toastError("Google sign-in cancelled");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 4,
                            textStyle: TextStyle(
                              fontSize: 16,
                            ),
                            shadowColor: Colors.green,
                            padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            )),
                        label: Text(
                          "Sign In with Google",
                          style: TextStyle(color: Colors.green),
                        ),
                        icon: FaIcon(FontAwesomeIcons.google,
                            color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 0.96),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text("Don't have account? Sign up here.",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
            )
          ),
          isLoading == true ? UiLoading.loadingBlock() : Container(),
        ],
      ),
    );
  }
}