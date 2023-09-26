// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:dms_attendance_app/export.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MarkCamera extends StatefulWidget {
  String clock;
  MarkCamera({super.key,required this.clock});

  @override
  State<MarkCamera> createState() => _MarkCameraState();
}

class _MarkCameraState extends State<MarkCamera> {
  bool isloading = false;



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize=MediaQuery.of(context).size.height+MediaQuery.of(context).size.width;
    return Scaffold(
      body: Consumer<RegisterUser>(builder: (context,markattendanceprovider, child) {
        return  Stack(
          children: [
            SmartFaceCamera(
              // autoCapture: true,
              defaultCameraLens: CameraLens.front,
              imageResolution: ImageResolution.ultraHigh,
              message: 'Center your face in the square',
              showCameraLensControl: false,
              enableAudio: false,
              showFlashControl: false,
              onCapture: (File? image) async{
                final SharedPreferences prefs = await SharedPreferences.getInstance();
                String id=prefs.getString('siteid')!;
                await markattendanceprovider.MarkAttendance(image!.path,id,widget.clock,context);
              },
              captureControlIcon:Container(
                height: allsize*0.06,
                width: allsize*0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color(0xfff5e5e5),
                ),
                child: Center(
                  child:Icon(Icons.camera,size: allsize*0.03,),
                ),
              ),
              messageBuilder: (context, face) {
                if (face == null) {
                  return _message('Place your face in the camera',size);
                }
                if (!face.wellPositioned) {
                  return _message('Center your face in the square',size);
                }
                return const SizedBox.shrink();
              },
            ),
          markattendanceprovider.changeindicator == true
                ? Container(
              height: size.height * 1,
              width: size.width * 1,
              color: Colors.black54,
              child: Center(
                child:Container(
                  child:  Lottie.asset('assets/lottie/animation_lmt7mafg.json'),
                ),
              ),
            )
                : Container()
          ],
        );
      })

    );
  }

  Widget _message(String msg,Size size) => Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.height * 0.1,
            vertical: MediaQuery.of(context).size.width * 0.1),
        child: Text(msg,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: (MediaQuery.of(context).size.height+MediaQuery.of(context).size.width)*0.013,
                height: 1.5,
                fontWeight: FontWeight.w400,
                color: AppColors().buttonColor))
      );
}
