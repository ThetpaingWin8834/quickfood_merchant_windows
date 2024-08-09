import 'package:dio/dio.dart';
import 'package:quick_merchant_windows/app.dart';
import 'package:quick_merchant_windows/core/network/dio_client.dart';

import '../../../config/api_constants.dart';
import '../../models/user.dart';

class AuthServices {
  AuthServices._();

  static Future<User?> login(String username, String password) async {
    AppConfig.showLoadingOverlay();
    String uri = "${ApiConstants.mainUrl}auth/access-token";
    final res = await DioClient().post(uri,
        body: FormData.fromMap({
          "Username": username,
          "Password": password,
        }));
    AppConfig.hideLoadingOverlay();

    if (res.isSuccess) {
      try {
        final data = res.data;
        print(res.data);
        final user = User(
          accessToken: data["data"]["access_token"],
          refreshToken: data["data"]["refresh_token"],
          userId: data["data"]["user"]["id"],
          userName: data["data"]["user"]["userName"],
          email: data["data"]["user"]["email"],
          phoneNumber: data["data"]["user"]["phoneNumber"],
          fullName: data["data"]["user"]["fullName"],
          userRole: data["data"]["user"]["user_role"],
        );
        DioClient().setToken(user.accessToken!);
        return user;
      } catch (e, s) {
        print('error $e \n trace $s');
      }
    } else {
      // App.showSnackbar(res.error.toString());
    }
    return null;
  }
}
