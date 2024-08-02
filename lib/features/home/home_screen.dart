// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:quick_merchant_windows/core/debug.dart';

import 'package:quick_merchant_windows/core/models/user.dart';
import 'package:quick_merchant_windows/core/services/web_socket/models/socket_config.dart';
import 'package:quick_merchant_windows/core/services/web_socket/signalr/signalr_socket_manager.dart';

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
  late final SignalrSocketManager signalrSocketManager = SignalrSocketManager(
      user: widget.user,
      config: SocketClientConfig(
          hubUrl: ApiConstants.hubHost + ApiConstants.merchantOrderHubPath));
  String? connectionId;
  @override
  void initState() {
    super.initState();
    try {
      signalrSocketManager.init();
      signalrSocketManager.startConnection().then((_) {
        signalrSocketManager.registerCallbackOnConnectionIdChanged(
          (connectionId) {
            setState(() {
              this.connectionId = connectionId;
            });
          },
        );

        signalrSocketManager.on(
          'OnReceivedTestMessage',
          (data) {
            print(data);
          },
        );
      });
    } catch (e, s) {
      detailsLog(e, s: s);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: connectionId == null
                ? null
                : () {
                    signalrSocketManager.invoke('SendTestMessage',
                        args: [connectionId!, 'hello ${DateTime.now()}']);
                  },
            child: Text('Send')),
      ),
    );
  }
}
