import 'package:flutter/material.dart';

class CustomFailedDialugue extends StatelessWidget {
  String message;

  CustomFailedDialugue({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return AlertDialog(
      content: Container(
        height: size.height * 0.4,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.04,
            ),
            CircleAvatar(
              radius: allsize * 0.03,
              backgroundColor: Colors.red,
              child: Icon(
                Icons.cancel_outlined,
                color: Colors.white,
                size: allsize * 0.03,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Text("ERROR",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: allsize * 0.02,
                    fontWeight: FontWeight.w800)),
            SizedBox(
              height: size.height * 0.005,
            ),
            Text(
              message,
              style: TextStyle(fontSize: allsize * 0.012),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
           InkWell(
             onTap: (){
               Navigator.pop(context);
             },
             child: Container(
               height: size.height*0.06,
               width: size.width*0.35,
               decoration: BoxDecoration(
                 color: Colors.red,
                 borderRadius: BorderRadius.circular(10),
               ),
               child: Center(child: Text("Try Again",style: TextStyle(color: Colors.white,fontSize: allsize*0.012,fontWeight: FontWeight.bold),)),
             ),
           )
          ],
        ),
      ),
    );
  }
}
