// class MerchantOrderSocket extends SocketClientRealAdapter {
//   final RegisterNotificationTokenUsecase registerNotificationTokenUsecase;

//   MerchantOrderSocket(
//     super.config,
//     super.client,
//     this.registerNotificationTokenUsecase,
//   );

//   void onNewOrderAlert(
//       void Function(RemoteMessage<NotificationEntity>) handler) {
//     const invoke = MerchantOrderSocketNotificationType.newOrderAlert;
//     registerOnCallback<NotificationEntity>(
//       invoke.type,
//       NotificationModel.fromRemoteMessage,
//       handler,
//     );
//   }

//   void onQuickPayAlert(
//       void Function(RemoteMessage<NotificationEntity>) handler) {
//     const invoke = MerchantOrderSocketNotificationType.quickPay;
//     registerOnCallback<NotificationEntity>(
//       invoke.type,
//       NotificationModel.fromRemoteMessage,
//       handler,
//     );
//   }

//   void onNotify(void Function(RemoteMessage<NotificationEntity>) handler) {
//     const invoke = MerchantOrderSocketNotificationType.notify;
//     registerOnCallback<NotificationEntity>(
//       invoke.type,
//       NotificationModel.fromRemoteMessage,
//       handler,
//     );
//   }

//   void onCustomerPickup(
//       void Function(RemoteMessage<NotificationEntity>) handler) {
//     const invoke = MerchantOrderSocketNotificationType.customerPickup;
//     registerOnCallback<NotificationEntity>(
//       invoke.type,
//       NotificationModel.fromRemoteMessage,
//       handler,
//     );
//   }

//   void onCancelOrder(void Function(RemoteMessage<NotificationEntity>) handler) {
//     const invoke = MerchantOrderSocketNotificationType.cancelOrder;
//     registerOnCallback<NotificationEntity>(
//       invoke.type,
//       NotificationModel.fromRemoteMessage,
//       handler,
//     );
//   }

//   void onConfirm(void Function(RemoteMessage<NotificationEntity>) handler) {
//     const invoke = MerchantOrderSocketNotificationType.shopConfirm;
//     registerOnCallback<NotificationEntity>(
//       invoke.type,
//       NotificationModel.fromRemoteMessage,
//       handler,
//     );
//   }

//   void onReOrder(void Function(RemoteMessage<NotificationEntity>) handler) {
//     const invoke = MerchantOrderSocketNotificationType.reOrder;
//     registerOnCallback<NotificationEntity>(
//       invoke.type,
//       NotificationModel.fromRemoteMessage,
//       handler,
//     );
//   }

//   void onReturnOrder(void Function(RemoteMessage<NotificationEntity>) handler) {
//     const invoke = MerchantOrderSocketNotificationType.returnOrder;
//     registerOnCallback<NotificationEntity>(
//       invoke.type,
//       NotificationModel.fromRemoteMessage,
//       handler,
//     );
//   }

//   void onPickupByBiker(
//       void Function(RemoteMessage<NotificationEntity>) handler) {
//     const invoke = MerchantOrderSocketNotificationType.pickupByBiker;
//     registerOnCallback<NotificationEntity>(
//       invoke.type,
//       NotificationModel.fromRemoteMessage,
//       handler,
//     );
//   }

//   void onReturnByBiker(
//       void Function(RemoteMessage<NotificationEntity>) handler) {
//     const invoke = MerchantOrderSocketNotificationType.returnByBiker;
//     registerOnCallback<NotificationEntity>(
//       invoke.type,
//       NotificationModel.fromRemoteMessage,
//       handler,
//     );
//   }

//   void onPunishItem(void Function(RemoteMessage<NotificationEntity>) handler) {
//     const invoke = MerchantOrderSocketNotificationType.punishItem;
//     registerOnCallback<NotificationEntity>(
//       invoke.type,
//       NotificationModel.fromRemoteMessage,
//       handler,
//     );
//   }

//   void onTestMessage(void Function(RemoteMessage<String>) handler) {
//     const invoke = MerchantOrderSocketNotificationType.receivedTestMessage;
//     registerOnCallback<String>(
//       invoke.type,
//       (data) => data.toString(),
//       handler,
//     );
//   }
// }
