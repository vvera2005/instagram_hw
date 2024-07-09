import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class IntOnStringWidget extends StatelessWidget {
  const IntOnStringWidget(
      {super.key, required this.integer, required this.mstr});
  final int integer;
  final String mstr;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Text(integer.toString()),
        Text(mstr),
      ]),
    );
  }
}
