import 'package:flutter/material.dart';
import 'package:quick_merchant_windows/core/services/web_socket/models/socket_config.dart';
import 'package:quick_merchant_windows/core/services/web_socket/signalr/signalr_socket_manager.dart';

import '../../config/api_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SignalrSocketManager signalrSocketManager = SignalrSocketManager(
      config: SocketClientConfig(
          hubUrl: ApiConstants.hubHost + ApiConstants.merchantOrderHubPath));
  @override
  void initState() {
    super.initState();
    signalrSocketManager.init();
    signalrSocketManager.invoke('SendTestMessage');
    signalrSocketManager.on(
      'OnReceivedTestMessage',
      (data) {
        print(data);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
