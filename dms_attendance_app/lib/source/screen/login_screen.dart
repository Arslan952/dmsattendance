import 'package:dms_attendance_app/resources/app_colors.dart';
import 'package:dms_attendance_app/source/screen/createAccount.dart';
import 'package:dms_attendance_app/source/widget/buttonWidget.dart';
import 'package:dms_attendance_app/source/widget/formfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                  height: size.height * 0.1,
                ),
                Text(
                  "Login Account",
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: allsize * 0.022),
                ),
                SizedBox(
                  height: size.height * 0.08,
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
                    hint: 'Enter your Password',
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                InkWell(
                  onTap: () {
                    Get.to(const RegisterScreen());
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.15),
                    child: ButtonWidget(
                      title: 'Login',
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.18,
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
