import 'package:f_map/components/routes/routes_name.dart';
import 'package:f_map/pages/home_screen/index.dart';
import 'package:f_map/pages/map_screen/index.dart';
import 'package:f_map/pages/onboarding_screen/index.dart';
import 'package:f_map/pages/signup_screen/index.dart';
import 'package:f_map/pages/signup_screen/pages/login/index.dart';
import 'package:f_map/pages/splash_screen/index.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final List<GetPage> routes = [
    GetPage(
      name: RoutesName.splashScreen,
      page: () => SplashScreen(),
      binding: SplashBindings(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: RoutesName.onBoardScreen,
      page: () => OnBoardScreen(),
      binding: OnBoardBindings(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: RoutesName.signUpScreen,
      page: () => SignUpScreen(),
      binding: SignUpBindings(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: RoutesName.loginScreen,
      page: () => LoginScreen(),
      binding: LoginBindings(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: RoutesName.homeScreen,
      page: () => HomeScreen(),
      binding: HomeBindings(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: RoutesName.mapScreen,
      page: () => MapScreen(),
      binding: MapBindings(),
      transition: Transition.zoom,
    ),
  ];
}
