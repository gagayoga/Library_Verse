import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peminjam_perpustakaan_kelas_b/app/routes/app_pages.dart';

import '../controllers/book_controller.dart';

class BookView extends GetView<BookController> {
  const BookView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double appbarHeight = AppBar().preferredSize.height;
    double toobar = MediaQuery.of(context).padding.top;
    double heightContainer = MediaQuery.of(context).size.height - appbarHeight - toobar;

    return Scaffold(
        appBar: AppBar(
          titleSpacing: -5,
          title: const Image(
            image: AssetImage('assets/images/font_libryverse.png'),
            width: 120.0,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: InkWell(
                onTap: (() => controller.getDataAllBuku()),
                child: const Text(
                  "Refresh",
                  style: TextStyle(
                      color: Color(0xFFFF0000),
                      fontSize: 16.0,
                      fontFamily: 'Poopins',
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
        body: Container(
          width: width,
          height: heightContainer,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                TextFormField(
                  onTap: (){
                    Get.toNamed(Routes.BOOK);
                  },
                  controller: controller.searchController,
                  onChanged: (value){
                    controller.getDataAllBuku();
                  },
                  decoration: InputDecoration(
                      filled: true,
                      prefixIcon:
                      const Icon(Icons.search, color: Color(0xFF6F6F6F)),
                      fillColor: const Color(0xFFB6B3B3).withOpacity(0.4),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xFFB6B3B3), width: 2.0),
                        borderRadius: BorderRadius.circular(30.30),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFFB6B3B3), width: 2.0),
                          borderRadius: BorderRadius.circular(30.30)),
                      hintText: 'What do you want?',
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      hintStyle: const TextStyle(
                          fontFamily: 'Poppins', color: Color(0xFF6F6F6F))),
                ),

                SizedBox(
                  height: height * 0.020,
                ),

                Expanded(child: SingleChildScrollView(child: kontenSemuaBuku())),
              ],
            ),
          ),
        )
    );
  }

  Widget kontenSemuaBuku() {
    return Obx((){
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 3 / 6.7,
        ),
        itemCount: controller.dataSemuaBook.length,
        itemBuilder: (context, index) {
          var buku = controller.dataSemuaBook[index];
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: () {
                Get.toNamed(Routes.DETAILBUKU,
                  parameters: {
                    'id': (buku.bukuID ?? 0).toString(),
                    'judul': (buku.judul!).toString()
                  },
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Image.network(
                      buku.coverBuku.toString(),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            buku.judul!,
                            maxLines: 2,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF5000CA),
                              fontSize: 18.0,
                            ),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),

                          const SizedBox(
                            height: 5,
                          ),

                          FittedBox(
                            child: Text(
                              "Penulis: ${buku.penulis!}",
                              maxLines: 1,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 10.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          const SizedBox(
                            height: 5,
                          ),

                          FittedBox(
                            child: Text(
                              "${ buku.jumlahHalaman!} Halaman",
                              maxLines : 1,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                                fontSize: 12.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          const SizedBox(
                            height: 5,
                          ),

                          // Menampilkan rating di bawah teks penulis
                          buku.rating != null && buku.rating! > 0
                              ? RatingBarIndicator(
                            direction: Axis.horizontal,
                            rating: buku.rating!,
                            itemCount: 5,
                            itemSize: 15,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Color(0xFF5000CA),
                            ),
                          )
                              : RatingBarIndicator(
                            direction: Axis.horizontal,
                            rating: buku.rating!,
                            itemCount: 5,
                            itemSize: 15,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
