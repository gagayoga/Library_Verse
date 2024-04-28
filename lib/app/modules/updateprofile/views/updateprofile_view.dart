import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peminjam_perpustakaan_kelas_b/app/component/custom_textfield.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/updateprofile_controller.dart';

class UpdateprofileView extends GetView<UpdateprofileController> {
  const UpdateprofileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double appbarHeight = AppBar().preferredSize.height;
    double heightbar = MediaQuery.of(context).padding.top;
    double heightContainer = MediaQuery.of(context).size.height - appbarHeight - heightbar;
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
                    color: Colors.red,
                    fontSize: 16.0,
                    fontFamily: 'Poopins',
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: heightContainer,
          child: kontenUpdateProfile(),
        ),
      )
    );
  }

  Widget kontenUpdateProfile(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),

            Text(
              "Update Profile",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            CustomTextFormField(
                controller: controller.namalengkapController,
                label: "nama lengkap",
                obsureText: false
            ),

            const SizedBox(
              height: 15,
            ),

            CustomTextFormField(
                controller: controller.usernameController,
                label: "username",
                obsureText: false
            ),

            const SizedBox(
              height: 15,
            ),

            CustomTextFormField(
                controller: controller.emailController,
                label: "email",
                obsureText: false
            ),

            const SizedBox(
              height: 15,
            ),

            CustomTextFormField(
                controller: controller.bioController,
                label: "bio",
                obsureText: false
            ),

            const SizedBox(
              height: 15,
            ),

            CustomTextFormField(
                controller: controller.teleponController,
                label: "telepon",
                obsureText: false
            ),

            const SizedBox(
              height: 15,
            ),

            Obx(()=>CustomTextFormField(
              controller: controller.passwordController,
              label: "password",
              surficeIcon: InkWell(
                child: Icon(
                    controller
                        .isPasswordHidden.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                    size: 15),
                onTap: () {
                  controller
                      .isPasswordHidden.value =
                  !controller
                      .isPasswordHidden.value;
                },
              ),
              obsureText: controller.isPasswordHidden.value,
            )),

            const SizedBox(
              height: 45,
            ),

            SizedBox(
              width: double.infinity,
              height: 50.50,
              child: ElevatedButton(
                  onPressed: () {
                    controller.updateProfilePost();
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
                      "Update Profile",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight:
                          FontWeight.bold,
                          color: Colors.white),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
