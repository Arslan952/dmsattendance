// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:dms_attendance_app/resources/app_colors.dart';
import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';

class MarkCamera extends StatefulWidget {
  const MarkCamera({super.key});

  @override
  State<MarkCamera> createState() => _MarkCameraState();
}

class _MarkCameraState extends State<MarkCamera> {
  bool isloading = false;

  Future<void> _showImageDialog(double size) async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isloading = true;
    });
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Attendance Status'),
          content: const Text("Attendance Marked"),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          SmartFaceCamera(
            autoCapture: true,
            defaultCameraLens: CameraLens.front,
            imageResolution: ImageResolution.ultraHigh,
            message: 'Center your face in the square',
            showCameraLensControl: false,
            showFlashControl: false,
            onCapture: (File? image) {
              setState(() {
                isloading = true;
              });
              _showImageDialog(allsize);
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
          isloading == true
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
}
