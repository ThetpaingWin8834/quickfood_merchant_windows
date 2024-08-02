// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:signalr_netcore/ihub_protocol.dart';
import 'package:signalr_netcore/signalr_client.dart';

import 'package:quick_merchant_windows/core/models/user.dart';
import 'package:quick_merchant_windows/core/network/dio_client.dart';
import 'package:quick_merchant_windows/core/services/web_socket/models/socket_config.dart';
import 'package:quick_merchant_windows/core/services/web_socket/signalr/client/signalr_http_client.dart';

import '../../../models/remote_message.dart';

typedef SocketRes = List<Object?>?;
typedef SocketReq = List<Object>?;
typedef MessageHandlerCallback = void Function(SocketRes);
typedef ConnectionIdChangedCallback = void Function(String);

class SignalrSocketManager {
  // SignalrNotificationManager.internal();

  // static SignalrNotificationManager _instance =
  //     SignalrNotificationManager.internal();
  // factory SignalrNotificationManager() => _instance;
  final SocketClientConfig config;
  final User user;
  HubConnection? _connection;

  SignalrSocketManager({
    required this.config,
    required this.user,
  });
  void init() {
    final option = HttpConnectionOptions(
      // httpClient: SignalrHttpClientImpl(client: DioClient()),
      headers: MessageHeaders()
        ..setHeaderValue('Authorization', 'Bearer ${user.accessToken}'),
      logMessageContent: true,
    );
    final builder =
        HubConnectionBuilder().withUrl(config.hubUrl, options: option);
    _connection?.onclose(
      ({error}) {},
    );
    if (config.autoReconnect) builder.withAutomaticReconnect();
    _connection = builder.build();
    _connection?.onclose(onClose);
    _connection?.onreconnected(onReconnected);
    _connection?.onreconnecting(onReconnecting);
  }

  Future<void> startConnection() async {
    _connection?.start()?.then((_) {
      if (_connection?.connectionId != null) {
        onConnectionIdChanged(_connection!.connectionId!);
      }
    }, onError: (e) {
      print('Failed to start SignalR connection: $e');
    });
  }

  Future<void> stopConnection() async {
    await _connection?.stop();
    _connection = null;
  }

  void onClose({Exception? error}) {
    print('SignalR connection closed: $error');
  }

  void onReconnecting({Exception? error}) {
    print('SignalR connection reconnecting: $error');
  }

  void onReconnected({String? connectionId}) {
    print('SignalR connection reconnected: $connectionId');
  }

  void on(String methodName, MessageHandlerCallback callback) {
    _connection?.on(methodName, callback);
  }

  Future<Object?> invoke(String methodName, {SocketReq args}) async {
    return await _connection?.invoke(methodName, args: args);
  }

  void registerOnCallback<T>(
    String invokeType,
    T Function(List<Object?>?) fromRemoteMessage,
    void Function(RemoteMessage<T>) handler,
  ) {
    print("Socket client registered $invokeType");

    _connection?.on(invokeType, (arg) {
      print("Socket message received $arg");
      handler(RemoteMessage(
        invokeType: invokeType,
        data: fromRemoteMessage(arg),
      ));
    });
  }

  late final List<ConnectionIdChangedCallback> _connectionChangedHandlers = [];

  void registerCallbackOnConnectionIdChanged(
    ConnectionIdChangedCallback callback,
  ) {
    _connectionChangedHandlers.add(callback);
  }

  void _invokeRegisteredCallbackOnConnectionIdChanges(String connectionId) {
    _connectionChangedHandlers.forEach((fun) {
      print("Calling registered callback");
      fun.call(connectionId);
    });
  }

  void onConnectionIdChanged(String connectionId) {
    _invokeRegisteredCallbackOnConnectionIdChanges(connectionId);
  }
}
