import 'dart:convert';
import 'package:logger/logger.dart';

import '../models/genaral_responce.dart';
import '../utils/constants/asset_constants.dart';
import 'package:http/http.dart' as http;

class AppRequest {
  Future<GenaralResponce> sendRequest(String function, var inputlist) async {
    Uri url = Uri(
      scheme: AssetConstants.apiScheema1,
      host: AssetConstants.apihost1,
      path: '${AssetConstants.apipath1}$function',
    );
    GenaralResponce newResponce;
    Logger().d(function);
    Logger().d(inputlist);
    try {
      final response = await http.post(url,
          headers: {"HttpHeaders.contentTypeHeader": "application/json"},
          body: inputlist);

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        Logger().i(responseData);
        newResponce = GenaralResponce(
            error: responseData['error'],
            message: responseData['message'],
            data: responseData['data']);
      } else {
        newResponce = GenaralResponce(
            error: true, message: 'API Error Code:${response.statusCode} ');
      }
    } catch (e) {
      newResponce = GenaralResponce(
          error: true, message: 'Connection Error Code:${e.toString()} ');
    }

    return newResponce;
  }
}
