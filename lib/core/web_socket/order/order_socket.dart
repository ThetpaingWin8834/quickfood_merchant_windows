import 'package:quick_merchant_windows/config/api_constants.dart';
import 'package:quick_merchant_windows/core/enums/order_notification_types.dart';
import 'package:quick_merchant_windows/core/web_socket/models/socket_config.dart';
import 'package:quick_merchant_windows/core/web_socket/signalr/signalr_socket_manager.dart';

import '../../models/noti/noti_models.dart';
import '../../models/remote_message.dart';

class OrderSocket extends SignalrSocketManager {
  OrderSocket()
      : super(
            config: const SocketClientConfig(
                hubUrl:
                    ApiConstants.hubHost + ApiConstants.merchantOrderHubPath));
  void onRewOrderAlert(
      void Function(RemoteMessage<NotificationModel>) handler) {
    const invoke = OrderSocketNotificationType.newOrderAlert;
    registerOnCallback<NotificationModel>(
      invoke.type,
      NotificationModel.fromRemoteMessage,
      handler,
    );
  }
}
