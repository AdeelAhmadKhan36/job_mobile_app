import 'package:flutter/material.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/common/reuse_able_text.dart';

class Custom_AppBar extends StatelessWidget {
  final String? text;
  final Widget child;
  final Widget? title;
  final Widget? iconbutton;
  final List<Widget>? actions;

  const Custom_AppBar({
    Key? key,
    this.text,
    required this.child,
    this.title,
    this.actions,
    this.iconbutton
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(),
      backgroundColor: Colors.white54,
      elevation: 0,
      automaticallyImplyLeading: false,
      leadingWidth: 70,
      leading: child,
      actions: actions,
      centerTitle: true,
      title: title ??
          (text != null
              ? Text(
            text!,
            style: TextStyle(fontSize: 20, color: Colors.black,fontWeight: FontWeight.bold), // Update color
          )
              : null),
    );
  }
}


