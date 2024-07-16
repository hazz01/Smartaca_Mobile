// Step 1: Define a Model for Notification History

import 'package:flutter/material.dart';
import 'package:smartaca_alpha_6/home_page.dart';

class NotificationHistory {
  final String title;
  final String body;
  final DateTime timestamp;

  NotificationHistory(
      {required this.title, required this.body, required this.timestamp});
}

// Assuming you have a global list to store notifications (in a real app, consider using a database or shared preferences)
List<NotificationHistory> notificationsHistory = [];

// Modify your existing notification function to save the notification to the list
void showNotification(String title, String body) {
  // Your existing code to show notification
  // After showing the notification, save it to the history
  notificationsHistory.add(
      NotificationHistory(title: title, body: body, timestamp: DateTime.now()));
}

// Step 3: Create HistoryPage

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Warna latar belakang AppBar
        elevation: 0, // Menghilangkan bayangan pada AppBar
        title: const Padding(
          padding: EdgeInsets.only(bottom: 0),
          child: Text(
            'History',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ));
          },
        ),
        centerTitle: true,

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.black45, // Warna garis pada dasar AppBar
            height: 1.0,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: notificationsHistory.length,
        itemBuilder: (context, index) {
          final notification = notificationsHistory[index];
          return ListTile(
            title: Text(notification.title),
            subtitle: Text(notification.body),
            trailing: Text(notification.timestamp.toString()),
          );
        },
      ),
    );
  }
}

// Step 4: Navigate to HistoryPage (add this in your main page or wherever you want to navigate from)
// Use Navigator.push to navigate to HistoryPage
// Example: Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryPage()));