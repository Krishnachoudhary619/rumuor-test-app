import 'package:flutter/material.dart';

import '../../shared/gen/assets.gen.dart';
import '../../theme/config/app_color.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({
    super.key,
    required this.controller,
    required this.onSend,
  });

  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Type a message',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              onSend();
            },
            child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                    color: AppColor.green, shape: BoxShape.circle),
                child: Assets.svg.sendIcon.svg()),
          )
        ],
      ),
    );
  }
}
