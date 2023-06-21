import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:kashmir_guardian_admin/core/app_colors.dart';

import '../get_controllers/new_category_get_controller.dart';

class NewCategoryPage extends StatelessWidget {
  NewCategoryPage({Key? key}) : super(key: key);
  NewCategoryGetController getController = Get.put(NewCategoryGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Create New Category',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.primary,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50.w,
                  child: TextFormField(
                    controller: getController.categoryNameController,
                    decoration: const InputDecoration(
                      labelText: 'Category Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  return getController.showLoader.value
                      ? const CircularProgressIndicator()
                      : FloatingActionButton.extended(
                          heroTag: 'category',
                          backgroundColor: AppColors.secondary,
                          elevation: 4,
                          label: Text(
                            'Create',
                            style:
                                TextStyle(fontSize: 8.sp, color: Colors.white),
                          ),
                          icon: Icon(
                            Icons.add,
                            size: 12.sp,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            getController.createCategory();
                          },
                        );
                }),
              ],
            )
          ],
        ));
  }
}
