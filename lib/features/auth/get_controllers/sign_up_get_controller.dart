import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kashmir_guardian_admin/core/app_constants.dart';
import 'package:kashmir_guardian_admin/features/home/ui/home_page.dart';
import 'package:kashmir_guardian_admin/models/publisher_model.dart';
import 'package:image_picker/image_picker.dart';

class SignUpGetController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  RxBool passwordVisible = false.obs;
  RxBool confirmPasswordVisible = false.obs;

  RxString imagePath = ''.obs;

  RxBool showLoader = false.obs;

  void getImage() {
    ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        imagePath.value = value.path;
      }
    });
  }

  Future<void> savePublisher() async {
    showLoader.value = true;
    if (nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: AppConstants.emailForTemporaryLogin,
                password: AppConstants.passwordForTemporaryLogin)
            .then((value) async {
          await FirebaseStorage.instance
              .ref()
              .child(
                  'publisher_profile_pics/${DateTime.now().millisecondsSinceEpoch}')
              .putData(
                await XFile(imagePath.value).readAsBytes(),
                SettableMetadata(contentType: 'image/jpeg'),
              )
              .then((value) async {
            final downloadUrl = await value.ref.getDownloadURL();
            await FirebaseFirestore.instance
                .collection(AppConstants.publishers)
                .doc(emailController.text)
                .set(PublisherModel(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        profilePicLink: downloadUrl,
                        dateCreated: DateTime.now().toIso8601String())
                    .toJson())
                .then((value) async {
              await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim())
                  .then((value) async {
                Get.offAll(() => HomePage());
              });
            });
          });
        });
      }
    }
    showLoader.value = false;
  }
}
