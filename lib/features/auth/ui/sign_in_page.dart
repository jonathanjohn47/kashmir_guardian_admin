import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kashmir_guardian_admin/core/app_colors.dart';
import 'package:kashmir_guardian_admin/features/auth/ui/sign_up_screen.dart';
import 'package:sizer/sizer.dart';

import '../get_controllers/sign_in_get_controller.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  SignInGetController getController = Get.put(SignInGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign In'),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 55.w),
                child: Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: getController.emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.sp))),
                        ),
                      ),
                      SizedBox(
                        height: 8.sp,
                      ),
                      Obx(() {
                        return TextFormField(
                          controller: getController.passwordController,
                          obscureText: !getController.passwordVisible.value,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.sp))),
                            suffixIcon: IconButton(
                              onPressed: () {
                                getController.passwordVisible.value =
                                    !getController.passwordVisible.value;
                              },
                              icon: getController.passwordVisible.value
                                  ? const Icon(
                                      Icons.visibility_off,
                                      color: Colors.cyan,
                                    )
                                  : const Icon(Icons.remove_red_eye),
                            ),
                          ),
                        );
                      }),
                      SizedBox(
                        height: 8.sp,
                      ),
                      FloatingActionButton.extended(
                          backgroundColor: AppColors.primary,
                          onPressed: () {
                            getController.signIn();
                          },
                          label: const Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white),
                          )),
                      SizedBox(
                        height: 32.sp,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Click to register as a new publisher '),
                          TextButton(
                            onPressed: () {
                              Get.off(() => SignUpScreen());
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
                )),
          ],
        ));
  }
}
