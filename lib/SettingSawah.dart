import 'package:flutter/material.dart';
import 'package:smartaca_alpha_6/main.dart';

class SettingInfoSawah extends StatefulWidget {
  const SettingInfoSawah({super.key});

  @override
  State<SettingInfoSawah> createState() => _SettingInfoSawahState();
}

class _SettingInfoSawahState extends State<SettingInfoSawah> {
  final _luasController = TextEditingController();
  final _jumlahController = TextEditingController();
  final _umurController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _luasController.dispose();
    _jumlahController.dispose();
    _umurController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var currentPage = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting Info Sawah'),
      ),
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
              inputController: _jumlahController,
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
                  _umurController.text = "${date.day}/${date.month}/${date.year}";
                });
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarRaisedInsetFb1(
        currentPage: currentPage,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
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
                  'Select Date',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
        ),
      ),
    );
  }
}
