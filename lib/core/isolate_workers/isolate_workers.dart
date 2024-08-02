
// @pragma("vm:entry-point")
// class MerchantBackgroundWorker {
//   @pragma("vm:entry-point")
//   static Future<void> start() async {
//    ;

//     //Start
//     appController.registerServiceInstance(service);
//     await appController.onReady();


//     Timer? timer;
//     service.on('stopService').listen((event) async {
//       timer?.cancel();
//       await notificationService.cancelAll();
//     });

//     String lastMsg = "";

//     Timer.periodic(const Duration(seconds: 1), (newTimer) async {
//       timer = newTimer;
//       final timeStamp = DateFormat("h:mm:ss").format(DateTime.now());
//       final merchantOrderSocket = appController.merchantOrderSocket;
//       final merchantOrderState = appController.merchantOrdersBloc.state;

//       final orderStamp = merchantOrderState is MerchantOrdersReady
//           ? "•📲 ${merchantOrderState.currentOrders.length} Orders"
//           : null;

//       final connectionState = merchantOrderSocket.connection?.state;
//       final connectionStamp = "•🌐 ${connectionState?.name}";

//       /// you can see this log in logcat
//       final msg = "Background service running";
//       final logMsg = "${kDebugMode ? "🕒 $timeStamp" : ""}${orderStamp == null ? "" : "  $orderStamp"} $connectionStamp ${merchantOrderSocket.connection?.connectionId}";
//       print(logMsg);

//       if (lastMsg == msg) return;
//       lastMsg = msg;

//       await notificationService.show(
//         888,
//         'Quick Food Order Service',
//         msg,
//         const NotificationDetails(
//           android: AndroidNotificationDetails(
//             'foreground_noti_ch_id',
//             'Quick Food Foreground Service',
//             icon: 'ic_bg_service_small',
//             ongoing: true,
//           ),
//         ),
//       );
//     });
//   }
// }
