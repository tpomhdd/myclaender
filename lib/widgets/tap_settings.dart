import 'package:flutter/material.dart';

import '../Theme/color.dart';
import '../core/man_widget/mytext.dart';

class tap_settings extends StatefulWidget {
  final void Function()? onPressed1;
  final String txt;

  const tap_settings({Key? key, this.onPressed1, required this.txt}) : super(key: key);

  @override
  State<tap_settings> createState() => _tap_settingsState();
}

class _tap_settingsState extends State<tap_settings> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                color: Colors.white,
                border: Border.all(color: AppColor.primaryColor, width: 1)),
            alignment: Alignment.center,
            child: MyText(color: Colors.black, text: widget.txt, size: 22)),
      ),
    );
  }
}
