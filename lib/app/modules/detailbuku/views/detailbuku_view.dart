import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/model/buku/response_detail_buku.dart';
import '../controllers/detailbuku_controller.dart';

class DetailbukuView extends GetView<DetailbukuController> {
  const DetailbukuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Color
    const Color background = Color(0xFFFFFFFF);

    // Size
    final width = MediaQuery
        .of(context)
        .size
        .width;
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final bodyHeight = height - 55;

    return Scaffold(

        appBar: AppBar(
          backgroundColor: background,
          toolbarHeight: 55,
        ),

        body: RefreshIndicator(
          color: const Color(0xFFFF0000),
          onRefresh: () async{
            Future.delayed(
              const Duration(milliseconds: 1500)
            );
            controller.getDataDetailBuku(controller.id);
          },
          child: Container(
            width: width,
            height: bodyHeight,
            color: background,
            child: Stack(
              children: [
                // Detail Buku
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom:85),
                    child: kontenDataDetailBuku(),
                  ),
                ),

                // Row for buttons
                Positioned(
                  bottom: 20,
                  left: 15,
                  right: 15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: floatingButtonPinjam(context, width)),

                      const SizedBox(
                        width: 10,
                      ),

                      // Floating Button
                      floatingButton(context), // Your existing floating button widget
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

  Widget kontenDataDetailBuku() {
    final height = MediaQuery.of(Get.context!).size.height;
    final width = MediaQuery.of(Get.context!).size.width;

    // Color
    const Color backgroundLogin = Color(0xFFFF0000);
    const Color colorText = Color(0xFF000000);
    const Color colorActive = Color(0xFFFFB800);

    return Obx((){
      if (controller.detailBuku.value == null) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 50),
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.black,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(backgroundLogin),
            ),
          ),
        );
      } else {
        var dataBuku = controller.detailBuku.value!.buku;
        var dataKategori = controller.detailBuku.value!.kategori;
        var dataUlasan = controller.detailBuku.value!.ulasan;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.020,
              ),

