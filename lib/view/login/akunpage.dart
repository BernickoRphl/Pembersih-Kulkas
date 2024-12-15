part of '../pages/pages.dart';

class AkunPage extends StatefulWidget {
  const AkunPage({super.key});

  @override
  State<AkunPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Account"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await AuthService.signOut().then((value) {
                    if(value){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                      UiToast.toastSuccess("Signout success.");
                    }else{
                      UiToast.toastError("Signout failed!");
                    }
                    setState(() {
                      isLoading = false;
                    });
                  });
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    elevation: 2,
                    textStyle: TextStyle(
                      fontSize: 16,
                    ),
                    padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    )),
                child: Text("Sign Out", style: TextStyle(color: Colors.white),)
              ),
            )
          ),
          isLoading == true ? UiLoading.loadingBlock() : Container(),
        ],
      ),
    );
  }
}