import 'package:dms_attendance_app/export.dart';
import 'package:dms_attendance_app/source/widget/dropdownwidget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SiteScreen extends StatefulWidget {
  const SiteScreen({super.key});

  @override
  State<SiteScreen> createState() => _SiteScreenState();
}

class _SiteScreenState extends State<SiteScreen> {
  List<dynamic>data=[];
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
    Map<String,dynamic>getdata=await Provider.of<RegisterUser>(context,listen: false).getsites();
    setState(() {
      data=getdata['data'];
    });
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    var allsize=MediaQuery.of(context).size.height+MediaQuery.of(context).size.width;
    return  Scaffold(
      body: SafeArea(
          child:SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height*0.2,),
               Text('Chose A Site for Attendance', style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: allsize * 0.015),
            ),
              SizedBox(height: size.height*0.03,),
              Padding(
                padding:EdgeInsets.symmetric(horizontal: size.width * 0.15 ),
                child: DropDownWidget( callBackFunction: (String items) async{
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setString('siteid', items);
                 print(items);
                },
                  items: data,
                  hinttext: 'Select Site',),
              ),
              SizedBox(height: size.height*0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.15 ),
                child: ButtonWidget(
                    title: "Next Screen",
                  ontap: ()async{
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                      String data=prefs.getString('siteid')!;
                      if(data.isNotEmpty)
                        {
                          Get.to(const AttendanceScreen());
                        }
                      else{
                        ZBotToast.showToastError(message: "Please Select Site First");
                      }

                  },
                ),
              )
            ],),
          )
      ),
    );
  }
}
