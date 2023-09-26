import 'package:dms_attendance_app/services/navigationserice.dart';
import 'package:dms_attendance_app/source/screen/sitescreen.dart';

import 'export.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Add this
  await FaceCamera.initialize();
  runApp(
    ChangeNotifierProvider(
      create: (_) => RegisterUser(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: NavigationService.navigatorKey, // set property
      debugShowCheckedModeBanner: false,
      title: 'DMS Attendance App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors().buttonColor),
        useMaterial3: true,
      ),
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()],
      home: const SiteScreen(),
    );
  }
}
