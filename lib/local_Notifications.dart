import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class MJNotification {
  static late BuildContext context;
  setContext(BuildContext cont) {
    context = cont;
  }

  static listenMJNotification() {
    AwesomeNotifications()
        .actionStream
        .listen((ReceivedNotification receivedNotification) async {
      print(receivedNotification.body);
      await AwesomeNotifications().getGlobalBadgeCounter().then(
          (value) => AwesomeNotifications().setGlobalBadgeCounter(value - 1));
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => route));
    });
  }

  static notify(String title, body, channelKey) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: channelKey,
            title: title,
            autoDismissible: true,
            color: Colors.deepPurple,
            backgroundColor: Colors.white,
            body: body));
  }
}
