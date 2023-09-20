// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../resources/app_colors.dart';
import '../../utils/zbotToast.dart';

class TakePictureScreen extends StatefulWidget {
  static String route = "/multiImage";
  late CameraDescription? camera;

  TakePictureScreen({
    super.key,
    this.camera,
  });

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  Future<void>? _initializeControllerFuture;
  List<String> items = [];

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
    initializeCamera();
  }

  initializeCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    final firstCamera = cameras.last;
    setState(() {
      widget.camera = firstCamera;
      _controller = CameraController(
        firstCamera,
        enableAudio: false,
        ResolutionPreset.ultraHigh,
      );
      _initializeControllerFuture = _controller.initialize();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            size: allsize * 0.02 // This isn't performing any changes
            ),
        toolbarHeight: size.height * 0.1,
        title: Text(
          'Take a picture',
          style: TextStyle(
              color: AppColors().buttonColor,
              fontSize: allsize * 0.015,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors().white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(size.width * 0.3, size.height * 0.06),
                backgroundColor: AppColors().buttonColor,
              ),
              onPressed: () => {
                if (items.isEmpty)
                  {ZBotToast.showToastError(message: "No Images Selected")}
                else
                  {Navigator.pop(context, items)}
              },
              child: Text(
                "Submit Images",
                style:
                    TextStyle(color: Colors.white, fontSize: allsize * 0.011),
              ),
            ),
          )
        ],
      ),
      body: _initializeControllerFuture != null
          ? Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.7,
                      width: size.width * 1,
                      child: FutureBuilder<void>(
                        future: _initializeControllerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return CameraPreview(
                              _controller,
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: Image.file(
                                  File(items[index]),
                                  width: size.width * 0.4,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                right: size.height * 0.01,
                                top: size.height * 0.01,
                                child: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 15,
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          items.removeAt(index);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.delete_forever,
                                        size: 15,
                                      ),
                                      color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const Divider(height: 0),
                        itemCount: null == items ? 0 : items.length,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: size.height * 0.2,
                  left: size.width * 0.03,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: allsize * 0.02,
                    child: Center(
                      child: IconButton(
                          onPressed: () async {
                            try {
                              await _initializeControllerFuture;
                              final image = await _controller.takePicture();
                              if (!mounted) return;
                              setState(() {
                                items.add(image.path);
                              });
                            } catch (e) {
                             debugPrint(e.toString());
                            }
                          },
                          icon: Icon(
                            Icons.camera_alt_rounded,
                            size: allsize * 0.02,
                            color: AppColors().buttonColor,
                          )),
                    ),
                  ),
                ),
                Positioned(
                  bottom: size.height * 0.2,
                  right: size.width * 0.03,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: allsize * 0.02,
                    child: Center(
                      child: IconButton(
                          onPressed: () {
                            if (items.isEmpty) {
                              ZBotToast.showToastError(
                                  message: "No Images Selected");
                            } else {
                              Navigator.pop(context, items);
                            }
                            print("Submitted Successfully");
                          },
                          icon: Icon(
                            Icons.check,
                            size: allsize * 0.02,
                            color: AppColors().buttonColor,
                          )),
                    ),
                  ),
                ),
              ],
            )
          : SizedBox(
              height: size.height * 1,
              width: size.width * 1,
              child: const Center(child: CircularProgressIndicator())),
    );
  }
}
