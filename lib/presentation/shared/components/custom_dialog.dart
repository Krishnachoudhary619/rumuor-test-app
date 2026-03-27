import 'package:flutter/material.dart';

import '../../theme/config/app_theme.dart';
import 'app_text_theme.dart';
import 'custom_filled_button.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
    required this.title,
    required this.description,
    this.onPositive,
    this.onNegative,
    this.height,
  }) : super(key: key);
  final String title;
  final String description;
  final VoidCallback? onPositive;
  final VoidCallback? onNegative;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      // shadowColor: AppColor.black.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(15),
      ),
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      alignment: Alignment.center,
      child: Container(
        decoration: ShapeDecoration(
          color: Theme.of(context).cardTheme.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x1C000000),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        // color: AppColor.white,
        height: height ?? 160,
        margin: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 15),
                alignment: Alignment.topLeft,
                child: Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomFilledButton.secondary(
                    title: 'Cancel',
                    onTap: onNegative ?? () => Navigator.pop(context),
                    borderRadius:
                        const BorderRadius.only(bottomLeft: Radius.circular(6)),
                  ),
                ),
                Expanded(
                  child: CustomFilledButton(
                    title: 'Confirm',
                    onTap: onPositive,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(6),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
