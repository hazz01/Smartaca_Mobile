import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smartaca_alpha_6/Setting.dart';
import 'package:smartaca_alpha_6/Toko.dart';
import 'package:smartaca_alpha_6/home_page.dart';
import 'package:smartaca_alpha_6/iot.dart';
import 'package:smartaca_alpha_6/setting_sawah.dart';
import 'package:smartaca_alpha_6/temperature.dart';
import 'package:smartaca_alpha_6/vitamin.dart';
import 'package:smartaca_alpha_6/waterdischarge.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  // List<Widget> pages = const [
  //   HomePage(),
  //   Settings(),
  //   HomePage(),
  //   Settings(),
  //   Settings()
  // ];

  FirebaseDatabase database = FirebaseDatabase.instance;
  String temperature = 'Loading...';
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Water System'),
      //   automaticallyImplyLeading: false,
      //   leading: IconButton(
      //     onPressed: () {
      //       Navigator.of(context).push(
      //         MaterialPageRoute(
      //           builder: (BuildContext context) {
      //             return const Settings();
      //           },
      //         ),
      //       );
      //     },
      //     icon: const Icon(Icons.account_circle),
      //   ),
      //   centerTitle: true,
      //   actions: <Widget>[
      //     IconButton(
      //       onPressed: () {
      //         Navigator.of(context).push(
      //           MaterialPageRoute(
      //             builder: (BuildContext context) {
      //               return const Settings();
      //             },
      //           ),
      //         );
      //       },
      //       icon: const Icon(Icons.settings),
      //     ),
      //   ],
      // ),
      // appBar: AppBar(
      //   title: const Text('Smartaca'),
      // ),
      body: HomePage(), // Use currentPage to switch between pages
      // bottomNavigationBar:
      //     const BottomNavBarRaisedInsetFb1(
      //     ), //Remember to add extendBody: true to scaffold!(), //Remember to add extendBody: true to scaffold!
    );
  }
}

class BottomNavBarRaisedInsetFb1 extends StatefulWidget {
  const BottomNavBarRaisedInsetFb1(
      {Key? key, required this.currentPage, required this.onPageChanged})
      : super(key: key);

  final int currentPage;
  final Function(int) onPageChanged;

  @override
  _BottomNavBarRaisedInsetFb1State createState() =>
      _BottomNavBarRaisedInsetFb1State();
}

class _BottomNavBarRaisedInsetFb1State
    extends State<BottomNavBarRaisedInsetFb1> {
  // int currentPage = 0;

  //     void changePage(int index) {
  //   setState(() {
  //     currentPage = index;
  //   });
  // }

  //- - - - - - - - - instructions - - - - - - - - - - - - - - - - - -
  // WARNING! MUST ADD extendBody: true; TO CONTAINING SCAFFOLD
  //
  // Instructions:
  //
  // add this widget to the bottomNavigationBar property of a Scaffold, along with
  // setting the extendBody parameter to true i.e:
  //
  // Scaffold(
  //  extendBody: true,
  //  bottomNavigationBar: BottomNavBarRaisedInsetFb1()
  // )
  //
  // Properties such as color and height can be set by changing the properties at the top of the build method
  //
  // For help implementing this in a real app, watch https://www.youtube.com/watch?v=C0_3w0kd0nc. The style is different, but connecting it to navigation is the same.
  //
  //- - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - -

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = 56;

    const primaryColor = Colors.blue;
    const secondaryColor = Colors.black54;
    const accentColor = const Color(0xffffffff);
    const backgroundColor = Colors.white;

    const shadowColor = Colors.grey; //color of Navbar shadow
    double elevation = 100; //Elevation of the bottom Navbar

    print("currentPage: $widget.onPageChanged");

    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(size.width, height),
            painter: BottomNavCurvePainter(
                backgroundColor: backgroundColor,
                shadowColor: shadowColor,
                elevation: elevation),
          ),
          Center(
            heightFactor: 0.6,
            child: FloatingActionButton(
                backgroundColor: primaryColor,
                child: const Icon(
                  Icons.home,
                ),
                elevation: 0.1,
                onPressed: () {
                  setState(() {
                    widget.onPageChanged == 1;
                  });
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration.zero,
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          HomePage(),
                    ),
                  );
                }),
          ),
          SizedBox(
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NavBarIcon(
                  text: "Home",
                  icon: Icons.donut_small_sharp,
                  selected: widget.onPageChanged == 1,
                  onPressed: () {
                    setState(() {
                      // print("currentPage: $widget.onPageChanged");
                      widget.onPageChanged == 1;
                    });
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration.zero,
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            Temperature(),
                      ),
                    );
                  },
                  defaultColor: secondaryColor,
                  selectedColor: primaryColor,
                ),
                NavBarIcon(
                  text: "Search",
                  icon: Icons.local_grocery_store_outlined,
                  selected: widget.onPageChanged == 2,
                  onPressed: () {
                    setState(() {
                      widget.onPageChanged == 2;
                    });
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration.zero,
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            Toko(),
                      ),
                    );
                  },
                  defaultColor: secondaryColor,
                  selectedColor: primaryColor,
                ),
                const SizedBox(width: 56),
                NavBarIcon(
                    text: "Cart",
                    icon: Icons.notifications_none,
                    selected: widget.onPageChanged == 4,
                    onPressed: () {
                      setState(() {
                        widget.onPageChanged == 1;
                      });
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration.zero,
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  Settings(),
                        ),
                      );
                    },
                    defaultColor: secondaryColor,
                    selectedColor: primaryColor),
                NavBarIcon(
                  text: "Calendar",
                  icon: Icons.account_circle_outlined,
                  selected: widget.onPageChanged == 5,
                  onPressed: () {
                    setState(() {
                      widget.onPageChanged == 1;
                    });
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration.zero,
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            Settings(),
                      ),
                    );
                  },
                  selectedColor: primaryColor,
                  defaultColor: secondaryColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavCurvePainter extends CustomPainter {
  BottomNavCurvePainter(
      {this.backgroundColor = Colors.white,
      this.insetRadius = 38,
      this.shadowColor = Colors.grey,
      this.elevation = 100});

  Color backgroundColor;
  Color shadowColor;
  double elevation;
  double insetRadius;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    Path path = Path();

    double insetCurveBeginnningX = size.width / 2 - insetRadius;
    double insetCurveEndX = size.width / 2 + insetRadius;

    path.lineTo(insetCurveBeginnningX, 0);
    path.arcToPoint(Offset(insetCurveEndX, 0),
        radius: Radius.circular(41), clockwise: true);

    path.lineTo(size.width, 0);

    path.lineTo(size.width, size.height + 56);
    path.lineTo(
        0,
        size.height +
            56); //+56 here extends the navbar below app bar to include extra space on some screens (iphone 11)
    canvas.drawShadow(path, shadowColor, elevation, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class NavBarIcon extends StatelessWidget {
  const NavBarIcon(
      {Key? key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPressed,
      this.selectedColor = const Color(0xffFF8527),
      this.defaultColor = Colors.black54})
      : super(key: key);
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;
  final Color defaultColor;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: Icon(
            icon,
            size: 25,
            color: selected ? selectedColor : defaultColor,
          ),
        ),
      ],
    );
  }
}
