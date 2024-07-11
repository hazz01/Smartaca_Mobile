import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smartaca_alpha_6/Setting.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:smartaca_alpha_6/SettingSawah.dart';
import 'package:smartaca_alpha_6/main.dart';
import 'package:smartaca_alpha_6/setting_sawah.dart';
import 'temperature.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseDatabase database = FirebaseDatabase.instance;

  int currentPage = 3;

  bool peltierPower = false;

  String temperature = 'Loading...';
  String humid = 'Loading...';
  String moist = 'Loading...';
  String light = 'Loading...';
  String lightOut = 'Loading...';

  bool highlighTemperature = false;
  bool highlighHumid = false;
  bool highlighMoist = false;
  bool highlighLight = false;

  String kondisi = 'Aman';
  String penyebab = '-';
  String solusi = '-';

  @override
  void initState() {
    super.initState();
    final temperatureRef = database.reference().child('Smartaca/Suhu');
    final humidRef = database.reference().child('Smartaca/SoilPercent');
    final moistRef = database.reference().child('Device1/Moist');
    final lightRef = database.reference().child('Smartaca/StatusCahaya');

    temperatureRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          temperature = event.snapshot.value.toString();
          debugPrint("[Home] Temp: $temperature");
          highlighTemperature = true;
          Timer(const Duration(seconds: 2), () {
            setState(() {
              highlighTemperature = false;
            });
          });
          _updateKondisi();
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
          highlighHumid = true;
          Timer(const Duration(seconds: 2), () {
            setState(() {
              highlighHumid = false;
            });
          });
          _updateKondisi();
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
          highlighMoist = true;
          Timer(const Duration(seconds: 2), () {
            setState(() {
              highlighMoist = false;
            });
          });
          _updateKondisi();
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
          if (light == '1') {
            lightOut = "Terang";
          } else {
            lightOut = "Gelap";
          }
          highlighLight = true;
          Timer(const Duration(seconds: 2), () {
            setState(() {
              highlighLight = false;
            });
          });
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

  void _updateKondisi() {
    double tempValue = double.tryParse(temperature) ?? 0;
    double moistValue = double.tryParse(moist) ?? 0;
    double humidValue = double.tryParse(humid) ?? 0;

    bool tempCondition = tempValue < 25;
    bool moistCondition = moistValue < 60;
    bool humidCondition = humidValue < 8;

    if (tempCondition && moistCondition && humidCondition) {
      setState(() {
        kondisi = 'Aman';
        penyebab = '-';
        solusi = '-';
      });
    } else if ((!tempCondition && moistCondition && humidCondition) ||
        (tempCondition && !moistCondition && humidCondition) ||
        (tempCondition && moistCondition && !humidCondition)) {
      setState(() {
        kondisi = 'Peringatan';
        penyebab = !tempCondition
            ? 'Suhu tinggi'
            : !moistCondition
                ? 'Kelembaban tanah rendah'
                : 'Kelembaban udara rendah';
        solusi = !tempCondition
            ? 'Turunkan suhu'
            : !moistCondition
                ? 'Tingkatkan kelembaban tanah'
                : 'Tingkatkan kelembaban udara';
      });
    } else {
      setState(() {
        kondisi = 'Bahaya';
        penyebab = 'Banyak faktor yang tidak sesuai';
        solusi = 'Periksa semua parameter';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final blockWidth = screenSize.width / 100;
    final blockHeight = screenSize.height / 110;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Warna latar belakang AppBar
        elevation: 0, // Menghilangkan bayangan pada AppBar
        title: const Padding(
          padding: EdgeInsets.only(bottom: 0),
          child: Text(
            'Home Page',
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Settings(),
                  ));
            },
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.black45, // Warna garis pada dasar AppBar
            height: 1.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: blockHeight * 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildInfoCard(
                        width: blockWidth * 30,
                        height: blockHeight * 20,
                        icon: Icons.circle,
                        iconColor: Colors.green,
                        title: 'Kondisi',
                        value: kondisi,
                        valueColor: kondisi == 'Aman'
                            ? Colors.green
                            : kondisi == 'Peringatan'
                                ? Colors.orange
                                : Colors.red,
                      ),
                      _buildInfoCard(
                        width: blockWidth * 60,
                        height: blockHeight * 20,
                        title: 'Penyebab',
                        value: penyebab,
                        additionalTitle: 'Solusi',
                        additionalValue: solusi,
                      ),
                    ],
                  ),
                  SizedBox(height: blockHeight * 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildInfoCard(
                        width: blockWidth * 30,
                        height: blockHeight * 20,
                        icon: Icons.sunny_snowing,
                        iconColor: Colors.red,
                        title: 'Temperature',
                        value: temperature,
                        highlight: highlighTemperature,
                      ),
                      _buildInfoCard(
                        width: blockWidth * 30,
                        height: blockHeight * 20,
                        icon: Icons.grass,
                        iconColor: Colors.brown,
                        title: 'Lembap Tanah',
                        value: moist,
                        highlight: highlighMoist,
                      ),
                      _buildInfoCard(
                        width: blockWidth * 30,
                        height: blockHeight * 20,
                        icon: Icons.air,
                        iconColor: Colors.lightBlue,
                        title: 'Lembap Udara',
                        value: humid,
                        highlight: highlighHumid,
                      ),
                    ],
                  ),
                  SizedBox(height: blockHeight * 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildInfoCard(
                        width: blockWidth * 30,
                        height: blockHeight * 20,
                        icon: Icons.light_mode_outlined,
                        iconColor: Colors.yellow,
                        title: 'Intens Cahaya',
                        value: lightOut,
                        highlight: highlighLight,
                      ),
                      _buildInfoCard(
                        width: blockWidth * 30,
                        height: blockHeight * 20,
                        icon: Icons.dataset,
                        iconColor: Colors.green,
                        title: 'Jumlah Panen',
                        value: '-',
                      ),
                      _buildInfoCard(
                        width: blockWidth * 30,
                        height: blockHeight * 20,
                        icon: Icons.data_exploration_outlined,
                        iconColor: Colors.amber,
                        title: 'Harga Terkini',
                        value: 'Rp, 75.000',
                      ),
                    ],
                  ),
                  SizedBox(height: blockHeight * 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildInfoCard(
                        width: blockWidth * 30,
                        height: blockHeight * 20,
                        icon: Icons.health_and_safety_outlined,
                        iconColor: Colors.teal,
                        title: 'Pupuk',
                        value: '-',
                      ),
                      _buildInfoCard(
                        width: blockWidth * 30,
                        height: blockHeight * 20,
                        icon: Icons.access_alarm,
                        iconColor: Colors.blueGrey,
                        title: 'Umur',
                        value: '9 Hari',
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingSawah(),
                            ),
                          );
                        },
                        child: _buildInfoCard(
                          width: blockWidth * 30,
                          height: blockHeight * 20,
                          icon: Icons.grid_view_rounded,
                          iconColor: Colors.white,
                          title: 'Setting\nSawah',
                          value: '',
                          backgroundColor: Colors.grey[400]!,
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
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

  Widget _buildInfoCard({
    required double width,
    required double height,
    IconData? icon,
    Color? iconColor,
    required String title,
    required String value,
    bool highlight = false,
    Color? valueColor,
    String? additionalTitle,
    String? additionalValue,
    Color backgroundColor = Colors.white,
    Color textColor = Colors.black,
  }) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: highlight ? Colors.blue.withOpacity(0.3) : backgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, color: iconColor),
            const SizedBox(height: 8),
          ],
          RichText(
            text: TextSpan(
              text: title,
              style: TextStyle(fontWeight: FontWeight.normal, color: textColor),
            ),
          ),
          const SizedBox(height: 5),
          RichText(
            text: TextSpan(
              text: value,
              style: TextStyle(
                  fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
                  color: valueColor ?? Colors.black54),
            ),
          ),
          if (additionalTitle != null && additionalValue != null) ...[
            const SizedBox(height: 5),
            RichText(
              text: TextSpan(
                text: additionalTitle,
                style: TextStyle(color: textColor),
              ),
            ),
            const SizedBox(height: 5),
            RichText(
              text: TextSpan(
                text: additionalValue,
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
