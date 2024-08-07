// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:quick_merchant_windows/app.dart';
import 'package:quick_merchant_windows/core/debug.dart';

import 'package:quick_merchant_windows/core/models/user.dart';
import 'package:quick_merchant_windows/core/services/web_socket/models/socket_config.dart';
import 'package:quick_merchant_windows/core/services/web_socket/signalr/signalr_socket_manager.dart';
import 'package:quick_merchant_windows/main.dart';

import '../../config/api_constants.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer timer;
  late final SignalrSocketManager signalrSocketManager = SignalrSocketManager(
      user: widget.user,
      config: SocketClientConfig(
          hubUrl: ApiConstants.hubHost + ApiConstants.merchantOrderHubPath));

  String? connectionId;
  @override
  void initState() {
    super.initState();
    try {
      signalrSocketManager.connectionIdStream.listen(
        (value) {
          setState(() {
            connectionId = value;
          });
        },
      );
      signalrSocketManager.startConnection().then((id) {
        // signalrSocketManager.registerCallbackOnConnectionIdChanged(
        //   (connectionId) {
        //     setState(() {
        //       this.connectionId = connectionId;
        //     });
        //   },
        // );

        signalrSocketManager.on(
          'OnReceivedTestMessage',
          (data) {
            flutterLocalNotification.show(
                5,
                'Main Title',
                '$data',
                NotificationDetails(
                    windows: WindowsNotificationDetails(
                  subtitle: 'WindowsNotificationDetails Subtitle',
                  // header: WindowsHeader(id: id, title: title, arguments: arguments)
                )));
          },
        );
      });
    } catch (e, s) {
      dlog(e, s: s);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: connectionId == null
                  ? null
                  : () {
                      Timer.periodic(
                        Duration(seconds: 3),
                        (timer) {
                          this.timer = timer;
                          signalrSocketManager.invoke('SendTestMessage', args: [
                            connectionId!,
                            'hello ${DateTime.now()}'
                          ]).then(
                            (value) {
                              App.showSnackbar(value.toString());
                            },
                          );
                        },
                      );
                    },
              child: Text('Send')),
          ElevatedButton(
              onPressed: connectionId == null
                  ? null
                  : () {
                      timer.cancel();
                    },
              child: Text('Stop')),
        ],
      ),
    );
  }
}
