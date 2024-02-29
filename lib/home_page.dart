import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'temperature.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    FirebaseDatabase database = FirebaseDatabase.instance;

  int currentPage = 0; // make sure it's initialized

  bool peltierPower = false;
  // int currentPage = 0;

  String temperature = 'Loading...';
  String humid = 'Loading...';
  String moist = 'Loading...';
  String light = 'Loading...';


  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    final temperatureRef = database.reference().child('Device1/Temp');
    final humidRef = database.reference().child('Device1/Humid');
    final moistRef = database.reference().child('Device1/Moist');
    final lightRef = database.reference().child('Device1/Light');

    temperatureRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          temperature = event.snapshot.value.toString();
          debugPrint("[Home] Temp: $temperature");
        });
      } else {
        if (kDebugMode) {
          print('No Data Available.');
        }
      }
    });
    humidRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          humid = event.snapshot.value.toString();
          debugPrint("[Home] Humid: $humid");
        });
      } else {
        if (kDebugMode) {
          print('No Data Available.');
        }
      }
    });
    moistRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          moist = event.snapshot.value.toString();
          debugPrint("[Home] Moist: $moist");
        });
      } else {
        if (kDebugMode) {
          print('No Data Available.');
        }
      }
    });
    lightRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          light = event.snapshot.value.toString();
          debugPrint("[Home] Light: $light");
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
          peltierPower = event.snapshot.value as bool;
        });
      } else {
        if (kDebugMode) {
          print('No Data Available.');
        }
      }
    });
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   // Hentikan event listener
  //   // database.reference().child('Device1/Temp').onValue.drain();
  //   // database.reference().child('Device1/Peltier').onValue.drain();
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 110,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        10), // Adjust the radius as needed
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.green,
                        offset: Offset(0, 2),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.circle,
                        color: Colors.green,
                      ),
                      const SizedBox(
                          height:
                              8), // Add some space between the Icon and Text widgets
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: const TextSpan(
                          text: 'Kondisi',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: const TextSpan(
                          text: 'Aman',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 250,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        10), // Adjust the radius as needed
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // const Icon(Icons.access_alarm),
                      // const SizedBox(
                      //     height:
                      //         8), // Add some space between the Icon and Text widgets
                      // const SizedBox(height: 5,),
                      RichText(
                        text: const TextSpan(
                          text: 'Penyebab',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      RichText(
                        text: const TextSpan(
                          text: '-',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: const TextSpan(
                          text: 'Solusi',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                      RichText(
                        text: const TextSpan(
                          text: '-',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 110,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        10), // Adjust the radius as needed
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.water_drop_outlined),
                      const SizedBox(
                          height:
                              8), // Add some space between the Icon and Text widgets
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: const TextSpan(
                          text: 'Temperature',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: TextSpan(
                          text: '$temperature',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 110,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        10), // Adjust the radius as needed
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.grass),
                      const SizedBox(
                          height:
                              8), // Add some space between the Icon and Text widgets
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: const TextSpan(
                          text: 'Lembap Tanah',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: TextSpan(
                          text: '$moist',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 110,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        10), // Adjust the radius as needed
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.air),
                      const SizedBox(
                          height:
                              8), // Add some space between the Icon and Text widgets
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: const TextSpan(
                          text: 'Lembap Udara',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: TextSpan(
                          text: '$humid',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 110,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        10), // Adjust the radius as needed
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.light_mode_outlined),
                      const SizedBox(
                          height:
                              8), // Add some space between the Icon and Text widgets
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: const TextSpan(
                          text: 'Intens Cahaya',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: TextSpan(
                          text: '$light',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 110,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        10), // Adjust the radius as needed
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.filter_list),
                      const SizedBox(
                          height:
                              8), // Add some space between the Icon and Text widgets
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: const TextSpan(
                          text: 'Luas Tanah',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: const TextSpan(
                          text: '-',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 110,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        10), // Adjust the radius as needed
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.data_exploration_outlined),
                      const SizedBox(
                          height:
                              8), // Add some space between the Icon and Text widgets
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: const TextSpan(
                          text: 'Harga Terkini',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: const TextSpan(
                          text: 'Rp, 20.000',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 110,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        10), // Adjust the radius as needed
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.health_and_safety_outlined),
                      const SizedBox(
                          height:
                              8), // Add some space between the Icon and Text widgets
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: const TextSpan(
                          text: 'Pupuk',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: const TextSpan(
                          text: '-',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 110,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        10), // Adjust the radius as needed
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.access_alarm),
                      const SizedBox(
                          height:
                              8), // Add some space between the Icon and Text widgets
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: const TextSpan(
                          text: 'Kondisi',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: const TextSpan(
                          text: 'Aman',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 110,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        10), // Adjust the radius as needed
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.grid_view_rounded),
                      const SizedBox(
                          height:
                              8), // Add some space between the Icon and Text widgets
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: const TextSpan(
                          text: 'Setting\nSawah',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarRaisedInsetFb1(
        currentPage: currentPage,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
            if (kDebugMode) {
              print("currentPage: $currentPage");
            }
          });
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
