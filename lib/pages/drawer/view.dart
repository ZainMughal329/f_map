import 'package:f_map/components/reuseable/text_widget.dart';
import 'package:f_map/components/routes/routes_name.dart';
import 'package:f_map/pages/drawer/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '../../utils/rive_assets.dart';
import '../../utils/rive_utils.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DrawerSideMenuController());
    RiveAsset selectedMenu = sideMenu.first;
    return Scaffold(
      body: Container(
        width: 288,
        // height: 900,
        color: Color(0xff17203a),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white24,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              title: TextWidget(title:
                controller.state.userName.value.capitalizeFirst.toString(),
                textColor: Colors.white,
              ),
              subtitle: TextWidget(title:
              controller.state.email.value.toString(),
                textColor: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 24, top: 32, bottom: 16),
              child: Text(
                "Browse".toUpperCase(),
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),
            ...sideMenu.map(
              (menu) => SideMenuTile(
                menu: menu,
                press: () {
                  menu.input!.change(true);
                  Future.delayed(Duration(seconds: 1), () {
                    setState(() {
                      selectedMenu = menu;
                    });
                    menu.input!.change(false);
                    Get.toNamed(menu.routeName);

                    // Navigator.pop(context);
                  });
                },
                riveOnIt: (artboard) {
                  StateMachineController con = RiveUtls.getRiveController(
                      artboard,
                      stateMachineName: menu.stateMachineName);
                  menu.input = con.findSMI("active") as SMIBool;
                },
                isActive: selectedMenu == menu,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SideMenuTile extends StatelessWidget {
  const SideMenuTile(
      {super.key,
      required this.menu,
      required this.press,
      required this.riveOnIt,
      required this.isActive});

  final RiveAsset menu;
  final VoidCallback press;
  final ValueChanged<Artboard> riveOnIt;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 700,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 24),
            child: Divider(
              color: Colors.white24,
              height: 1,
            ),
          ),
          Stack(
            children: [
              AnimatedPositioned(
                duration: Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                height: 56,
                width: isActive ? 288 : 0,
                left: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff6792ff),
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                ),
              ),
              ListTile(
                onTap: press,
                leading: SizedBox(
                  height: 40,
                  width: 40,
                  child: RiveAnimation.asset(
                    menu.src,
                    artboard: menu.artboard,
                    onInit: riveOnIt,
                  ),
                ),
                title: Text(
                  menu.title,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

List<RiveAsset> sideMenu = [
  RiveAsset('assets/riveAssets/icons.riv', RoutesName.homeScreen,
      artboard: "HOME", stateMachineName: "HOME_interactivity", title: "Home"),

  RiveAsset('assets/riveAssets/icons.riv',RoutesName.profile,
      artboard: "USER",
      stateMachineName: "USER_Interactivity",
      title: "Profile"),
  RiveAsset('assets/riveAssets/icons.riv',RoutesName.aboutUs,
      artboard: "LIKE/STAR",
      stateMachineName: "STAR_Interactivity",
      title: "About us"),
  RiveAsset('assets/riveAssets/icons.riv',RoutesName.faq,
      artboard: "CHAT", stateMachineName: "CHAT_Interactivity", title: "FAQ's"),



];
