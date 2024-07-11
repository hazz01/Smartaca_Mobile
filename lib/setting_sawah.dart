import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SettingSawah extends StatefulWidget {
  const SettingSawah({Key? key}) : super(key: key);

  @override
  State<SettingSawah> createState() => _SettingSawahState();
}

class _SettingSawahState extends State<SettingSawah> {
  var _luasController = TextEditingController();
  var _pupukController = TextEditingController();
  var _penanamanController = TextEditingController();
  DateTime? _selectedDate;

  FirebaseDatabase database = FirebaseDatabase.instance;

  late DatabaseReference luasRef;
  late DatabaseReference pupukRef;
  late DatabaseReference penanamanRef;

  @override
  void initState() {
    super.initState();
    luasRef = database.reference().child('Account/Luas');
    pupukRef = database.reference().child('Account/Pupuk');
    penanamanRef = database.reference().child('Account/Penanaman');
    _fetchData();
  }

  void _fetchData() async {
    DataSnapshot luasSnapshot = await luasRef.get();
    DataSnapshot pupukSnapshot = await pupukRef.get();
    DataSnapshot penanamanSnapshot = await penanamanRef.get();

    setState(() {
      _luasController.text = luasSnapshot.value.toString();
      _pupukController.text = pupukSnapshot.value.toString();
      String penanaman = penanamanSnapshot.value.toString();
      try {
        // Periksa apakah tanggal sebelum firstDate (2000-01-01)
        DateTime parsedDate = DateFormat("dd-MM-yyyy").parse(penanaman);
        if (parsedDate.isBefore(DateTime(2000, 1, 1))) {
          // Jika ya, set tanggal ke DateTime.now()
          _selectedDate = DateTime.now();
        } else {
          _selectedDate = parsedDate;
        }
        _penanamanController.text = "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}";
      } catch (e) {
        print('Error parsing date: $e');
      }
    });
  }

  void _updateData() {
    luasRef.set(int.parse(_luasController.text));
    pupukRef.set(int.parse(_pupukController.text));
    penanamanRef.set(DateFormat("dd-MM-yyyy").format(_selectedDate!));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data berhasil diperbarui')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pengaturan Sawah')),
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          children: [
            CustomInputFieldFb1(
              inputController: _luasController,
              hintText: 'Masukkan Luas Sawah',
              labelText: 'Luas Sawah',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20,),
            CustomInputFieldFb1(
              inputController: _pupukController,
              hintText: 'Masukkan Jumlah Pemberian Pupuk',
              labelText: 'Pemberian Pupuk (per minggu)',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20,),
            CustomDateInputField(
              selectedDate: _selectedDate,
              labelText: 'Tanggal Penanaman',
              onDateSelected: (DateTime date) {
                setState(() {
                  _selectedDate = date;
                  _penanamanController.text = "${date.day}/${date.month}/${date.year}";
                });
              },
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: _updateData,
              child: Text('Perbarui Data'),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomInputFieldFb1 extends StatelessWidget {
  final TextEditingController inputController;
  final String hintText;
  final Color primaryColor;
  final String labelText;
  final TextInputType keyboardType;

  const CustomInputFieldFb1({
    Key? key,
    required this.inputController,
    required this.hintText,
    required this.labelText,
    this.primaryColor = const Color(0xFF4CAF50),
    required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          offset: const Offset(12, 26),
          blurRadius: 50,
          spreadRadius: 0,
          color: Colors.grey.withOpacity(.1),
        ),
      ]),
      child: TextField(
        controller: inputController,
        onChanged: (value) {
          // Do something with the value
        },
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 16, color: Colors.black),
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
          fillColor: Colors.transparent,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor.withOpacity(.1), width: 2.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 2.0),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor.withOpacity(.1), width: 2.0),
          ),
        ),
      ),
    );
  }
}

class CustomDateInputField extends StatelessWidget {
  final DateTime? selectedDate;
  final String labelText;
  final Function(DateTime) onDateSelected;

  const CustomDateInputField({
    Key? key,
    required this.selectedDate,
    required this.labelText,
    required this.onDateSelected,
  }) : super(key: key);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          offset: const Offset(12, 26),
          blurRadius: 50,
          spreadRadius: 0,
          color: Colors.grey.withOpacity(.1),
        ),
      ]),
      child: InkWell(
        onTap: () => _selectDate(context),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            filled: true,
            fillColor: Colors.transparent,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 2.0),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 2.0),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 2.0),
            ),
          ),
          child: selectedDate != null
              ? Text(
                  "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                )
              : const Text(
                  'Pilih Tanggal',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
        ),
      ),
    );
  }
}
