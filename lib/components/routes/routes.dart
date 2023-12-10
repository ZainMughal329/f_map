import 'package:f_map/components/routes/routes_name.dart';
import 'package:f_map/pages/about_us/index.dart';
import 'package:f_map/pages/admin/index.dart';
import 'package:f_map/pages/distance_screens/bindings.dart';
import 'package:f_map/pages/distance_screens/view.dart';
import 'package:f_map/pages/drawer/index.dart';
import 'package:f_map/pages/faq_view/index.dart';
import 'package:f_map/pages/home_screen/index.dart';
import 'package:f_map/pages/map_screen/index.dart';
import 'package:f_map/pages/onboarding_screen/index.dart';
import 'package:f_map/pages/profile/index.dart';
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
    ),GetPage(
      name: RoutesName.profile,
      page: () => ProfileScreen(),
      binding: ProfileBindings(),
      transition: Transition.zoom,
    ),GetPage(
      name: RoutesName.aboutUs,
      page: () => AboutUsScreen(),
      binding: ABoutUsBindings(),
      transition: Transition.zoom,
    ),GetPage(
      name: RoutesName.faq,
      page: () => FAQScreen(),
      binding: FAQBindings(),
      transition: Transition.zoom,
    ),

    GetPage(
      name: RoutesName.adminScreen,
      page: () => AdminScreen(),
      binding: AdminBindings(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: RoutesName.distanceScreen,
      page: () => DistanceView(),
      binding: DistanceScreenBindings(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: RoutesName.drawer,
      page: () => SideMenu(),
      binding: DrawerBindings(),
      transition: Transition.zoom,
    ),
  ];
}
