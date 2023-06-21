import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kashmir_guardian_admin/features/auth/ui/sign_in_page.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_colors.dart';
import '../get_controllers/sign_up_get_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  SignUpGetController getController = Get.put(SignUpGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 55.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        getController.getImage();
                      },
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Obx(
                            () => CircleAvatar(
                              radius: 60,
                              backgroundImage: getController
                                      .imagePath.value.isNotEmpty
                                  ? NetworkImage(getController.imagePath.value)
                                  : null,
                              child: getController.imagePath.value.isEmpty
                                  ? const Icon(Icons.add_a_photo, size: 60)
                                  : null,
                            ),
                          ),
                          Obx(() {
                            return Visibility(
                              visible: getController.imagePath.value.isNotEmpty,
                              child: Positioned(
                                right: 0,
                                top: 0,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.cancel_rounded,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    getController.imagePath.value = '';
                                  },
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: getController.nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.5.sp,
                          ),
                          borderRadius: BorderRadius.circular(4.sp),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: getController.emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.5.sp,
                          ),
                          borderRadius: BorderRadius.circular(4.sp),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16.0),
                    Obx(() => TextFormField(
                          controller: getController.passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.5.sp,
                              ),
                              borderRadius: BorderRadius.circular(4.sp),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                getController.passwordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                getController.passwordVisible.toggle();
                              },
                            ),
                          ),
                          obscureText: !getController.passwordVisible.value,
                        )),
                    const SizedBox(height: 16.0),
                    Obx(() => TextFormField(
                          controller: getController.confirmPasswordController,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.5.sp,
                              ),
                              borderRadius: BorderRadius.circular(4.sp),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                getController.passwordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                getController.passwordVisible.toggle();
                              },
                            ),
                          ),
                          obscureText: !getController.passwordVisible.value,
                        )),
                    const SizedBox(height: 16.0),
                    Obx(() {
                      return getController.showLoader.value
                          ? const SizedBox(
                              width: 20.0,
                              height: 20.0,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(AppColors.primary),
                              ),
                            )
                          : FloatingActionButton.extended(
                              backgroundColor: AppColors.primary,
                              onPressed: () {
                                getController.savePublisher();
                              },
                              label: const Text(
                                'Submit',
                                style: TextStyle(color: Colors.white),
                              ));
                    }),
                    SizedBox(
                      height: 16.sp,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Click to sign in as a publisher '),
                        TextButton(
                          onPressed: () {
                            Get.off(() => SignInPage());
                          },
                          child: const Text('HERE',
                              style: TextStyle(
                                  color: Colors.cyan,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
