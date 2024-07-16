import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class IoTController {
  FirebaseDatabase database = FirebaseDatabase.instance;

  Future<void> controlDevices() async {
    try {
      debugPrint("Starting controlDevices function");
      var aselole = "dutakdungdung";
      debugPrint(aselole);

      final temperatureRef = database.ref('Smartaca/Suhu');
      final humidRef = database.ref('Smartaca/SoilPercent');
      final moistRef = database.ref('Device1/Moist');
      final lightRef = database.ref('Smartaca/StatusCahaya');

      // Fetch data
      double temperature = double.parse((await temperatureRef.get()).value.toString());
      double humid = double.parse((await humidRef.get()).value.toString());
      double moist = double.parse((await moistRef.get()).value.toString());
      double light = double.parse((await lightRef.get()).value.toString());

      debugPrint("Fetched data: temperature=$temperature, humid=$humid, moist=$moist, light=$light");

      // Call OpenAI API for decision making
      String decision = await makeDecision(temperature, humid, moist, light);

      // Print decision for debugging
      debugPrint("Decision: $decision");

      // Perform actions based on decision
      if (decision == "on_peltier") {
        await database.reference().child('peltier').set(true);
      } else if (decision == "off_peltier") {
        await database.reference().child('peltier').set(false);
      } else if (decision == "on_pompa") {
        await database.reference().child('pompa').set(true);
        await Future.delayed(Duration(seconds: 30));
        await database.reference().child('pompa').set(false);
      } else if (decision == "on_vitamin") {
        await database.reference().child('vitamin').set(true);
        await Future.delayed(Duration(seconds: 30));
        await database.reference().child('vitamin').set(false);
      } else if (decision == "on_lampu") {
        await database.reference().child('lampu').set(true);
      } else if (decision == "off_lampu") {
        await database.reference().child('lampu').set(false);
      }

      debugPrint("Completed actions based on decision");
    } catch (e) {
      debugPrint("Error in controlDevices: $e");
    }
  }

  Future<String> makeDecision(double temperature, double humid, double moist, double light) async {
    try {
      debugPrint("Starting makeDecision function");

      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer sk-None-lQkSWy34NC1MUufbv0SpT3BlbkFJC0UVd8GJIp82Y85bXoH0',
        },
        body: jsonEncode({
          'model': 'text-davinci-003',
          'prompt': 'Based on the following parameters: temperature=$temperature, humidity=$humid, soil moisture=$moist, and light intensity=$light, decide the actions to control peltier, water pump, vitamin pump, and lamp. The decision should be in the format: on_peltier, off_peltier, on_pompa, off_pompa, on_vitamin, off_vitamin, on_lampu, off_lampu.',
          'max_tokens': 50,
          'n': 1,
          'stop': null,
          'temperature': 0.5,
        }),
      );

      debugPrint("Received response from OpenAI");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        debugPrint("Response data: ${data['choices'][0]['text'].trim()}");
        return data['choices'][0]['text'].trim();
      } else {
        throw Exception('Failed to get decision from OpenAI');
      }
    } catch (e) {
      debugPrint("Error in makeDecision: $e");
      return 'error';
    }
  }
}









// import 'package:firebase_database/firebase_database.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class IoTController {
//   FirebaseDatabase database = FirebaseDatabase.instance;

//   Future<void> controlDevices() async {
//     final temperatureRef = database.reference().child('Smartaca/Suhu');
//     final humidRef = database.reference().child('Smartaca/SoilPercent');
//     final moistRef = database.reference().child('Device1/Moist');
//     final lightRef = database.reference().child('Smartaca/StatusCahaya');

//     double temperature = double.parse((await temperatureRef.get()).value.toString());
//     double humid = double.parse((await humidRef.get()).value.toString());
//     double moist = double.parse((await moistRef.get()).value.toString());
//     double light = double.parse((await lightRef.get()).value.toString());

//     // Call OpenAI API for decision making
//     String decision = await makeDecision(temperature, humid, moist, light);

//     // Perform actions based on decision
//     if (decision == "on_peltier") {
//       database.reference().child('peltier').set(true);
//     } else if (decision == "off_peltier") {
//       database.reference().child('peltier').set(false);
//     } else if (decision == "on_pompa") {
//       database.reference().child('pompa').set(true);
//       await Future.delayed(Duration(seconds: 30));
//       database.reference().child('pompa').set(false);
//     } else if (decision == "on_vitamin") {
//       database.reference().child('vitamin').set(true);
//       await Future.delayed(Duration(seconds: 30));
//       database.reference().child('vitamin').set(false);
//     } else if (decision == "on_lampu") {
//       database.reference().child('lampu').set(true);
//     } else if (decision == "off_lampu") {
//       database.reference().child('lampu').set(false);
//     }
//   }

//   Future<String> makeDecision(double temperature, double humid, double moist, double light) async {
//     final response = await http.post(
//       Uri.parse('https://api.openai.com/v1/completions'),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer sk-proj-Wj0iJbXAq4aWGdkucVYFT3BlbkFJfXkpA6BV5UqP72JNcUvb',
//       },
//       body: jsonEncode({
//         'model': 'text-davinci-003',
//         'prompt': 'Based on the following parameters: temperature=$temperature, humidity=$humid, soil moisture=$moist, and light intensity=$light, decide the actions to control peltier, water pump, vitamin pump, and lamp. The decision should be in the format: on_peltier, off_peltier, on_pompa, off_pompa, on_vitamin, off_vitamin, on_lampu, off_lampu.',
//         'max_tokens': 50,
//         'n': 1,
//         'stop': null,
//         'temperature': 0.5,
//       }),
//     );

//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//       print("[ADM] Response data: ${data['choices'][0]['text'].trim()}");
//       return data['choices'][0]['text'].trim();
      
//     } else {
//       print("[ADM] Error: ${response.statusCode}");
//       throw Exception('Failed to get decision from OpenAI');
//     }
//   }
// }

