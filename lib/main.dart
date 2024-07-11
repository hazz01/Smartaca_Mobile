import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smartaca_alpha_6/Setting.dart';
import 'package:smartaca_alpha_6/SettingSawah.dart';
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
    return const Scaffold(
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
                backgroundColor: widget.currentPage == 3 ? Colors.green : primaryColor,
                child: const Icon(
                  Icons.home,
                ),
                elevation: 0.1,
                onPressed: () {
                  widget.onPageChanged(3);
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration.zero,
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const HomePage(),
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
                  selected: widget.currentPage == 1,
                  onPressed: () {
                    widget.onPageChanged(1);
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
                  selectedColor: Colors.green,
                ),
                NavBarIcon(
                  text: "Search",
                  icon: Icons.local_grocery_store_outlined,
                  selected: widget.currentPage == 2,
                  onPressed: () {
                    widget.onPageChanged(2);
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration.zero,
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const Toko(),
                      ),
                    );
                  },
                  defaultColor: secondaryColor,
                  selectedColor: Colors.green,
                ),
                const SizedBox(width: 56),
                NavBarIcon(
                    text: "Cart",
                    icon: Icons.notifications_none,
                    selected: widget.currentPage == 4,
                    onPressed: () {
                      widget.onPageChanged(4);
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
                    selectedColor: Colors.green),
                NavBarIcon(
                  text: "Calendar",
                  icon: Icons.account_circle_outlined,
                  selected: widget.currentPage == 5,
                  onPressed: () {
                    widget.onPageChanged(5);
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration.zero,
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const SettingInfoSawah(),
                      ),
                    );
                  },
                  selectedColor: Colors.green,
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

class NavBarIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool selected;
  final VoidCallback onPressed;
  final Color defaultColor;
  final Color selectedColor;

  const NavBarIcon({
    Key? key,
    required this.text,
    required this.icon,
    required this.selected,
    required this.onPressed,
    required this.defaultColor,
    required this.selectedColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: selected ? selectedColor : defaultColor),
          Text(
            text,
            style: TextStyle(color: selected ? selectedColor : defaultColor),
          ),
        ],
      ),
    );
  }
}

class BottomNavCurvePainter extends CustomPainter {
  final Color backgroundColor;
  final Color shadowColor;
  final double elevation;

  BottomNavCurvePainter({
    required this.backgroundColor,
    required this.shadowColor,
    required this.elevation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = backgroundColor;
    final Path path = Path();

    // Draw the custom bottom navigation bar curve
    path.lineTo(size.width * 0.35, 0);
    path.quadraticBezierTo(
      size.width * 0.40,
      0,
      size.width * 0.40,
      20,
    );
    path.arcToPoint(
      Offset(size.width * 0.60, 20),
      radius: const Radius.circular(20),
      clockwise: false,
    );
    path.quadraticBezierTo(
      size.width * 0.60,
      0,
      size.width * 0.65,
      0,
    );
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    // Draw shadow
    canvas.drawShadow(path, shadowColor, elevation, true);

    // Draw path
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
