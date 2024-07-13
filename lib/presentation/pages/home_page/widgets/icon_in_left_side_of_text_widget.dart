import 'package:flutter/material.dart';

import '../../../constants/gaps.dart';

class IconInLeftSideOfTextWidget extends StatelessWidget {
  const IconInLeftSideOfTextWidget(
      {super.key,
      required this.myicon,
      required this.text,
      required this.onPressed});
  final IconData myicon;
  final String text;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: Gaps.large,
        ),
        Icon(myicon),
        TextButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ))
      ],
    );
  }
}
