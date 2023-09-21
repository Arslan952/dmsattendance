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
      debugShowCheckedModeBanner: false,
      title: 'DMS Attendance App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors().buttonColor),
        useMaterial3: true,
      ),
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()],
      home: const AttendanceScreen(),
    );
  }
}
