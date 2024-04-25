import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:peminjam_perpustakaan_kelas_b/app/data/provider/storage_provider.dart';
import 'package:peminjam_perpustakaan_kelas_b/app/routes/app_pages.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    String statusUser = StorageProvider.read(StorageKey.status);

    Future.delayed(
      const Duration(milliseconds: 3000),
        ((){
          if (statusUser == "logged"){
            Get.offAllNamed(Routes.LAYOUT);
          }else{
            Get.offAllNamed(Routes.BOARDING_SCREEN);
          }
        })
    );
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: 
          Lottie.asset('assets/images/splash.json', fit: BoxFit.cover),
        ),
      )
    );
  }
}
