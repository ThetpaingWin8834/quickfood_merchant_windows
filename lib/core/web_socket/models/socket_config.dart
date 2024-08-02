class SocketClientConfig {
  final String hubUrl;
  final bool autoReconnect;
  final int reconnectTimeOutSecs;

  const SocketClientConfig({
    required this.hubUrl,
    this.autoReconnect = true,
    this.reconnectTimeOutSecs = 8000,
  });
}
