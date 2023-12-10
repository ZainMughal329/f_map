import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_map/components/models/location_model.dart';
import 'package:f_map/pages/home_screen/index.dart';
import 'package:f_map/pages/splash_screen/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  final state = HomeState();

  @override
  void onInit() {
    // TODO: implement onInit
    state.btnAnimationController = OneShotAnimation(
      "active",
      autoplay: false,
    );
    fetchUserName();
    super.onInit();
  }

  storeDataInFirebase() async {
    await FirebaseFirestore.instance
        .collection('location')
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .set(
          LocationModel(
            id: FirebaseAuth.instance.currentUser!.uid.toString(),
                  userName: state.userName.value,
                  vehicleType: state.vehicleType,
                  vehicleNum: state.modelNum,
                  lat: 0.0,
                  lang: 0.0, speed: 0.0)
              .toJson(),
        )
        .then((value) {
      print('success');
    }).onError((error, stackTrace) {
      print('error');
    });
  }

  fetchUserName() async {
    final snap = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    if(snap.exists){
      final data = snap.data() as Map<String,dynamic>;
      final name = data['userName'];
      state.userName.value = name.toString();

    }
  }
}
