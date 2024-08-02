class RemoteMessage<T> {
  final String invokeType;
  final T data;

  const RemoteMessage({
    required this.invokeType,
    required this.data,
  });
}
