// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:dms_attendance_app/export.dart';


class MarkCamera extends StatefulWidget {
  const MarkCamera({super.key});

  @override
  State<MarkCamera> createState() => _MarkCameraState();
}

class _MarkCameraState extends State<MarkCamera> {
  bool isloading = false;



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
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
              showFlashControl: false,
              onCapture: (File? image) async{
                await markattendanceprovider.MarkAttendance(image!.path,context);
              },
              messageBuilder: (context, face) {
                if (face == null) {
                  return _message('Place your face in the camera');
                }
                if (!face.wellPositioned) {
                  return _message('Center your face in the square');
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
                child: CircularProgressIndicator(
                  color: AppColors().buttonColor,
                ),
              ),
            )
                : Container()
          ],
        );
      })

    );
  }

  Widget _message(String msg) => Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.height * 0.1,
            vertical: MediaQuery.of(context).size.width * 0.1),
        child: Text(msg,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                height: 1.5,
                fontWeight: FontWeight.bold,
                color: AppColors().buttonColor)),
      );
}
