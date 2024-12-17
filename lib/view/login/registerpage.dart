part of '../pages/pages.dart';

// class RegisterPage extends StatefulWidget {
//   const RegisterPage({super.key});

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   final _registerKey = GlobalKey<FormState>();
//   final ctrlName = TextEditingController();
//   final ctrlEmail = TextEditingController();
//   final ctrlPass = TextEditingController();
//   bool isHide = true;
//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Sign-Up Page"),
//         centerTitle: true,
//       ),
//       body: Stack(
//         children: [
//           Container(
//             width: double.infinity,
//             height: double.infinity,
//             padding: EdgeInsets.all(24),
//             child: Center(
//               child: Form(
//                 key: _registerKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: <Widget>[
//                     SizedBox(height: 48),
//                     TextFormField(
//                       controller: ctrlName,
//                       decoration: InputDecoration(
//                           labelText: "Full Name",
//                           prefixIcon: Icon(Icons.person),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.all(Radius.circular(16)))),
//                       validator: (value) {
//                         return value == null || value.isEmpty
//                             ? 'Name is required!'
//                             : null;
//                       },
//                     ),
//                     SizedBox(height: 24),
//                     TextFormField(
//                       keyboardType: TextInputType.emailAddress,
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       controller: ctrlEmail,
//                       decoration: InputDecoration(
//                           labelText: "Email",
//                           prefixIcon: Icon(Icons.mail),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.all(Radius.circular(16)))),
//                       validator: (value) {
//                         return !EmailValidator.validate(value.toString())
//                             ? 'Email is not valid!'
//                             : null;
//                       },
//                     ),
//                     SizedBox(height: 24),
//                     TextFormField(
//                       obscureText: isHide,
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       controller: ctrlPass,
//                       decoration: InputDecoration(
//                         labelText: "Password",
//                         prefixIcon: Icon(Icons.lock),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(16))),
//                         suffixIcon: GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               isHide = !isHide;
//                             });
//                           },
//                           child: Icon(
//                             isHide ? Icons.visibility : Icons.visibility_off,
//                           ),
//                         ),
//                       ),
//                       validator: (value) {
//                         return value!.length < 6
//                             ? "Password must at least 6 characters"
//                             : null;
//                       },
//                     ),
//                     SizedBox(height: 16),
//                     Container(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: () async {
//                           if (_registerKey.currentState!.validate()) {
//                             setState(() {
//                               isLoading = true;
//                             });
//                             await AuthService.registerWithEmail(
//                                     ctrlEmail.text, ctrlPass.text, ctrlName.text)
//                                 .then((value) {
//                               setState(() {
//                                 isLoading = false;
//                               });
//                               UiToast.toastSuccess("Registration successful!");
//                               Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => MenuPage()));
//                             }).onError((error, stackTrace) {
//                               setState(() {
//                                 isLoading = false;
//                               });
//                               UiToast.toastError(
//                                   "Failed to register: ${error.toString()}");
//                               print("Failed to register: ${error.toString()}");
//                             });
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blue,
//                             elevation: 0,
//                             textStyle: TextStyle(
//                               fontSize: 16,
//                             ),
//                             padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16),
//                             )),
//                         child: Text(
//                           "Sign Up",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     Divider(thickness: 2),
//                     SizedBox(height: 16),
//                     GestureDetector(
//                       onTap: () {
//                         Fluttertoast.showToast(
//                             msg: "Move to login page.",
//                             toastLength: Toast.LENGTH_SHORT,
//                             gravity: ToastGravity.BOTTOM,
//                             backgroundColor: Colors.blue,
//                             textColor: Colors.white,
//                             fontSize: 15);
//                         Navigator.pop(context);
//                       },
//                       child: Text(
//                         "Already have an account? Sign in here.",
//                         style: TextStyle(
//                           color: Colors.blue,
//                           fontSize: 16,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           isLoading == true ? UiLoading.loadingBlock() : Container(),
//         ],
//       ),
//     );
//   }
// }
