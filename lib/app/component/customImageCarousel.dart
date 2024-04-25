import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomImageCarousel extends StatelessWidget {
  const CustomImageCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, _) => ImageSlideshow(
        width: double.infinity,
        height: 200,
        initialPage: 0,
        indicatorColor: Colors.blue,
        indicatorBackgroundColor: Colors.grey,
        onPageChanged: (value) {
        },
        autoPlayInterval: 3000,
        isLoop: true,
        children: [
          Image.asset(
            'assets/images/1.png',
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/images/2.png',
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/images/3.png',
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