              Center(
                child: SizedBox(
                  width: width,
                  height: 300,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 250,
                            child: Image.network(
                              dataBuku!.coverBuku!,
                              fit: BoxFit.cover,
                            ),
                          ),

                          SizedBox(
                            height: height * 0.010,
                          ),

                          // Menampilkan rating di bawah teks penulis
                          RatingBarIndicator(
                            rating: dataBuku.rating!,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemSize: 26,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: colorActive,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        width: width * 0.025,
                      ),

                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dataBuku.judul!,
                              maxLines: 2,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                color: colorText,
                                fontSize: 26.0,
                              ),
                              textAlign: TextAlign.start,
                            ),

                            FittedBox(
                              child: Text(
                                "${dataBuku.jumlahHalaman!} Halaman",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: colorText,
                                  fontSize: 20.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),

                            SizedBox(
                              height: height * 0.005,
                            ),

                            FittedBox(
                              child: Text(
                                "Tahun Terbit: ${dataBuku.tahunTerbit!}",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: colorText,
                                  fontSize: 18.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),

                            SizedBox(
                              height: height * 0.015,
                            ),

                            Wrap(
                              children: dataKategori!.map((kategori) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: TextButton(
                                    onPressed: () {
                                      // Tambahkan fungsi yang ingin dijalankan saat tombol ditekan
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: const Color(0xFFFF0000),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    ),
                                    child: Text(
                                      kategori,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white, // Sesuaikan dengan warna yang diinginkan
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),


              SizedBox(
                height: height * 0.030,
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Detail Book",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: colorText,
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  Divider(
                    thickness: 1,
                    color: Colors.grey.withOpacity(0.20),
                  ),

                  SizedBox(
                    height: height * 0.010,
                  ),

                  FittedBox(
                    child: Text(
                      "Author : ${dataBuku.penulis!}",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: colorText,
                        fontSize: 14.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(
                    height: height * 0.010,
                  ),

                  FittedBox(
                    child: Text(
                      "Penerbit: ${dataBuku.penerbit!}",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: colorText,
                        fontSize: 14.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(
                    height: height * 0.010,
                  ),

                  FittedBox(
                    child: Text(
                      "Jenis Buku: ${dataBuku.jenisBuku!}",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: colorText,
                        fontSize: 14.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(
                    height: height * 0.020,
                  ),

                  Text(
                    "Deskripsi Buku:",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: colorText,
                      fontSize: 16.0,
                    ),
                  ),

                  SizedBox(
                    height: height * 0.005,
                  ),

                  Text(
                    dataBuku.deskripsi!,
                    maxLines: 15,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: colorText.withOpacity(0.80),
                      fontSize: 14.0,
                      height: 1.9,
                    ),
                    textAlign: TextAlign.justify,
                  ),

                  SizedBox(
                    height: height * 0.015,
                  ),

                  SizedBox(
                    height: height * 0.025,
                  ),

                  Text(
                    "Review Book",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: colorText,
                      fontSize: 18.0,
                    ),
                  ),

                  Divider(
                    thickness: 1,
                    color: Colors.grey.withOpacity(0.20),
                  ),

                  SizedBox(
                    height: height * 0.010,
                  ),

                  buildUlasanList(dataUlasan),
                ],
              ),
            ],
          ),
        );
      }
    },
    );
  }

  Widget buildUlasanList(List<Ulasan>? ulasanList) {
    final width = MediaQuery.of(Get.context!).size.width;

    return ulasanList != null && ulasanList.isNotEmpty
        ? ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: ulasanList.length,
      itemBuilder: (context, index) {
        Ulasan ulasan = ulasanList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA).withOpacity(0.30),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            width: width,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      width: 35,
                      height: 35,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          'assets/images/foto_profile.png',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.035,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ulasan.users?.username ?? '',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 12),
                        ),

                        const SizedBox(
                          height: 5,
                        ),

                        // Menampilkan rating di bawah teks penulis
                        RatingBarIndicator(
                          direction: Axis.horizontal,
                          rating: ulasan.rating!.toDouble(),
                          itemCount: 5,
                          itemSize: 12,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Color(0xFFFF0000),
                          ),
                        ),

                        const SizedBox(
                          height: 5,
                        ),

                        Text(
                          ulasan.ulasan ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    )
        : Container(
      width: width,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFFF0000),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFFF0000),
          width: 0.5,
        ),
      ),
      child: Text(
        'Belum ada ulasan buku',
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
    );
  }

  Widget floatingButton(BuildContext context) {
    const Color colorActive = Color(0xFFFF0000);

    return Obx(() {
      var detailBuku = controller.detailBuku.value;

      if (detailBuku == null || detailBuku.buku == null) {
        return const SizedBox(); // Atau widget lain sesuai kebutuhan
      } else {
        var dataBuku = detailBuku.buku!;

        return FloatingActionButton(
          onPressed: () {
            if (dataBuku.status == "Tersimpan") {
              return;
            } else {
              controller.addKoleksiBuku(context);
            }
          },
          backgroundColor: colorActive,
          child: FaIcon(
            dataBuku.status == "Tersimpan"
                ? CupertinoIcons.bookmark_fill
                : CupertinoIcons.book_solid,
            color: Colors.white,
            size: 28,
          ),
        );
      }
    });
  }

  Widget floatingButtonPinjam(BuildContext context, double width) {
    const Color colorActive = Color(0xFFFF0000);

    return Obx(() {
      var detailBuku = controller.detailBuku.value;

      if (detailBuku == null || detailBuku.buku == null) {
        return const SizedBox(); // Atau widget lain sesuai kebutuhan
      } else {
        var dataBuku = detailBuku.buku!;

        return SizedBox(
          width: width,
          child: FloatingActionButton(
            onPressed: () {
              if (dataBuku.statusPeminjaman == "Dipinjam") {
                return;
              } else {
                controller.addPeminjamanBuku();
              }
            },
            backgroundColor: colorActive,
            child: Text(
              dataBuku.statusPeminjaman == "Dipinjam" ? "Borrowed" : "Borrow Book",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
        );
      }
    });
  }
}
