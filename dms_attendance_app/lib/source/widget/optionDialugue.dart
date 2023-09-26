import 'package:dms_attendance_app/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomOptionDialugue extends StatelessWidget {
  String message,status;
  CustomOptionDialugue({super.key, required this.message,required this.status});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return AlertDialog(
      content: Container(
        height: size.height*0.3,
        child: Column(
          children: [
            SizedBox(height: size.height*0.04,),
            CircleAvatar(
              radius: allsize * 0.03,
              backgroundColor: Colors.white,
              child: Icon(
                status=='failure'?CupertinoIcons.exclamationmark:
                CupertinoIcons.checkmark,
                color: AppColors().buttonColor,
                size: allsize * 0.03,
              ),
            ),
            SizedBox(height: size.height*0.02,),
            Text(status=='failure'?message:message,style: TextStyle(fontSize:allsize*0.013),),
            SizedBox(height: size.height*0.02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: (){
                    Provider.of<RegisterUser>(context,listen: false).change(false);
                    Get.off(const AttendanceScreen());
                  },
                  child: Container(
                    height: size.height*0.06,
                    width: size.width*0.2,
                    decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors().buttonColor)
                    ),
                    child:  Center(
                      child: Text("Go Back",style: TextStyle(fontSize: allsize*0.011),),
                    ),
                  ),
                ),
                SizedBox(width: size.width*0.06,),
                InkWell(
                  onTap: (){
                    Provider.of<RegisterUser>(context,listen: false).change(false);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: size.height*0.06,
                    width: size.width*0.2,
                    decoration: BoxDecoration(
                      color:AppColors().buttonColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text("Add More",style: TextStyle(
                        color: Colors.white,
                        fontSize: allsize*0.011
                      ),),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      )
    );
  }
}
