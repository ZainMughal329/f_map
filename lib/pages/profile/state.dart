import 'package:get/get.dart';

class ProfileState{

  RxString userName = ''.obs;
  RxString email = ''.obs;
  RxString photoUrl = ''.obs;

  RxBool logoutLoading = false.obs;
  String userProfileImage = '';
  RxBool loading = false.obs;
}