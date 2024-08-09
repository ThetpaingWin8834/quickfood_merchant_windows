

// class OrderSocket extends SignalrSocketManager {
//   OrderSocket()
//       : super(
//             config: const SocketClientConfig(
//                 hubUrl:
//                     ApiConstants.hubHost + ApiConstants.merchantOrderHubPath));
//   void onRewOrderAlert(
//       void Function(RemoteMessage<NotificationModel>) handler) {
//     const invoke = OrderSocketNotificationType.newOrderAlert;
//     registerOnCallback<NotificationModel>(
//       invoke.type,
//       NotificationModel.fromRemoteMessage,
//       handler,
//     );
//   }
// }
