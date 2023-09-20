import 'package:dms_attendance_app/resources/app_colors.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  String title;

  ButtonWidget({super.key, required this.title});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          color: AppColors().buttonColor,
          borderRadius: BorderRadius.circular(5)),
      height: size.height * 0.07,
      child: Center(
        child: Text(
          widget.title,
          style: TextStyle(color: AppColors().white, fontSize: allsize * 0.014),
        ),
      ),
    );
  }
}
