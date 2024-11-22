import '../models/genaral_responce.dart';
import '../network/app_request.dart';

class SoController {
  Future<GenaralResponce> SocountCurMonth(String username) async {
    return await AppRequest().sendRequest('SocountCurMonth', {'sno': username});
  }

  Future<GenaralResponce> getTargetCUCo(String username) async {
    return await AppRequest().sendRequest('getTargetCUCo', {'sno': username});
  }

  Future<GenaralResponce> getMonthSales(String username, String month) async {
    return await AppRequest()
        .sendRequest('getMonthSales', {'sno': username, 'month': month});
  }

  Future<GenaralResponce> getSlab(String username, String salecount) async {
    return await AppRequest()
        .sendRequest('getSlab', {'sno': username, 'salecount': salecount});
  }

  Future<GenaralResponce> getLastUpdatedTime(String username) async {
    return await AppRequest()
        .sendRequest('getLastUpdatedTime', {'sno': username});
  }
}
