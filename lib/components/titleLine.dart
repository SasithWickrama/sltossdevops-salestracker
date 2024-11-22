import 'package:flutter/material.dart';

import '../utils/constants/app_colors.dart';
import '../utils/size_config.dart';

class TitleLine extends StatelessWidget {
  TitleLine({
    super.key,
    required this.title,
  });

  String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 40, top: 10, bottom: 10),
      width: SizeConfig.w(context),
      decoration: const BoxDecoration(
        color: AppColors.buttonGreen,
      ),
      child: Text(title,
          style: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15)),
    );
  }
}
