import 'dart:io';

import 'package:dms_attendance_app/export.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({
    super.key,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController pin = TextEditingController();
  List<String> image = [];

  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<RegisterUser>(context,listen: false);
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return Scaffold(
        body: Consumer<RegisterUser>(builder: (context, provider, child) {
      return Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                // height: size.height * 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    image.isNotEmpty
                        ? Container()
                        : Container(
                            height: size.height * 0.06,
                          ),
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
                          fontWeight: FontWeight.w700,
                          fontSize: allsize * 0.022),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.15),
                      child: FormFieldWidget(
                        hint: 'Enter your name',
                        controller: namecontroller,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.15),
                      child: FormFieldWidget(
                        hint: 'Enter your Email',
                        controller: email,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.15),
                      child: FormFieldWidget(
                        hint: 'Phone Number',
                        controller: number,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.15),
                      child: FormFieldWidget(
                        hint: 'Enter Your PIN',
                        controller: pin,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    image.isNotEmpty
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.05),
                            child: GridView.builder(
                              itemCount: image.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return Center(
                                  child: Image.file(
                                    File(image[index]),
                                    width: size.width * 0.28,
                                    fit: BoxFit.fill,
                                  ),
                                );
                              },
                            ),
                          )
                        : Container(),
                    image.isNotEmpty
                        ? SizedBox(
                            height: size.height * 0.02,
                          )
                        : Container(),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.15),
                      child: ButtonWidget(
                        title: 'Camera',
                        ontap: () async {
                          final image_list = await Get.to(() => CheckCamera());
                          setState(() {
                            image=image_list;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.15),
                      child: ButtonWidget(
                        ontap: () {
                          if(namecontroller.text=="")
                            {
                              ZBotToast.showToastError(message: "Please Enter Name");
                            }
                          else if(image.isEmpty)
                            {
                              ZBotToast.showToastError(message: 'Please Capture Images');
                            }
                          else{
                            print(image);
                            print(namecontroller.text);
                            provider.sendUserRegister(image, namecontroller.text);
                          }
                        },
                        title: 'Save',
                      ),
                    ),
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image.asset("assets/images/Waves.jpg"),
                        // Positioned(
                        //     bottom: size.height * 0.05,
                        //     child: Row(
                        //       children: [
                        //         Text(
                        //           "Already have an account?",
                        //           style: TextStyle(fontSize: allsize * 0.012),
                        //         ),
                        //         TextButton(
                        //             onPressed: () {},
                        //             child: Text("Login",
                        //                 style: TextStyle(
                        //                     fontSize: allsize * 0.012,
                        //                     color: AppColors().textbuttonColor,
                        //                     decoration:
                        //                         TextDecoration.underline)))
                        //       ],
                        //     )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          provider.changeindicator == true
              ? Container(
                  height: size.height * 1,
                  color: Colors.black26,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container()
        ],
      );
    }));
  }
}

