import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kashmir_guardian_admin/core/app_colors.dart';
import 'package:kashmir_guardian_admin/features/new_article/ui/new_article_screen_2.dart';
import 'package:sizer/sizer.dart';

import '../../../models/category_model.dart';
import '../get_controllers/new_article_get_controller.dart';

class NewArticleScreen1 extends StatelessWidget {
  NewArticleScreen1({Key? key}) : super(key: key);

  NewArticleGetController getController = Get.put(NewArticleGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: const Text(
            'New Article',
            style: TextStyle(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.sp),
                  child: SizedBox(
                    width: 50.w,
                    child: Form(
                      key: getController.formKey,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Select Category',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 5.sp),
                              ),
                            ],
                          ),
                          Obx(() {
                            return getController.categoryLoader.value
                                ? const CircularProgressIndicator()
                                : Container(
                                    width: 50.w,
                                    height: 20.sp,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 4.sp, horizontal: 8.sp),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffffffff),
                                      border: Border.all(
                                          color: const Color(0xff808080),
                                          width: 0.5.sp),
                                      borderRadius: BorderRadius.circular(4.sp),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        value: getController
                                            .selectedCategory.value,
                                        items: getController.allCategories.map<
                                                DropdownMenuItem<
                                                    ArticleCategoryModel>>(
                                            (ArticleCategoryModel value) {
                                          return DropdownMenuItem<
                                              ArticleCategoryModel>(
                                            value: value,
                                            child: Text(value.name),
                                          );
                                        }).toList(),
                                        style: TextStyle(
                                          color: const Color(0xff000000),
                                          fontSize: 8.sp,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                        ),
                                        onChanged: (value) {
                                          if (value != null) {
                                            getController
                                                .selectedCategory.value = value;
                                          }
                                        },
                                        elevation: 8,
                                        isExpanded: true,
                                      ),
                                    ));
                          }),
                          SizedBox(
                            height: 4.sp,
                          ),
                          Row(
                            children: [
                              Text(
                                'Choose Title',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 5.sp),
                              ),
                            ],
                          ),
                          TextFormField(
                            controller: getController.titleController,
                            decoration: InputDecoration(
                              hintText: 'Enter Title',
                              hintStyle: TextStyle(
                                color: const Color(0xff808080),
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color(0xff808080),
                                  width: 0.5.sp,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color(0xff808080),
                                  width: 0.5.sp,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            validator: (text) {
                              if (text!.isEmpty) {
                                return 'Title is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 4.sp,
                          ),
                          Row(
                            children: [
                              Text(
                                'Choose Description',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 5.sp),
                              ),
                            ],
                          ),
                          TextFormField(
                            controller: getController.descriptionController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: 'Enter Description',
                              hintStyle: TextStyle(
                                color: const Color(0xff808080),
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color(0xff808080),
                                  width: 0.5.sp,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color(0xff808080),
                                  width: 0.5.sp,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4.sp,
                          ),
                          Row(
                            children: [
                              Text(
                                'Youtube Video ID',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 5.sp),
                              ),
                            ],
                          ),
                          TextFormField(
                            controller: getController.youtubeLinkController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: '(e.g. "z36I4Nqv4JE")',
                              hintStyle: TextStyle(
                                color: const Color(0xff808080),
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color(0xff808080),
                                  width: 0.5.sp,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color(0xff808080),
                                  width: 0.5.sp,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4.sp,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 50.sp,
                                width: 50.sp,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: const Color(0xff808080),
                                      width: 0.2.sp),
                                  borderRadius: BorderRadius.circular(4.sp),
                                ),
                                alignment: Alignment.center,
                                child: Obx(() {
                                  return getController.imagePath.isEmpty
                                      ? Padding(
                                          padding: EdgeInsets.all(8.0.sp),
                                          child: Text(
                                            'Choose Headline Image',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 5.sp),
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4.sp),
                                          child: Stack(
                                            children: [
                                              Image.network(getController
                                                  .imagePath.value),
                                              Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      getController
                                                          .imagePath.value = '';
                                                    },
                                                    icon: const Icon(
                                                      Icons.cancel_rounded,
                                                      color: Colors.white,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        );
                                }),
                              ),
                              FloatingActionButton(
                                heroTag: 'article',
                                onPressed: () {
                                  getController.getImage();
                                },
                                shape: const CircleBorder(),
                                backgroundColor: AppColors.secondary,
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 4.sp,
                          ),
                          Divider(
                            thickness: 0.5.sp,
                            color: AppColors.secondary,
                          ),
                          SizedBox(
                            height: 4.sp,
                          ),
                          FloatingActionButton.extended(
                            heroTag: null,
                            onPressed: () {
                              if (getController.formKey.currentState!
                                  .validate()) {
                                if (getController.imagePath.value.isNotEmpty) {
                                  Get.to(() => NewArticleScreen2());
                                }
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.sp)),
                            label: Text(
                              'Next',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 8.sp),
                            ),
                            backgroundColor: AppColors.primary,
                          ),
                          SizedBox(
                            height: 4.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
