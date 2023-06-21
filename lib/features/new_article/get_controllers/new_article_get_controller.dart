import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kashmir_guardian_admin/core/app_constants.dart';
import 'package:kashmir_guardian_admin/models/publisher_model.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../models/article_model.dart';
import '../../../models/category_model.dart';
import '../../home/ui/home_page.dart';

class NewArticleGetController extends GetxController {
  RxList<ArticleCategoryModel> allCategories = <ArticleCategoryModel>[].obs;
  Rx<ArticleCategoryModel> selectedCategory =
      ArticleCategoryModel(id: '', name: '', categoryNumber: -1).obs;

  RxBool categoryLoader = false.obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController youtubeLinkController = TextEditingController();
  HtmlEditorController htmlController = HtmlEditorController();
  RxString imagePath = ''.obs;

  RxBool showLoader = false.obs;

  Future<void> fetchAllCategories() async {
    categoryLoader.value = true;
    await FirebaseFirestore.instance
        .collection(AppConstants.categories)
        .get()
        .then((value) {
      allCategories.value = value.docs
          .map((e) =>
              ArticleCategoryModel.fromJson(jsonDecode(jsonEncode(e.data()))))
          .toList();
      selectedCategory.value = allCategories.first;
    });
    categoryLoader.value = false;
  }

  @override
  void onInit() {
    fetchAllCategories();
    super.onInit();
  }

  void getImage() {
    ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        imagePath.value = value.path;
      }
    });
  }

  Future<void> saveArticle() async {
    showLoader.value = true;
    if (imagePath.value.isNotEmpty) {
      Uuid uuid = const Uuid();
      String articleId = uuid.v4();
      await htmlController.getText().then((htmlText) async {
        await FirebaseStorage.instance
            .ref()
            .child(AppConstants.articles)
            .child(articleId)
            .putData(
          await XFile(imagePath.value).readAsBytes(),
          SettableMetadata(contentType: 'image/jpeg'),
        )
            .then((p0) async {
          await p0.ref.getDownloadURL().then((downloadUrl) async {
            await FirebaseFirestore.instance
                .collection(AppConstants.publishers)
                .doc(FirebaseAuth.instance.currentUser!.email)
                .get()
                .then((value) async {
              PublisherModel currentPublisher = PublisherModel.fromJson(
                  jsonDecode(jsonEncode(value.data())));
              ArticleModel articleModel = ArticleModel(
                  id: articleId,
                  title: titleController.text,
                  description: descriptionController.text,
                  htmlText: htmlText,
                  date: DateTime.now(),
                  headlineImageUrl: downloadUrl,
                  youtubeLink: youtubeLinkController.text.isEmpty
                      ? null
                      : youtubeLinkController.text,
                  category: selectedCategory.value,
                  publisher: currentPublisher);
              await FirebaseFirestore.instance
                  .collection(AppConstants.articles)
                  .doc(articleId)
                  .set(articleModel.toJson())
                  .then((value) {
                Get.snackbar('Success', 'Article saved successfully',
                    backgroundColor: Colors.green, colorText: Colors.white);
                titleController.clear();
                descriptionController.clear();
                htmlController.clear();
                youtubeLinkController.clear();
                imagePath.value = '';
                Future.delayed(const Duration(seconds: 1), () {
                  Get.offAll(() => HomePage());
                });
              });
            });
          });
        });
      });
    } else {
      Get.snackbar('Error', 'Please select an image for the article',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    showLoader.value = false;
  }
}
