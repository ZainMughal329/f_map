import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_map/components/routes/routes.dart';
import 'package:f_map/components/routes/routes_name.dart';
import 'package:f_map/components/session_controller/session_controller.dart';
import 'package:f_map/pages/profile/index.dart';
import 'package:f_map/pages/splash_screen/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import '../../components/models/user_model.dart';
import '../../components/reuseable/snackbar.dart';

class ProfileController extends GetxController {
  final state = ProfileState();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    // TODO: implement onInit

    fetchUserName();
    super.onInit();
  }


  fetchUserName() async {
    final snap = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    if(snap.exists){
      final data = snap.data() as Map<String,dynamic>;
      final name = data['userName'];
      final phone = data['email'];
      final url = data[''];
      state.userName.value = name.toString();
      state.email.value = phone.toString();

    }
  }

  void setLogoutLoading(bool val){
    state.logoutLoading.value = val;
  }

  Future<void> handleLogout() async{
    setLogoutLoading(true);
    try{
      await auth.signOut().then((value){
        // SessionController().userId = null;
        setLogoutLoading(false);
        Get.offAllNamed(RoutesName.loginScreen);
        Snackbar.showSnackBar('Logout', 'Successfully', Icons.done_outline_rounded);
      }).onError((error, stackTrace){
        setLogoutLoading(false);
        Snackbar.showSnackBar('Error', error.toString(), Icons.error_outline);
      });
    }catch(e){
      setLogoutLoading(false);
      Snackbar.showSnackBar('Error', e.toString(), Icons.error_outline);
    }
  }

  setLoading(value) {
    state.loading.value = value;
  }

  Future<UserModel> getUserDataForUpdate(String id) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: id)
        .get();
    final userData = snapshot.docs.map((e) => UserModel.fromJson(e)).single;
    return userData;
  }

  getUsersData() async {
    final id = auth.currentUser!.uid.toString();
    if (id != '') {
      return await getUserDataForUpdate(id);
    } else {
      Get.snackbar('Error', 'Something went wrong');
    }
  }

  final picker = ImagePicker();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  XFile? _image;

  XFile? get image => _image;

  Future pickedImageFromGallery(
      BuildContext context, UserModel userModel) async {
    final pickedImage =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedImage != null) {
      _image = XFile(pickedImage.path);
      uploadImage(context, userModel);
      update();
    }
  }

  //
  Future pickedImageFromCamera(
      BuildContext context, UserModel userModel) async {
    final pickedImage =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if (pickedImage != null) {
      _image = XFile(pickedImage.path);
      uploadImage(context, userModel);
      update();
    }
  }

  void showImage(context, userModel) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 130,
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                ListTile(
                  onTap: () {
                    print('inside');
                    pickedImageFromCamera(context, userModel);
                    print('insideqw21');

                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.camera),
                  title: Text('Camera'),
                ),
                ListTile(
                  onTap: () {
                    pickedImageFromGallery(context, userModel);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.image),
                  title: Text('Gallery'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future uploadImage(BuildContext context, UserModel userModel) async {
    // setLoading(true);
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref('/profileImage' + DateTime.now().toString());
    firebase_storage.UploadTask uploadTask =
    storageRef.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);

    state.userProfileImage = await storageRef.getDownloadURL();

    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid.toString())
        .update({
      'photoUrl': state.userProfileImage.toString(),
    }).then((value) {
      // setLoading(false);
      Get.snackbar('Congrats', 'Update successfull');
      _image = null;
    }).onError((error, stackTrace) {
      // setLoading(false);
      Get.snackbar('Error is', error.toString());
    });
  }

  // for updating user
  updateUserData(UserModel user) async {
    setLoading(true);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .update(
      user.toJson(),
    )
        .then((value) {
      setLoading(false);
      Snackbar.showSnackBar('Update', 'Successfully Updated', Icons.done_all);
    });
  }

  updateUser(UserModel user) async {
    await updateUserData(user);
  }
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserData() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .snapshots();
  }

}