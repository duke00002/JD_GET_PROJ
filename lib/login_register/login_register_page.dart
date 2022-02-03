import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jd_get_proj/login_register/login_register_common.dart';
import 'package:jd_get_proj/login_register/login_register_controller.dart';

class LoginRegisterPage extends StatelessWidget {
  const LoginRegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.white,
            child: Column(children: [
              getHeader(LoginRegisterController.to.closePage,
                  LoginRegisterController.to.callService),
              SizedBox(height: 20.h),
              getLogo(),
              SizedBox(height: 20.h),
              getTextFieldLine(
                  null,
                  "account_or_phone".tr,
                  LoginRegisterController.to.accountOrPhoneController,
                  LoginRegisterController.to.accountOrPhoneFocusNode),
              getTextFieldLine(
                  null,
                  "enter_password".tr,
                  LoginRegisterController.to.pwdController,
                  LoginRegisterController.to.pwdFocusNode,
                  isObscureText: true),
              getForgetRegisterLine(LoginRegisterController.to.doForget,
                  LoginRegisterController.to.doRegister),
              SizedBox(height: 30.h),
              getLoginBtn(LoginRegisterController.to.doLogin)
            ])));
  }
}
