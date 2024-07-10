import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smartaca_alpha_6/Setting.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:smartaca_alpha_6/main.dart';
import 'temperature.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseDatabase database = FirebaseDatabase.instance;

  int currentPage = 0;

  bool peltierPower = false;

  String temperature = 'Loading...';
  String humid = 'Loading...';
  String moist = 'Loading...';
  String light = 'Loading...';
  String lightOut = 'Loading...';

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
          if (light == '1') {
            lightOut = "Terang";
          } else {
            lightOut = "Gelap";
          }
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

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final blockWidth = screenSize.width / 100;
    final blockHeight = screenSize.height / 110;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Page',
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            setState(() {
              currentPage = 3;
            });
          },
          icon: const Icon(
            Icons.notifications_none_outlined,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
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
                        value: 'Aman',
                        valueColor: Colors.green,
                      ),
                      _buildInfoCard(
                        width: blockWidth * 60,
                        height: blockHeight * 20,
                        title: 'Penyebab',
                        value: '-',
                        additionalTitle: 'Solusi',
                        additionalValue: '-',
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
                      ),
                      _buildInfoCard(
                        width: blockWidth * 30,
                        height: blockHeight * 20,
                        icon: Icons.grass,
                        iconColor: Colors.brown,
                        title: 'Lembap Tanah',
                        value: moist,
                      ),
                      _buildInfoCard(
                        width: blockWidth * 30,
                        height: blockHeight * 20,
                        icon: Icons.air,
                        iconColor: Colors.lightBlue,
                        title: 'Lembap Udara',
                        value: humid,
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
                      ),
                      _buildInfoCard(
                        width: blockWidth * 30,
                        height: blockHeight * 20,
                        icon: Icons.filter_list,
                        iconColor: Colors.green,
                        title: 'Luas Tanah',
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
                        GestureDetector(
                        onTap: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Settings(),
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
    Color? valueColor,
    String? additionalTitle,
    String? additionalValue,
    Color backgroundColor = Colors.white,
    Color textColor = Colors.black,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
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
              style: TextStyle(color: textColor),
            ),
          ),
          const SizedBox(height: 5),
          RichText(
            text: TextSpan(
              text: value,
              style: TextStyle(color: valueColor ?? Colors.black54),
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
