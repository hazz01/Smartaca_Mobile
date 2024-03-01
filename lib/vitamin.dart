// import 'dart:js_util';+

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:smartaca_alpha_6/Cahaya.dart';
import 'package:smartaca_alpha_6/home_page.dart';
import 'package:smartaca_alpha_6/temperature.dart';
import 'package:smartaca_alpha_6/vitamin.dart';
import 'package:smartaca_alpha_6/waterdischarge.dart';
import 'main.dart';

class Vitamin extends StatefulWidget {
  const Vitamin({Key? key}) : super(key: key);

  @override
  State<Vitamin> createState() => _VitaminState();
}

class _VitaminState extends State<Vitamin> {
  FirebaseDatabase database = FirebaseDatabase.instance;

  bool peltierPower = false;
  int currentPage = 0;

  String temperature = 'Loading...';

  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    final temperatureRef = database.reference().child('Device1/Vitamin');
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

    final peltierPowerRef = database.reference().child('vitamin');
    peltierPowerRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        int peltierPowerInt = event.snapshot.value as int;
        setState(() {
          // peltierPower = event.snapshot.value as bool
          peltierPower = (peltierPowerInt == 1);
          debugPrint(": $peltierPower");
        });
      } else {
        if (kDebugMode) {
          print('No Data Available.');
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    // Hentikan event listener
    // database.reference().child('Device1/Temp').onValue.drain();
    // database.reference().child('Device1/Peltier').onValue.drain();
  }

  // void initState() {
  //   super.initState();
  //   _temperatureRef.onValue.listen((event) {
  //     final data = event.snapshot.value as String?;
  //     if (data != null) {
  //       setState(() {
  //         temperature = data;
  //       });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Warna latar belakang AppBar
        title: const Padding(
          padding: EdgeInsets.only(bottom: 0),
          child: Text(
            'Alat IoT',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.notifications_none_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              // Tambahkan logika aksi untuk ikon akun di sini
            },
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              child: const Text(
                'Pemupukan',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              child: Image.asset(
                peltierPower ? 'images/pupukOn (2).png' : 'images/pupukOff.png',
              ),
            ),
          ),
          const SizedBox(height: 15.0), // Jarak antara gambar dan teks

          // Text(
          //   temperature,
          //   style: const TextStyle(
          //       fontSize: 45,
          //       fontWeight: FontWeight.w600,
          //       color: Colors.black54),
          // ),
          SizedBox(
            height: 53,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            margin: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Center(
                      child: Text.rich(
                        TextSpan(
                          text: 'Power',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 95,
                      height: 80,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Switch(
                          value: peltierPower,
                          onChanged: (value) {
                            final peltierPowerRef =
                                database.reference().child('vitamin');
                            peltierPowerRef.set(value ? 1 : 0);
                            // Update data Firebase saat switch diubah
                            // final peltierPowerRef = database.reference().child('Device1/veltier');
                            // peltierPowerRef.set(value); // Set nilai di Firebase sesuai nilai switch
                          },
                          activeColor: Colors.orange,
                          inactiveThumbColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Divider(
                  color: Colors.grey, // Warna garis
                  thickness: 0.5, // Ketebalan garis
                ),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Atur posisi widget ke tengah
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: Icon(
                        Icons.g_mobiledata_rounded,
                        color: peltierPower ? Colors.orange : Colors.grey,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          top: 20, left: 0), // Atur jarak antara icon dan teks
                      child: Text(
                        peltierPower ? 'Pompa Nyala' : 'Pompa Mati',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: peltierPower ? Colors.orange : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // IconButton(
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => HomePage()),
              //       );
              //     },
              //     icon: Icon(Icons.circle)),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration.zero,
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const Temperature(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.circle,
                  color: Colors.black38,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration.zero,
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const WaterDischarge(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.circle,
                  color: Colors.black38,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration.zero,
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const Vitamin(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.circle,
                  color: Colors.green,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration.zero,
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const Cahaya(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.circle,
                  color: Colors.black38,
                ),
              ),
            ],
          ),
          // Center(
          //   child: Container(
          //     child: const Center(
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Icon(Icons.water_drop_rounded, color: Colors.green),
          //           Icon(Icons.water_drop_rounded, color: Colors.black26),
          //         ],
          //       ),
          //     ),
          //   ),
          // )
        ],
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
      // bottomNavigationBar: NavigationBar(
      //   destinations: const [
      //     NavigationDestination(
      //         icon: Icon(Icons.thermostat), label: 'Temperature'),
      //     NavigationDestination(
      //         icon: Icon(Icons.water_drop_rounded), label: 'Water Discharge'),
      //     NavigationDestination(
      //         icon: Icon(Icons.account_circle_rounded), label: 'Account'),
      //   ],
      //   onDestinationSelected: (int index) {
      //     setState(() {
      //       currentPage = index;
      //     });
      //   },
      //   selectedIndex: currentPage,
      // ),
    );
  }
}
