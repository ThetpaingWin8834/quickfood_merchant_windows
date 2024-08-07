import 'package:signalr_netcore/signalr_client.dart';

import 'package:quick_merchant_windows/core/network/apiclient.dart';

class SignalrHttpClientImpl extends SignalRHttpClient {
  ApiClient client;
  SignalrHttpClientImpl({
    required this.client,
  });
  @override
  Future<SignalRHttpResponse> send(SignalRHttpRequest request) async {
    client.addHeaders(request.headers?.asMap ?? {});
    final response = await client.send(
      request.url ?? '',
      request.method ?? 'GET',
      body: request.content,
      autoParsejson: false,
    );
    return SignalRHttpResponse(
      response.statusCode ?? 0,
      statusText: response.statusMessage,
      content: response.data,
    );
  }
}
