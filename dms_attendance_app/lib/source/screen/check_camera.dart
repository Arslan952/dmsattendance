import 'dart:io';

import 'package:dms_attendance_app/export.dart';

class CheckCamera extends StatefulWidget {
  const CheckCamera({super.key});

  @override
  State<CheckCamera> createState() => _CheckCameraState();
}

class _CheckCameraState extends State<CheckCamera> {
  List<String> capturedImages = ["","","",""]; // To store captured images

  int currentCaptureIndex = 0; // Index to keep track of the current capture direction

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          SmartFaceCamera(
            autoCapture: false, // Disable auto capture initially
            defaultCameraLens: CameraLens.front,
            imageResolution: ImageResolution.ultraHigh,
            showCameraLensControl: false,
            showFlashControl: false,
            captureControlIcon: Icon(Icons.camera_alt, size: allsize * 0.05),
            onCapture: (File? image) {
              if (image != null && currentCaptureIndex < capturedImages.length) {
                setState(() {
                  capturedImages[currentCaptureIndex] = image.path;
                  final directions = ['Front', 'Right', 'Left', 'Up'];
                  ZBotToast.showToastSuccess(message:'${directions[currentCaptureIndex]} Side of Face Done');
                  currentCaptureIndex++; // Move to the next capture direction
                });

                if (currentCaptureIndex == capturedImages.length) {

                }
              } else {
                ZBotToast.showToastError(
                    message: 'Please Take a proper photo of Face');
              }
            },
            messageBuilder: (context, face) {
              // if (face == null) {
              //   return _message('Place your face in the camera');
              // }
              // if (!face.wellPositioned) {
              //   return _message('Center your face in the square');
              // }
              // Display different messages for each capture direction
              if (currentCaptureIndex < capturedImages.length) {
                final directions = ['Front', 'Right', 'Left', 'Up'];
                return _message('Capture ${directions[currentCaptureIndex]} Side of Face');
              }

              return const SizedBox.shrink();
            },
          ),
          // Add a submit button when all images are captured
          if (currentCaptureIndex == capturedImages.length)
            Positioned(
              bottom: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                 Navigator.pop(context,capturedImages);
                },
                child: Text('Submit'),
              ),
            ),
        ],
      ),
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

  // Function to submit the capturedImages array
  void _submitCapturedImages(List<File?> capturedImages) {
    // Handle the submission logic here, e.g., send images to a server
  }
}
