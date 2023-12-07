import 'package:f_map/components/routes/routes.dart';
import 'package:f_map/components/routes/routes_name.dart';
import 'package:f_map/pages/map_screen/index.dart';
import 'package:f_map/pages/visual_screen/view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyCLQvHUYc0FtghBYOkURvCBkoShcvvTiQs",
          appId: "1:352198791950:android:7f5d74b59200163e107d5f",
          messagingSenderId: '',
          projectId: "f-map-f3e1e"));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesName.splashScreen,
      // home: ImageDisplay(),
      getPages: AppRoutes.routes,
    );
  }
}
