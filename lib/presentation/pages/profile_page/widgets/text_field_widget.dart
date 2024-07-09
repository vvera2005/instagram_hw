import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../constants/gaps.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
  });

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            hintText,
            style: const TextStyle(color: Colors.grey),
          ),
          TextField(
            controller: controller,
          ),
          SizedBox(
            height: Gaps.small,
          ),
        ],
      ),
    );
  }
}
