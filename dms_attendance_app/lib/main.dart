import 'package:dms_attendance_app/resources/app_colors.dart';
import 'package:dms_attendance_app/source/screen/mark_attendance.dart';
import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Add this
  await FaceCamera.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DMS Attendance App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors().buttonColor),
        useMaterial3: true,
      ),
      home: const AttendanceScreen(),
    );
  }
}
