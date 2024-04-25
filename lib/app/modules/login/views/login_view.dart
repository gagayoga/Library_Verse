import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:peminjam_perpustakaan_kelas_b/app/routes/app_pages.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double appbarHeight = AppBar().preferredSize.height;
    double toobar = MediaQuery.of(context).padding.top;
    double heightContainer = MediaQuery.of(context).size.height - appbarHeight - toobar;

    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Image(
                image: AssetImage('assets/images/font_libryverse.png'),
                width: 120.0,
              ),
              InkWell(
                onTap: () => launchUrl(Uri.parse('https://www,google.com')),
                child: const Text(
                  "Help",
                  style: TextStyle(
                      color: Color(0xFFFF0000),
                      fontSize: 16.0,
                      fontFamily: 'Poopins',
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        // Bagian Body
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: heightContainer,
            child: Form(
                key: controller.formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 11),
                          child: TextFormField(
                            controller: controller.emailController,
                            autocorrect: true,
                            validator: (value) {
                              return EmailValidator.validate(value!)
                                  ? null
                                  : 'Please enter a valid email';
                            },
                            //style: ,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    const Color(0xFFB6B3B3).withOpacity(0.4),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.red, width: 2.0),
                                  borderRadius: BorderRadius.circular(15.15),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 2.0),
                                    borderRadius: BorderRadius.circular(15.15)),
                                hintText: 'Email',
                                hintStyle: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.deepOrange)),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 60, vertical: 11),
                            child: Obx(() => TextFormField(
                                  controller: controller.passwordController,
                                  autocorrect: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                  obscureText: controller.showpassword.value,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color(0xFFB6B3B3)
                                          .withOpacity(0.4),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.red, width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(15.15),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.red, width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(15.15)),
                                      hintText: 'Password',
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 15),
                                      hintStyle: const TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.deepOrange),
                                      suffixIcon: InkWell(
                                        child: Icon(
                                            controller.showpassword.value
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.grey,
                                            size: 15),
                                        onTap: () {
                                          controller.showpassword.value =
                                              !controller.showpassword.value;
                                        },
                                      )),
                                ))),
                        FractionallySizedBox(
                          widthFactor: 0.7,
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 16),
                              child: SizedBox(
                                width: double.infinity,
                                height: 40.40,
                                child: ElevatedButton(
                                    onPressed: () {
                                      controller.login();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFFF0000),
                                    ),
                                    child: Obx(
                                      () => controller.loading.value
                                          ? const CircularProgressIndicator(
                                              color: Color(0xFFFFFFFF),
                                            )
                                          : const Text(
                                              "Login",
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                    )),
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 75),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            width: 350,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(
                                      height: 45.0,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF3D5A98),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: const Icon(
                                          FontAwesomeIcons.facebook,
                                          color: Color(0xFFFFFFFF),
                                          size: 30,
                                        ),
                                      )),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  SizedBox(
                                      height: 45.0,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFFC8C8C8),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: Image.asset(
                                          "assets/images/google.png",
                                          width: 30,
                                        ),
                                      )),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  SizedBox(
                                      height: 45.0,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF000000),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: const Icon(
                                          FontAwesomeIcons.apple,
                                          size: 30,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                      )),
                                ]),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 14)),
                              TextButton(
                                style: TextButton.styleFrom(
                                    textStyle: const TextStyle(fontSize: 14)),
                                onPressed: () =>
                                    Get.offAllNamed(Routes.REGISTER),
                                child: const Text("Register",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }
}
