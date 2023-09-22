import 'dart:io';

import 'package:dms_attendance_app/export.dart';

class CheckCamera extends StatefulWidget {
  const CheckCamera({super.key});

  @override
  State<CheckCamera> createState() => _CheckCameraState();
}

class _CheckCameraState extends State<CheckCamera> {
  bool spark = false;
  List<String> capturedImages = ["", "", "", ""]; // To store captured images
  final directions = ['Front', 'Right', 'Left', 'Up'];
  int currentCaptureIndex =
      0; // Index to keep track of the current capture direction

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SmartFaceCamera(
              autoCapture: false, // Disable auto capture initially
              defaultCameraLens: CameraLens.front,
              imageResolution: ImageResolution.ultraHigh,
              showCameraLensControl: false,
              showFlashControl: false,
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
              onCapture: (File? image) {
                setState(() {
                  spark = true;
                });
                Future.delayed(const Duration(milliseconds: 70)).then((value) => {
                      setState(() {
                        spark = false;
                      })
                    });
                if (image != null &&
                    currentCaptureIndex < capturedImages.length) {
                  setState(() {
                    capturedImages[currentCaptureIndex] = image.path;
                    final directions = ['Front', 'Right', 'Left', 'Up'];
                    ZBotToast.showToastSuccess(
                        message:
                            '${directions[currentCaptureIndex]} Side of Face Done');
                    currentCaptureIndex++; // Move to the next capture direction
                    // Show the "Image Captured" effect
                  });

                  if (currentCaptureIndex == capturedImages.length) {
                    // All images captured, you can perform further actions here
                  }
                } else {
                  ZBotToast.showToastError(
                      message: 'Please Take a proper photo of Face');
                }
              },
              // messageBuilder: (context, face) {
              //   // if (face == null) {
              //   //   return _message('Place your face in the camera');
              //   // }
              //   // if (!face.wellPositioned) {
              //   //   return _message('Center your face in the square');
              //   // }
              //   // Display different messages for each capture direction
              //
              //
              //   return const SizedBox.shrink();
              // },
            ),
            // Add a submit button when all images are captured
            if (currentCaptureIndex < capturedImages.length)
              Container(
                color: const Color(0xfff5e5e5),
                height: size.height*0.06,
                width: size.width*1,
                child: _message('Capture ${directions[currentCaptureIndex]} Side of Face',
                    size),
              ),
            currentCaptureIndex == capturedImages.length
                ? Positioned(
                    bottom: 20,
                    right: 20,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, capturedImages);
                      },
                      child: const Text('Submit'),
                    ),
                  )
                : Container(),

            // "Image Captured" effect overlay
            if (spark)
              Container(
                height: size.height * 1,
                color: Colors.black,
              )
          ],
        ),
      ),
    );
  }

  Widget _message(String msg, Size size) => Padding(
    padding:EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.015),
    child: Text(msg,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: (MediaQuery.of(context).size.height +
                    MediaQuery.of(context).size.width) *
                0.013,
            height: 1.5,
            fontWeight: FontWeight.w400,
            color: Colors.black)),
  );
}
