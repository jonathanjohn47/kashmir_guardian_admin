import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kashmir_guardian_admin/core/app_colors.dart';
import 'package:kashmir_guardian_admin/features/auth/ui/sign_in_page.dart';
import 'package:kashmir_guardian_admin/features/new_article/ui/new_article_screen_1.dart';
import 'package:kashmir_guardian_admin/features/new_category/ui/new_category_page.dart';
import 'package:kashmir_guardian_admin/features/sort_categories/ui/sort_categories_page.dart';
import 'package:sizer/sizer.dart';

import '../get_controllers/home_page_get_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  HomePageGetController homePageGetController =
      Get.put(HomePageGetController());

  @override
  Widget build(BuildContext context) {
    List<Widget> gridItems = [
      FloatingActionButton.extended(
        heroTag: 'category',
        elevation: 4,
        label: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.category,
              size: 18.sp,
              color: AppColors.secondary,
            ),
            SizedBox(
              height: 5.sp,
            ),
            Text(
              'Create New Category',
              style: TextStyle(fontSize: 5.sp),
            ),
          ],
        ),
        onPressed: () {
          Get.to(() => NewCategoryPage());
        },
      ),
      FloatingActionButton.extended(
        heroTag: 'article',
        elevation: 4,
        label: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.newspaper,
              size: 18.sp,
              color: AppColors.secondary,
            ),
            SizedBox(
              height: 5.sp,
            ),
            Text(
              'Create New Article',
              style: TextStyle(fontSize: 5.sp),
            ),
          ],
        ),
        onPressed: () {
          Get.to(() => NewArticleScreen1());
        },
      ),
      FloatingActionButton.extended(
        heroTag: 'article',
        elevation: 4,
        label: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shuffle,
              size: 18.sp,
              color: AppColors.secondary,
            ),
            SizedBox(
              height: 5.sp,
            ),
            Text(
              'Sort Categories',
              style: TextStyle(fontSize: 5.sp),
            ),
          ],
        ),
        onPressed: () {
          Get.to(() => const SortCategoriesPage());
        },
      ),
      FloatingActionButton.extended(
        heroTag: 'logout',
        elevation: 4,
        label: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.logout,
              size: 18.sp,
              color: AppColors.secondary,
            ),
            SizedBox(
              height: 5.sp,
            ),
            Text(
              'Log Out',
              style: TextStyle(fontSize: 5.sp),
            ),
          ],
        ),
        onPressed: () {
          FirebaseAuth.instance.signOut().then((value) {
            Get.offAll(() => SignInPage());
          });
        },
      ),
    ];
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Container(
            color: AppColors.primary,
          )),
      body: Padding(
        padding: EdgeInsets.all(16.0.sp),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0.sp),
              child: gridItems[index],
            );
          },
          itemCount: gridItems.length,
        ),
      ),
    );
  }
}
