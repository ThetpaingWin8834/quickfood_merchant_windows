import 'dart:developer';

import 'package:rxdart/rxdart.dart';
import 'package:signalr_netcore/ihub_protocol.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:quick_merchant_windows/core/models/user.dart';
import 'package:quick_merchant_windows/core/services/web_socket/models/socket_config.dart';
import '../../../network/dio_client.dart';
import 'client/signalr_http_client.dart';

typedef SocketRes = List<Object?>?;
typedef SocketReq = List<Object>?;
typedef MessageHandlerCallback = void Function(SocketRes);
typedef ConnectionIdChangedCallback = void Function(String);

class SignalrSocketManager {
  final SocketClientConfig config;
  final User user;
  HubConnection? _connection;
  bool _isInitialized = false;
  final BehaviorSubject<String> connectionIdStream = BehaviorSubject();

  SignalrSocketManager({
    required this.config,
    required this.user,
  });

  void _init() {
    if (_isInitialized) return;
    final option = HttpConnectionOptions(
      httpClient: SignalrHttpClientImpl(client: DioClient()),
      headers: MessageHeaders()
        ..setHeaderValue('Authorization', 'Bearer ${user.accessToken}'),
      logMessageContent: true,
    );
    final builder =
        HubConnectionBuilder().withUrl(config.hubUrl, options: option);

    if (config.autoReconnect) builder.withAutomaticReconnect();
    _connection = builder.build();
    _connection?.onclose(onClose);
    _connection?.onreconnected(onReconnected);
    _connection?.onreconnecting(onReconnecting);

    _isInitialized = true;
  }

  Future<String?> startConnection() async {
    _init();
    return await _connection?.start()?.then((_) {
      if (_connection?.connectionId != null) {
        _onConnectionIdChanged(_connection!.connectionId!);
        return _connection?.connectionId;
      } else {
        return null;
      }
    }, onError: (e, s) {
      logger('Failed to start SignalR connection: $e');
    });
  }

  Future<void> stopConnection() async {
    await _connection?.stop();
    _connection = null;
  }

  void onClose({Exception? error}) {
    logger('SignalR connection closed: $error');
  }

  void onReconnecting({Exception? error}) {
    logger('SignalR connection reconnecting: $error');
  }

  void onReconnected({String? connectionId}) {
    _onConnectionIdChanged(connectionId!);

    logger('SignalR connection reconnected: $connectionId');
  }

  void on(String methodName, MessageHandlerCallback callback) {
    _connection?.on(methodName, callback);
  }

  Future<Object?> invoke(String methodName, {SocketReq args}) async {
    if (_connection?.state == HubConnectionState.Connected) {
      return _connection?.invoke(methodName, args: args).catchError((e) {
        return e;
      });
    } else {
      return _connection?.state?.name;
    }
  }

  void logger(dynamic d) {
    log(d);
  }

  // void registerOnCallback<T>(
  //   String invokeType,
  //   T Function(List<Object?>?) fromRemoteMessage,
  //   void Function(RemoteMessage<T>) handler,
  // ) {
  //   print("Socket client registered $invokeType");

  //   _connection?.on(invokeType, (arg) {
  //     print("Socket message received $arg");
  //     handler(RemoteMessage(
  //       invokeType: invokeType,
  //       data: fromRemoteMessage(arg),
  //     ));
  //   });
  // }

  late final List<ConnectionIdChangedCallback> _connectionChangedHandlers = [];

  void registerCallbackOnConnectionIdChanged(
    ConnectionIdChangedCallback callback,
  ) {
    _connectionChangedHandlers.add(callback);
  }

  void _invokeRegisteredCallbackOnConnectionIdChanges(String connectionId) {
    for (var fun in _connectionChangedHandlers) {
      logger("Calling registered callback");
      fun.call(connectionId);
    }
  }

  void _onConnectionIdChanged(String connectionId) {
    connectionIdStream.add(connectionId);
    _invokeRegisteredCallbackOnConnectionIdChanges(connectionId);
  }
}
