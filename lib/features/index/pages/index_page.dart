import 'package:flutter/material.dart';
import 'package:chacrita/features/guide/pages/guide_page.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      /*appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),*/
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/background_img.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/img/chacrita_logo.png',
                    width: 151,
                    height: 152,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'WELCOME',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Koulen',
                        letterSpacing: 0.6,
                        //height: 52.5,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Center(
                child: TextButton(
                  style: const ButtonStyle(
                    alignment: Alignment.bottomCenter,
                    backgroundColor: WidgetStatePropertyAll(
                        Color.fromRGBO(208, 208, 208, 0.3)),
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.fromLTRB(24, 14, 24, 14)),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(_createSecondRoute());
                  },
                  child: const Text(
                    'GET STARTED',
                    style: TextStyle(
                      fontFamily: 'Abel',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Route _createSecondRoute() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 800),
      pageBuilder: (context, animation, secondaryAnimation) =>
          const GuidePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0); // Desplaza desde la derecha
        const end = Offset.zero; // Llega al centro
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        var opacityAnimation =
            Tween<double>(begin: 0.0, end: 1.0).animate(animation);
        var scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: curve),
        );

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: opacityAnimation,
            child: ScaleTransition(
              scale: scaleAnimation,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
