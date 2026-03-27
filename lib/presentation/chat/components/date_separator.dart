import 'package:flutter/material.dart';

import '../../../core/utils/app_utils.dart';
import '../../theme/config/app_color.dart';

class DateSeparator extends StatelessWidget {
  const DateSeparator({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: AppColor.blueGrey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            AppUtils.formatDateSeparator(date),
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
