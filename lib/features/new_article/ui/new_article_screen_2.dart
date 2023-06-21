import 'package:kashmir_guardian_admin/core/app_colors.dart';
import 'package:kashmir_guardian_admin/features/new_article/get_controllers/new_article_get_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:sizer/sizer.dart';

class NewArticleScreen2 extends StatelessWidget {
  NewArticleScreen2({Key? key}) : super(key: key);

  NewArticleGetController getController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'New Article',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.primary,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            Expanded(
              child: HtmlEditor(
                controller: getController.htmlController, //required
                htmlEditorOptions: const HtmlEditorOptions(
                  hint: "Your text here...",
                ),
                otherOptions: OtherOptions(
                  height: 100.h,
                ),
              ),
            ),
            Divider(
              thickness: 0.5.sp,
              color: AppColors.secondary,
            ),
            SizedBox(
              height: 5.h,
            ),
            Obx(() {
              return getController.showLoader.value
                  ? const CircularProgressIndicator()
                  : FloatingActionButton.extended(
                      onPressed: () {
                        getController.saveArticle();
                      },
                      label: Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 8.sp),
                      ),
                      backgroundColor: AppColors.secondary,
                    );
            }),
            SizedBox(
              height: 5.h,
            ),
          ],
        ));
  }
}
