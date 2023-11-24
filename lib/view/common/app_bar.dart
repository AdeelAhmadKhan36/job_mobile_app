import 'package:flutter/material.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/common/reuse_able_text.dart';
class Custom_AppBar extends StatelessWidget {
  final String? text;
  final Widget child;
  final  title;
  final List<Widget>?actions;

  const Custom_AppBar({super.key, this.text, required this.child, this.actions,this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme:IconThemeData(),
      backgroundColor: Color(kLight.value),
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: child,
      actions: actions,
      centerTitle: true,
     title: title,

      );

  }
}
