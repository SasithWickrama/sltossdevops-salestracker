import '../models/genaral_responce.dart';
import '../network/app_request.dart';
import '../utils/constants/asset_constants.dart';

class LoginController {
  Future<GenaralResponce> login(String username, String pwd) async {
    return await AppRequest().sendRequest('login',
        {'uname': username, 'appversion': AssetConstants.version, 'pwd': pwd});
  }

  Future<GenaralResponce> validateRequest(String username, String otp) async {
    return await AppRequest().sendRequest('userLogin', {
      'username': username,
      'appversion': AssetConstants.version,
      'otp': otp
    });
  }
}
