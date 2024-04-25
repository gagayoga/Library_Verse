import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peminjam_perpustakaan_kelas_b/app/data/provider/storage_provider.dart';
import 'package:peminjam_perpustakaan_kelas_b/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    String usernameUser = StorageProvider.read(StorageKey.username);
    String emailUser = StorageProvider.read(StorageKey.email);

    return Scaffold(
      body:  Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              CircularProfileAvatar(
          //                  'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRWtMDksH9GzFdMinyAkGbtLJNx6xynLETTNN5akjxirL3QD5Rj',
                errorWidget: (context, url, error) => Container(
                  child: Icon(Icons.error),
                ),
                placeHolder: (context, url) => Container(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ),
                radius: 90,
                backgroundColor: Colors.redAccent,
                borderWidth: 1,
                   initialsText: Text(
                     "Addd",
                     style: TextStyle(fontSize: 40, color: Colors.white),
                   ),
                borderColor: Colors.grey,
                imageFit: BoxFit.fitHeight,
                elevation: 5.0,
                onTap: () {
                  print('adil');
                },
                cacheImage: true,
                showInitialTextAbovePicture: false,
              ),

              const SizedBox(
                height: 15,
              ),

              Text(
                usernameUser,
                style: const TextStyle(
                    fontFamily: 'Poppins',fontSize: 20,fontWeight: FontWeight.w700,color: Colors.black),
              ),

              const SizedBox(
                  height: 5,
              ),

              Text(
                emailUser,
                style: const TextStyle(
                    fontFamily: 'Poppins',fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black),
              ),

              const SizedBox(
                  height: 50
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xFFD9D9D9)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: InkWell(
                        onTap: (){},
                           child : Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               Icon(Icons.person,
                               size: 22,
                               color: Colors.black),
                               Text(
                                 "Account",style: TextStyle(
                                   fontFamily: 'Poppins',fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black),),
                             ],
                           ),
                        ),
                    ),
                  ),
                  SizedBox(
                    height: 6
                  ),
                  Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFFD9D9D9)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: InkWell(
                        onTap: (){},
                        child : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.notifications,
                                size: 22,
                                color: Colors.black),
                            Text(
                              "Notifications",style: TextStyle(
                                fontFamily: 'Poppins',fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 6
                  ),
                  Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFFD9D9D9)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: InkWell(
                        onTap: (){},
                        child : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.workspace_premium,
                                size: 22,
                                color: Color(0xFFFFD600)),
                            Text(
                              "Try Membership!",style: TextStyle(
                                fontFamily: 'Poppins',fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 20
                  ),
                  Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFFD9D9D9)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: InkWell(
                        onTap: (){},
                        child : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.history_outlined,
                                size: 22,
                                color: Colors.black),
                            Text(
                              "History",style: TextStyle(
                                fontFamily: 'Poppins',fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 6
                  ),
                  Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFFD9D9D9)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: InkWell(
                        onTap: (){},
                        child : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.access_time_filled_outlined,
                                size: 22,
                                color: Colors.black),
                            Text(
                              "Screen time",style: TextStyle(
                                fontFamily: 'Poppins',fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 6
                  ),
                  Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFFD9D9D9)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: InkWell(
                        onTap: (){},
                        child : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.info_rounded,
                                size: 22,
                                color: Colors.black),
                            Text(
                              "History",style: TextStyle(
                                fontFamily: 'Poppins',fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 6
                  ),
                  Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFFD9D9D9)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: InkWell(
                        onTap: (){},
                        child : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.settings,
                                size: 22,
                                color: Colors.black),
                            Text(
                              "Settings",style: TextStyle(
                                fontFamily: 'Poppins',fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 6
                  ),
                  Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFFD9D9D9)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: InkWell(
                        onTap: (){
                          controller.logout();
                        },
                        child : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.logout,
                                size: 22,
                                color: Colors.red),
                            Text(
                              "Log Out",style: TextStyle(
                                fontFamily: 'Poppins',fontSize: 14,fontWeight: FontWeight.w500,color: Colors.red),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
