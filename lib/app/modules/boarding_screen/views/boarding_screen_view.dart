import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:get/get.dart';
import 'package:peminjam_perpustakaan_kelas_b/app/routes/app_pages.dart';


class BoardingScreenView extends StatelessWidget {
  const BoardingScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: OnBoardingSlider(
            finishButtonText: 'Next',
            onFinish: () {
              Get.offAllNamed(Routes.LOGIN);
            },
            finishButtonStyle: FinishButtonStyle(
              backgroundColor: Color(0xFFFF0000),
            ),
            skipTextButton: Text(
              'Skip',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFFFF0000),
                fontWeight: FontWeight.w600,
              ),
            ),
            controllerColor: Colors.grey,
            totalPage: 3,
            headerBackgroundColor: Colors.white,
            pageBackgroundColor: Colors.white,
            centerBackground: true,
            background: [
              Image.asset(
                'assets/images/slide_first.png',
                height: 640,
                alignment: Alignment.center,
              ),
              Image.asset(
                'assets/images/slide_second.png',
                height: 640,
                alignment: Alignment.center,
              ),
              Image.asset(
                'assets/images/slide_third.png',
                height: 640,
                alignment: Alignment.center,
              ),
            ],
            speed: 1.8,
            pageBodies: [
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 480,
                    ),
                    Text(
                      'Easy to read',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFFF0000),
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'ease of reading is a priority, supporting education',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 480,
                    ),
                    Text(
                      'Solution to read all of us',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFFF0000),
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Various kinds of books and articles are here',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 480,
                    ),
                    Text(
                      'Start now!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFFF0000),
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     Text(
                      '"today a reader, tomorrow a leader" -Margaret Fuller.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
