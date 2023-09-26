import 'package:flutter/material.dart';
import '../../../resources/app_colors.dart';

//ignore: must_be_immutable
class DropDownWidget extends StatefulWidget {
  List<dynamic> items;
  final Function callBackFunction;
  final String hinttext;

  DropDownWidget({Key? key, required this.items, required this.callBackFunction, required this.hinttext})
      : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String? selectedItem;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors().inputFiledBorder),
        borderRadius: BorderRadius.circular(10),
        color: AppColors().inputFiledFill,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          dropdownColor: AppColors().inputFiledFill,
          hint: Text(widget.hinttext,
              style: TextStyle(color: AppColors().inputFiledBorder)),
          value: selectedItem,
          isExpanded: true,
          items: widget.items
              .map((item){
            return
              DropdownMenuItem(
                  value:item['id'].toString(),
                  child: Text(
                    item['siteName'],
                    style: TextStyle(color: AppColors().black),
                  ));})
              .toList(),
          onChanged: (item) => setState(() {
            selectedItem = item ;
            widget.callBackFunction(item);
          }),
        ),
      ),
    );
  }
}
