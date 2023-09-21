import 'package:dms_attendance_app/export.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height * 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                  height: size.height * 0.2,
                  width: size.width * 0.5,
                  child: SvgPicture.asset("assets/svg/Logos.svg")),
              SizedBox(
                height: size.height * 0.15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
                child: InkWell(
                    onTap: () {
                      Get.to(const MarkCamera());
                    },
                    child: ButtonWidget(
                      title: 'Clock In',
                    )),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              InkWell(
                onTap: () {
                  Get.to(const MarkCamera());
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
                  child: ButtonWidget(
                    title: 'Clock Out',
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.15,
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
                            "Don't have an Account?",
                            style: TextStyle(fontSize: allsize * 0.012),
                          ),
                          TextButton(
                              onPressed: () {
                                Get.to(const LoginScreen());
                              },
                              child: Text("Register Now?",
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
    );
  }
}
