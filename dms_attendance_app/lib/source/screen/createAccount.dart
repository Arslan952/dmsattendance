import 'dart:convert';

import 'package:dms_attendance_app/resources/app_colors.dart';
import 'package:dms_attendance_app/source/screen/camera_page.dart';
import 'package:dms_attendance_app/source/widget/buttonWidget.dart';
import 'package:dms_attendance_app/source/widget/formfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height * 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.02),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_sharp,
                        color: AppColors().iconColor,
                        size: allsize * 0.02,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.06,
                ),
                Text(
                  "Create Account",
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: allsize * 0.022),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
                  child: FormFieldWidget(
                    hint: 'Enter your name',
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
                  child: FormFieldWidget(
                    hint: 'Enter your Email',
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
                  child: FormFieldWidget(
                    hint: 'Phone Number',
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
                  child: FormFieldWidget(
                    hint: 'Enter Your PIN',
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                InkWell(
                  onTap: () {
                    Get.to(TakePictureScreen());
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.15),
                    child: ButtonWidget(
                      title: 'Camera',
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                InkWell(
                  onTap: () async {
                    await detectFaces(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTarV2pVgCLZiqkc5vGB8ms3ZM3JhsVaBIUlfZTt-zvCQ&s");
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.15),
                    child: ButtonWidget(
                      title: 'Save',
                    ),
                  ),
                ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.asset("assets/images/Waves.jpg"),
                    Positioned(
                        bottom: size.height * 0.05,
                        child: Row(
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(fontSize: allsize * 0.012),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text("Login",
                                    style: TextStyle(
                                        fontSize: allsize * 0.012,
                                        color: AppColors().textbuttonColor,
                                        decoration: TextDecoration.underline)))
                          ],
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> detectFaces(String imageUrl) async {
  const String endpoint =
      'https://faceapioandb.cognitiveservices.azure.com/face/v1.0/detect';
  final String subscriptionKey =
      '91150867c57d4db8a1bc18fc1d535ae0'; // Replace with your Azure Face API subscription key

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Ocp-Apim-Subscription-Key': subscriptionKey,
  };

  final Map<String, dynamic> body = {
    'url': imageUrl,
  };

  final http.Response response = await http.post(
    Uri.parse('$endpoint?returnFaceId=false&detectionModel=detection_03'),
    headers: headers,
    body: jsonEncode(body),
  );

  if (response.statusCode == 200) {
    final List<dynamic> detectedFaces = jsonDecode(response.body);
    print('Detected ${detectedFaces.length} face(s) in the image.');
  } else {
    print('Error: ${response.statusCode}');
    print('Response: ${response.body}');
  }
}
