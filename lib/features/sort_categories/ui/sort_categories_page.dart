import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:kashmir_guardian_admin/core/app_constants.dart';

import '../../../models/category_model.dart';

class SortCategoriesPage extends StatelessWidget {
  const SortCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sort Categories'),
          automaticallyImplyLeading: false,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection(AppConstants.categories)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ArticleCategoryModel> categories = snapshot.data!.docs
                    .map((e) => ArticleCategoryModel.fromJson(
                        jsonDecode(jsonEncode(e.data()))))
                    .toList();
                categories.sort(
                    (a, b) => a.categoryNumber.compareTo(b.categoryNumber));
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(categories[index].name, style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w600),),
                                    Text(categories[index].categoryNumber.toString()),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        ArticleCategoryModel previousCategory =
                                            categories[index - 1];
                                        previousCategory = previousCategory.copyWith(
                                            categoryNumber:
                                                previousCategory.categoryNumber + 1);

                                        ArticleCategoryModel currentCategory =
                                            categories[index];
                                        currentCategory = currentCategory.copyWith(
                                            categoryNumber:
                                                currentCategory.categoryNumber - 1);

                                        FirebaseFirestore.instance
                                            .collection(AppConstants.categories)
                                            .doc(previousCategory.id)
                                            .update(previousCategory.toJson());
                                        FirebaseFirestore.instance
                                            .collection(AppConstants.categories)
                                            .doc(currentCategory.id)
                                            .update(currentCategory.toJson());
                                      },
                                      icon: const Icon(Icons.arrow_drop_up_outlined)),
                                  SizedBox(
                                    height: 2.sp,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        ArticleCategoryModel nextCategory =
                                            categories[index + 1];
                                        nextCategory = nextCategory.copyWith(
                                            categoryNumber:
                                                nextCategory.categoryNumber - 1);

                                        ArticleCategoryModel currentCategory =
                                            categories[index];
                                        currentCategory = currentCategory.copyWith(
                                            categoryNumber:
                                                currentCategory.categoryNumber + 1);

                                        FirebaseFirestore.instance
                                            .collection(AppConstants.categories)
                                            .doc(nextCategory.id)
                                            .update(nextCategory.toJson());
                                        FirebaseFirestore.instance
                                            .collection(AppConstants.categories)
                                            .doc(currentCategory.id)
                                            .update(currentCategory.toJson());
                                      },
                                      icon: const Icon(Icons.arrow_drop_down_outlined)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: categories.length,
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
