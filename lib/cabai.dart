import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tebak Angka',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TebakAngkaGame(),
    );
  }
}

class TebakAngkaGame extends StatefulWidget {
  @override
  _TebakAngkaGameState createState() => _TebakAngkaGameState();
}

class _TebakAngkaGameState extends State<TebakAngkaGame> {
  int angkaTebakan;
  int tebakanPemain;
  String hasilTebakan = '';

  @override
  void initState() {
    super.initState();
    generateAngkaTebakan();
  }

  void generateAngkaTebakan() {
    final random = Random();
    angkaTebakan = random.nextInt(10) + 1;
  }

  void cekTebakan() {
    if (tebakanPemain == angkaTebakan) {
      setState(() {
        hasilTebakan = 'Tebakan Benar! Angka yang benar adalah $angkaTebakan';
      });
    } else {
      setState(() {
        hasilTebakan = 'Tebakan Salah! Coba lagi.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tebak Angka Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Tebak Angka Antara 1 dan 10',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  tebakanPemain = int.tryParse(value) ?? 0;
                });
              },
              decoration: InputDecoration(
                hintText: 'Masukkan tebakan Anda',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                cekTebakan();
              },
              child: Text('Cek Tebakan'),
            ),
            SizedBox(height: 20),
            Text(
              hasilTebakan,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
