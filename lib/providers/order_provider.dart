import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:incentive_tracker/models/genaral_responce.dart';
import 'package:incentive_tracker/models/service_summary.dart';
import 'package:incentive_tracker/utils/constants/app_colors.dart';
import 'package:provider/provider.dart';

import '../controllers/so_controller.dart';
import 'login_provider.dart';

class OrderProvider extends ChangeNotifier {
  final SoController _soController = SoController();

  String abcab = "";
  String abftth = "";
  String abftthUpgrade = "";
  String lte = "";
  String bb = "";
  String iptv = "";

  String target = "";
  String recordCount = "";
  String targetMsg = "Target Not Reached";
  String slab = "";
  String mintarget = "";
  String maxtarget = "";
  String nexttarget = "";
  String currentSlab = "";

  String updatedTime = "";

  // Color bgcolour = Colors.transparent;

  Color bgcolour = const Color.fromARGB(255, 183, 163, 230);

  bool ach = false;

  List<ServiceSumary> _myList = [];

  set myList(List<ServiceSumary> value) => _myList = value;
  List<ServiceSumary> get myList => _myList;

  Future<void> resetData() async {
    abcab = "";
    abftth = "";
    abftthUpgrade = "";
    lte = "";
    bb = "";
    iptv = "";

    target = "";
    recordCount = "";
    targetMsg = "Target Not Reached";
    slab = "";
    mintarget = "";
    maxtarget = "";
    nexttarget = "";
    currentSlab = "";

    updatedTime = "";

    // bgcolour = Colors.transparent;
    bgcolour = const Color.fromARGB(255, 183, 163, 230);

    ach = false;

    _myList = [];

    notifyListeners();
  }

  Future<bool> getSoCount(BuildContext context) async {
    GenaralResponce value = await _soController.SocountCurMonth(
        Provider.of<LoginProvider>(context, listen: false).appUser.sno);
    if (!value.getError()) {
      for (var x in value.getData()) {
        if (x["DSERVICE_TYPE"].toString() == "AB-CAB") {
          abcab = x["Z"].toString();
        }
        if (x["DSERVICE_TYPE"].toString() == "AB-FTTH") {
          abftth = x["Z"].toString();
        }
        if (x["DSERVICE_TYPE"].toString() == "AB-FTTH :UPGRADE") {
          abftthUpgrade = x["Z"].toString();
        }
        if (x["DSERVICE_TYPE"].toString() == "AB-WIRELESS ACCESS") {
          lte = x["Z"].toString();
        }
        if (x["DSERVICE_TYPE"].toString() == "BROADBAND") {
          bb = x["Z"].toString();
        }
        if (x["DSERVICE_TYPE"].toString() == "IPTV") {
          iptv = x["Z"].toString();
        }
      }
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: value.getMsg(),
      );
    }

    notifyListeners();

    return true;
  }

  Future<void> getTargetCUCo(BuildContext context) async {
    await _soController
        .getTargetCUCo(
            Provider.of<LoginProvider>(context, listen: false).appUser.sno)
        .then((value) {
      if (!value.getError()) {
        target = value.getData()[0]["TARGET"];
        recordCount = value.getData()[0]["REC_COUNT"];

        if (int.parse(value.getData()[0]["TARGET"]) <
            int.parse(value.getData()[0]["REC_COUNT"])) {
          bgcolour = AppColors.abftthup;
          targetMsg = "Target Reached";
        }
      } else {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: value.getMsg(),
        );
      }
    });
  }

  Future<void> getMonthSales(BuildContext context, String month) async {
    await _soController
        .getMonthSales(
            Provider.of<LoginProvider>(context, listen: false).appUser.sno,
            month)
        .then((value) {
      if (!value.getError()) {
        _myList.clear();
        for (var element in value.getData()) {
          _myList.add(ServiceSumary(
            service: element["DSERVICE_TYPE"],
            ok: element["OK"],
            su: element["SU"],
            tx: element["TX"] ?? '',
            pn: element["PN"] ?? '',
            tot: element["TOTAL"] ?? '',
          ));
        }
      } else {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: value.getMsg(),
        );
      }

      notifyListeners();
    });
  }

  Future<void> getSlab(BuildContext context) async {
    await _soController
        .getSlab(Provider.of<LoginProvider>(context, listen: false).appUser.sno,
            recordCount)
        .then((value) {
      if (!value.getError()) {
        slab = value.getData()[0]["RATE_LEVEL"];
        mintarget = value.getData()[0]["MIN_TARGET"];
        maxtarget = value.getData()[0]["MAX_TARGET"];

        nexttarget =
            'For Next Slab ${(int.parse(maxtarget) - int.parse(recordCount) + 1).toString()}';

        currentSlab = 'Current Slab:  $slab';

        if (slab == "SILVER") {
          bgcolour = AppColors.silver;
        }
        if (slab == "GOLD") {
          bgcolour = AppColors.gold;
        }
        if (slab == "PLATINUM") {
          bgcolour = AppColors.platinam;
        }
        if (slab == "BRONZE") {
          bgcolour = AppColors.bronze;
        }

        notifyListeners();
      } else {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: value.getMsg(),
        );
      }
    });
  }

  Future<void> getLastUpdatedTime(BuildContext context) async {
    await _soController
        .getLastUpdatedTime(
            Provider.of<LoginProvider>(context, listen: false).appUser.sno)
        .then((value) {
      if (!value.getError()) {
        updatedTime = value.getData()[0]["CREATE_DATE"];

        notifyListeners();
      } else {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: value.getMsg(),
        );
      }
    });
  }
}
