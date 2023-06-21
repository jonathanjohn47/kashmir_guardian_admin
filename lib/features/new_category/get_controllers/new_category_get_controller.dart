import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kashmir_guardian_admin/core/app_constants.dart';
import 'package:uuid/uuid.dart';

import '../../../models/category_model.dart';

class NewCategoryGetController extends GetxController {
  TextEditingController categoryNameController = TextEditingController();

  RxBool showLoader = false.obs;

  Future<void> createCategory() async {
    FirebaseFirestore.instance
        .collection(AppConstants.categories)
        .get()
        .then((categoriesQuerySnapshot) async {
      Uuid uuid = const Uuid();
      String categoryId = uuid.v4();

      ArticleCategoryModel articleCategoryModel = ArticleCategoryModel(
          id: categoryId,
          name: categoryNameController.text,
          categoryNumber: categoriesQuerySnapshot.docs.length);

      showLoader.value = true;
      await FirebaseFirestore.instance
          .collection(AppConstants.categories)
          .doc(categoryId)
          .set(articleCategoryModel.toJson())
          .then((value) {
        showLoader.value = false;
        Get.snackbar('Success', 'Category created successfully',
            backgroundColor: Colors.green, colorText: Colors.white);
        Future.delayed(const Duration(seconds: 2), () {
          Get.back();
          Get.back();
        });
      });
    });
  }
}
