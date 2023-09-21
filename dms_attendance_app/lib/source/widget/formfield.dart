import 'package:dms_attendance_app/export.dart';

class FormFieldWidget extends StatefulWidget {
  TextEditingController controller;
  String hint;

  FormFieldWidget({super.key, required this.hint
      ,required this.controller
      });

  @override
  State<FormFieldWidget> createState() => _FormFieldWidgetState();
}

class _FormFieldWidgetState extends State<FormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return TextFormField(
      controller: widget.controller,
      style: TextStyle(
          color: const Color(0xff707070),
          fontSize: allsize * 0.012,
          fontWeight: FontWeight.w400),
      cursorColor: AppColors().inputFiledBorder,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: size.height * 0.023, horizontal: size.width * 0.07),
        filled: true,
        hintText: widget.hint,
        hintStyle: TextStyle(
            color: const Color(0xff707070),
            fontSize: allsize * 0.012,
            fontWeight: FontWeight.w400),
        fillColor: AppColors().inputFiledFill,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: AppColors().inputFiledBorder,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: AppColors().inputFiledBorder,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
