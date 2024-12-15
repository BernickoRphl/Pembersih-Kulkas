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
                          onPressed: () async {},
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
                          await AuthService.signInWithGoogle().then((value) {
                            setState(() {
                              isLoading = false;
                            });
                            UiToast.toastSuccess("Welcome back ${value.user!.displayName}");
                            Navigator.pushReplacement(
                              context, MaterialPageRoute(
                                builder: (context) => MenuPage()
                              )
                            );
                          }).onError((error, stackTrace) {
                            setState(() {
                              isLoading = false;
                            });
                            UiToast.toastError("Gagal Sign In karena: ${error.toString()}");
                            print("Gagal Sign In karena: ${error.toString()}");
                          });
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
              onTap: (){
                Fluttertoast.showToast(
                  msg: "Move to register page.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 15
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