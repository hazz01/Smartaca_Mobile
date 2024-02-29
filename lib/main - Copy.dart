import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smartaca_alpha_6/Setting.dart';
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
  int currentPage = 0;
  List<Widget> pages = const [
    Temperature(),
    WaterDischarge(),
    Vitamin(),
    Settings(),
  ];

  FirebaseDatabase database = FirebaseDatabase.instance;
  String temperature = 'Loading...';

  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    final temperatureRef = database.reference().child('Device1/Temp');
    temperatureRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          temperature = event.snapshot.value.toString();
          debugPrint("Temp: $temperature");
        });
      } else {
        if (kDebugMode) {
          print('No Data Available.');
        }
      }
    });

    final peltierPowerRef = database.reference().child('Device1/Peltier');
    peltierPowerRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          bool peltierPower = event.snapshot.value as bool;
        });
      } else {
        if (kDebugMode) {
          print('No Data Available.');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water System'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            setState(() {
              currentPage = 3;
            });
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              // Tambahkan logika aksi untuk ikon akun di sini
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      // appBar: AppBar(
      //   title: const Text('Smartaca'),
      // ),
      body: pages[currentPage], // Use currentPage to switch between pages
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.thermostat),
            label: 'Temperature',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.water_drop_rounded),
            label: 'Water Discharge',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.health_and_safety),
            label: 'Vitamin',
          ),
        ],
        currentIndex: currentPage,
        onTap: (int index) {
          setState(() {
            currentPage = index;
          });
        },
      ),
    );
  }
}
