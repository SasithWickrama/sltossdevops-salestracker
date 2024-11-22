import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

import '../controllers/login_controller.dart';
import '../models/user.dart';
import '../screen/dashboard.dart';

class LoginProvider extends ChangeNotifier {
  final LoginController _authController = LoginController();

  final _userNameController = TextEditingController();
  TextEditingController get userNameController => _userNameController;

  final _otpController = TextEditingController();
  TextEditingController get otpController => _otpController;

  User _appUser = User(role: '', rtom: '', username: '');
  User get appUser => _appUser;
  set appUser(User x) => _appUser = x;

  Future<void> validateInput(BuildContext context) async {
    if (_userNameController.text == '') {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Username Cannot be Null",
      );
    } else if (_otpController.text == '') {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Password Cannot be Null",
      );
    } else {
      await loginButtonClick(context);
    }
  }

  Future<void> loginButtonClick(BuildContext context) async {
    await _authController
        .login(_userNameController.text, _otpController.text)
        .then(
      (value) async {
        if (!value.getError()) {
          appUser = User(
              rtom: value.getData()[0]["RTOM"].toString(),
              role: value.getData()[0]['ROLE'].toString(),
              sno: value.getData()[0]['SERVICENO'].toString(),
              job: value.getData()[0]['JOBROLE'].toString(),
              acccode: value.getData()[0]['CODE'].toString(),
              username: value.getData()[0]['UNAME'].toString());
          _userNameController.text = '';
          _otpController.text = '';

          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const DashboardPage()));
        } else {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            text: value.getMsg(),
          );
        }
      },
    );
  }
}
