import 'package:flutter/material.dart';

import '../utils/constants/app_colors.dart';
import '../utils/size_config.dart';

class SalesCountLable extends StatelessWidget {
  SalesCountLable({
    super.key,
    required this.lable,
    required this.ammount,
    required this.bgcolour,
  });

  String lable;
  String ammount;
  Color bgcolour;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 40, top: 10, bottom: 10),
      width: SizeConfig.w(context) - 40,
      decoration: BoxDecoration(
          color: bgcolour, borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(lable,
              style: TextStyle(
                  color: AppColors.white, fontWeight: FontWeight.w500)),
          Text(ammount,
              style: TextStyle(
                  color: AppColors.white, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
