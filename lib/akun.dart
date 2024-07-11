import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smartaca_alpha_6/Setting.dart';
import 'package:smartaca_alpha_6/main.dart';

class akun extends StatefulWidget {
  const akun({super.key});

  @override
  State<akun> createState() => _akunState();
}

class _akunState extends State<akun> {
  int currentPage = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Warna latar belakang AppBar
        elevation: 0, // Menghilangkan bayangan pada AppBar
        title: const Padding(
          padding: EdgeInsets.only(bottom: 0),
          child: Text(
            'Akun',
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
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Padding(padding: EdgeInsets.fromLTRB(20, 10, 0, 0)),
              CircleAvatar(
                radius: 40.0,
                backgroundImage: NetworkImage(
                  'https://picsum.photos/id/237/300/300',
                ),
              ),
              SizedBox(
                width: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pak Ryo Hariyono',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    '+628794766790',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                ],
              ),
              SizedBox(
                width: 45,
              ),
              Icon(
                Icons.edit,
                color: Colors.black54,
                size: 25,
              )
            ],
          ),
          SizedBox(
            height: 28,
          ),
          Row(
            children: [
              Padding(padding: EdgeInsets.fromLTRB(20, 10, 0, 0)),
              Text(
                'Setelan',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87),
              ),
            ],
          ),
          SizedBox(
            height: 23,
          ),
          Row(
            children: [
              SizedBox(
                width: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.language,
                        size: 30,
                        color: Colors.black38,
                      ),
                      SizedBox(
                        width: 70,
                      ),
                      Text(
                        'Pilih Bahasa',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 130,
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 30,
                        color: Colors.black38,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.lock_outline_rounded,
                        size: 30,
                        color: Colors.black38,
                      ),
                      SizedBox(
                        width: 70,
                      ),
                      Text(
                        'Ganti Password',
                        style: TextStyle(color: Colors.black54, fontSize: 18),
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 30,
                        color: Colors.black38,
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 61,
          ),
          Center(
            child: Text(
              'Keluar',
              style: TextStyle(
                  color: Colors.red, fontSize: 30, fontWeight: FontWeight.w600),
            ),
          )
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
    );
  }
}
