part of 'pages.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin{

  final splashDelay = 4;
  AnimationController? _controller;

  _loadWidget() async{
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MenuPage()));
      UiToast.toastSuccess(
          "Welcome back " + auth.currentUser!.displayName.toString());
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
      UiToast.toastWarning("Not logged in.");
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _loadWidget();
  }

  @override
  void dispose(){
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Lottie.asset("assets/splash.json",
          controller: _controller, onLoaded: (composition) {
            _controller!
              ..duration = composition.duration
              ..forward();
          }
        )
      ),
    );
  }
}