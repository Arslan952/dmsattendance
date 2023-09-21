import 'package:dms_attendance_app/export.dart';

class ButtonWidget extends StatefulWidget {
  String title;
  Function()? ontap;
  ButtonWidget({super.key, required this.title,this.ontap});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return InkWell(
      onTap: widget.ontap,
      child: Container(
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
      ),
    );
  }
}
