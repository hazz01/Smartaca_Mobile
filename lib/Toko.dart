import 'package:flutter/material.dart';

class Toko extends StatefulWidget {
  const Toko({Key? key}) : super(key: key);

  @override
  State<Toko> createState() => _TokoState();
}

class _TokoState extends State<Toko> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Warna latar belakang AppBar
        title: const Padding(
          padding: EdgeInsets.only(bottom: 0),
          child: Text(
            'Toko',
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.w600),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Cari di sini',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.green))),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 200,
                            height: 300,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  10), // Adjust the radius as needed
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 1),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height:
                                        20), // Add some space between the Icon and Text widgets
                                SizedBox(height: 5),
                                Image.asset(
                                  'images/image 20.png', // Path to your local image asset
                                  width: 170, // Adjust width as needed
                                  height: 170, // Adjust height as needed
                                ),
                                SizedBox(height: 5),

                                Column(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsetsDirectional.only(start: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: RichText(
                                              text: const TextSpan(
                                                text: 'Sarung Tangan',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 17),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsetsDirectional.only(start: 6),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Icon(
                                              Icons.location_on_outlined,
                                              color: Colors.green,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                top: 2, left: 0), // Atur jar
                                            child: Text(
                                              'Malang',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsetsDirectional.only(start: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                top: 0, right: 50), // Atur jar
                                            child: const Text(
                                              'Rp 12.500',
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Icon(
                                              Icons.add_circle_outlined,
                                              color: Colors.green,
                                              size: 35,
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
                          SizedBox(
                            width: 30,
                          ),
                          Container(
                            width: 200,
                            height: 300,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  10), // Adjust the radius as needed
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 1),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height:
                                        20), // Add some space between the Icon and Text widgets
                                SizedBox(height: 5),
                                Image.asset(
                                  'images/image 20.png', // Path to your local image asset
                                  width: 170, // Adjust width as needed
                                  height: 170, // Adjust height as needed
                                ),
                                SizedBox(height: 5),

                                Column(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsetsDirectional.only(start: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: RichText(
                                              text: const TextSpan(
                                                text: 'Sarung Tangan',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 17),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsetsDirectional.only(start: 6),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Icon(
                                              Icons.location_on_outlined,
                                              color: Colors.green,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                top: 2, left: 0), // Atur jar
                                            child: Text(
                                              'Malang',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsetsDirectional.only(start: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                top: 0, right: 50), // Atur jar
                                            child: const Text(
                                              'Rp 12.500',
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Icon(
                                              Icons.add_circle_outlined,
                                              color: Colors.green,
                                              size: 35,
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
                        ], //disini
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 200,
                                height: 300,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      10), // Adjust the radius as needed
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0, 1),
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height:
                                            20), // Add some space between the Icon and Text widgets
                                    SizedBox(height: 5),
                                    Image.asset(
                                      'images/image 20.png', // Path to your local image asset
                                      width: 170, // Adjust width as needed
                                      height: 170, // Adjust height as needed
                                    ),
                                    SizedBox(height: 5),

                                    Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsetsDirectional.only(
                                              start: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: RichText(
                                                  text: const TextSpan(
                                                    text: 'Sarung Tangan',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 17),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsetsDirectional.only(
                                              start: 6),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Icon(
                                                  Icons.location_on_outlined,
                                                  color: Colors.green,
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    top: 2,
                                                    left: 0), // Atur jar
                                                child: Text(
                                                  'Malang',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsetsDirectional.only(
                                              start: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    top: 0,
                                                    right: 50), // Atur jar
                                                child: const Text(
                                                  'Rp 12.500',
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Icon(
                                                  Icons.add_circle_outlined,
                                                  color: Colors.green,
                                                  size: 35,
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
                              SizedBox(
                                width: 30,
                              ),
                              Container(
                                width: 200,
                                height: 300,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      10), // Adjust the radius as needed
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0, 1),
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height:
                                            20), // Add some space between the Icon and Text widgets
                                    SizedBox(height: 5),
                                    Image.asset(
                                      'images/image 20.png', // Path to your local image asset
                                      width: 170, // Adjust width as needed
                                      height: 170, // Adjust height as needed
                                    ),
                                    SizedBox(height: 5),

                                    Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsetsDirectional.only(
                                              start: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: RichText(
                                                  text: const TextSpan(
                                                    text: 'Sarung Tangan',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 17),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsetsDirectional.only(
                                              start: 6),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Icon(
                                                  Icons.location_on_outlined,
                                                  color: Colors.green,
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    top: 2,
                                                    left: 0), // Atur jar
                                                child: Text(
                                                  'Malang',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsetsDirectional.only(
                                              start: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    top: 0,
                                                    right: 50), // Atur jar
                                                child: const Text(
                                                  'Rp 12.500',
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Icon(
                                                  Icons.add_circle_outlined,
                                                  color: Colors.green,
                                                  size: 35,
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
                            ], //disini
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 200,
                                height: 300,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      10), // Adjust the radius as needed
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0, 1),
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height:
                                            20), // Add some space between the Icon and Text widgets
                                    SizedBox(height: 5),
                                    Image.asset(
                                      'images/image 20.png', // Path to your local image asset
                                      width: 170, // Adjust width as needed
                                      height: 170, // Adjust height as needed
                                    ),
                                    SizedBox(height: 5),

                                    Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsetsDirectional.only(
                                              start: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: RichText(
                                                  text: const TextSpan(
                                                    text: 'Sarung Tangan',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 17),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsetsDirectional.only(
                                              start: 6),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Icon(
                                                  Icons.location_on_outlined,
                                                  color: Colors.green,
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    top: 2,
                                                    left: 0), // Atur jar
                                                child: Text(
                                                  'Malang',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsetsDirectional.only(
                                              start: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    top: 0,
                                                    right: 50), // Atur jar
                                                child: const Text(
                                                  'Rp 12.500',
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Icon(
                                                  Icons.add_circle_outlined,
                                                  color: Colors.green,
                                                  size: 35,
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
                              SizedBox(
                                width: 30,
                              ),
                              Container(
                                width: 200,
                                height: 300,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      10), // Adjust the radius as needed
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0, 1),
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height:
                                            20), // Add some space between the Icon and Text widgets
                                    SizedBox(height: 5),
                                    Image.asset(
                                      'images/image 20.png', // Path to your local image asset
                                      width: 170, // Adjust width as needed
                                      height: 170, // Adjust height as needed
                                    ),
                                    SizedBox(height: 5),

                                    Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsetsDirectional.only(
                                              start: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: RichText(
                                                  text: const TextSpan(
                                                    text: 'Sarung Tangan',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 17),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsetsDirectional.only(
                                              start: 6),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Icon(
                                                  Icons.location_on_outlined,
                                                  color: Colors.green,
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    top: 2,
                                                    left: 0), // Atur jar
                                                child: Text(
                                                  'Malang',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsetsDirectional.only(
                                              start: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    top: 0,
                                                    right: 50), // Atur jar
                                                child: const Text(
                                                  'Rp 12.500',
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Icon(
                                                  Icons.add_circle_outlined,
                                                  color: Colors.green,
                                                  size: 35,
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
                            ], //disini
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
