import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 20.0,
              left: 20.0,
              child: IconButton(
                iconSize: 42,
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            const Positioned(
              top: 105,
              left: 30,
              child: Text(
                'Sistem',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: 210,
              left: 30,
              child: Text(
                'Sistem Otomatis',
                style: TextStyle(
                  fontSize: 20,
                  color: isSwitch ? Colors.green : Colors.black26,
                  // Ganti warna teks berdasarkan status switch
                ),
              ),
            ),
            Positioned(
              top: 197,
              right: 40,
              child: Switch(
                value: isSwitch,
                onChanged: (value) {
                  setState(
                    () {
                      isSwitch = value;
                    },
                  );
                },
                materialTapTargetSize:
                    MaterialTapTargetSize.shrinkWrap, // Atur ukuran switch
              ),
            ),
            const Positioned(
              top: 260,
              left: 30,
              child: Text(
                'Seluruh sistem akan berjalan secara \notomatis sesuai dengan kebutuhan \ntanaman cabai',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
