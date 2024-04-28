import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peminjam_perpustakaan_kelas_b/app/component/customImageCarousel.dart';
import 'package:peminjam_perpustakaan_kelas_b/app/component/customSlide.dart';
import 'package:peminjam_perpustakaan_kelas_b/app/data/model/buku/response_book.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
          onRefresh: () async{
            controller.refreshData();
          },
          child: Container(
            child: CustomScrollView(
                  slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              centerTitle: false,
              expandedHeight: 300.0,
              flexibleSpace: const FlexibleSpaceBar(
                background: CustomImageCarousel(),
              ),
            ),
            SliverAppBar(
              backgroundColor: Colors.white,
              pinned: true,
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(30),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: TextFormField(
                      onTap: (){
                        Get.toNamed(Routes.BOOK);
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
                  )),
              // flexibleSpace: const SearchBar(),
            ),
            SliverToBoxAdapter(
              child: customSlide(
                context: Get.context!,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: kontenBukuTerbaru(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: kontenBukuPopular(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: kontenSemuaBuku(),
              ),
            ),
                  ],
                ),
          ),
        ));
  }

  Widget kontenBukuPopular() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          "Most Popular",
          minFontSize: 15,
          maxLines: 1,
          maxFontSize: 25,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GetBuilder<HomeController>(
          builder: (controller) {
            if (controller.popularBooks.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFEA1818)),
                ),
              );
            } else {
              return SizedBox(
                height: 250,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.popularBooks.length,
                    itemBuilder: (context, index) {
                      var buku = controller.popularBooks[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(
                              Routes.DETAILBUKU,
                              parameters: {
                                'id': (buku.bukuID ?? 0).toString(),
                                'judul': (buku.judul!).toString()
                              },
                            );
                          },
                          child: SizedBox(
                            width: 150,
                            height: 230,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: 150,
                                    height: 200,
                                    child: AspectRatio(
                                      aspectRatio: 5 / 6,
                                      child: Image.network(
                                        buku.coverBuku.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FittedBox(
                                        child: Text(
                                          buku.judul!,
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize: 14.0),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      FittedBox(
                                        child: Text(
                                          "Penulis : ${buku.penulis!}",
                                          maxLines: 1,
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize: 10.0),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget kontenBukuTerbaru() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          "Recommended",
          minFontSize: 15,
          maxLines: 1,
          maxFontSize: 25,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GetBuilder<HomeController>(
          builder: (controller) {
            if (controller.newBooks.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFEA1818)),
                ),
              );
            } else {
              return SizedBox(
                height: 250,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.newBooks.length,
                    itemBuilder: (context, index) {
                      var buku = controller.newBooks[index];
                      return InkWell(
                        onTap: () {
                          Get.toNamed(
                            Routes.DETAILBUKU,
                            parameters: {
                              'id': (buku.bukuID ?? 0).toString(),
                              'judul': (buku.judulBuku!).toString()
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SizedBox(
                            width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 150,
                                  height: 200,
                                  child: AspectRatio(
                                    aspectRatio: 4 / 6,
                                    child: Image.network(
                                      buku.coverBuku.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FittedBox(
                                        child: Text(
                                          buku.judulBuku!,
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize: 14.0),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      FittedBox(
                                        child: Text(
                                          "Penulis : ${buku.penerbitBuku!}",
                                          maxLines: 1,
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize: 10.0),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget kontenSemuaBuku() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          "All Book",
          minFontSize: 15,
          maxLines: 1,
          maxFontSize: 25,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(
          height: 20,
        ),

        GetBuilder<HomeController>(builder: (controller) {
          if (controller.allBook.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFEA1818)),
              ),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.allBook.length,
              itemBuilder: (context, index) {
                var kategori = controller.allBook![index].kategoriBuku;
                var bukuList = controller.allBook![index].dataBuku;
                if (bukuList == null || bukuList.isEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          kategori!,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF0000),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Buku $kategori tidak ditemukan di kategori ini',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.3,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          kategori!,
                          style: GoogleFonts.poppins(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: SizedBox(
                        height: 288, // Sesuaikan tinggi container sesuai kebutuhan Anda
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: bukuList!.length,
                          itemBuilder: (context, index) {
                            DataBuku buku = bukuList[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(
                                    Routes.DETAILBUKU,
                                    parameters: {
                                      'id': (buku.bukuID ?? 0).toString(),
                                      'judul': (buku.judul!).toString()
                                    },
                                  );
                                },
                                child: SizedBox(
                                  width: 150,
                                  height: 200,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          SizedBox(
                                            width: 150,
                                            height: 200,
                                            child: AspectRatio(
                                              aspectRatio: 4 / 5,
                                              child: Image.network(
                                                buku.coverBuku.toString(),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 0,
                                            bottom: 0,
                                            right: 0,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.80)),
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 8),
                                          Text(
                                            buku.judul!,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                                fontSize: 14.0),
                                            textAlign: TextAlign.start,
                                          ),
                                          const SizedBox(height: 4),
                                          FittedBox(
                                            child: Text(
                                              "Penulis : ${buku.penulis!}",
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey,
                                                  fontSize: 10.0),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          FittedBox(
                                            child: Text(
                                              "Penerbit : ${buku.penerbit!}",
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey,
                                                  fontSize: 10.0),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          FittedBox(
                                            child: Text(
                                              "${buku.jumlahHalaman!} Halaman",
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey,
                                                  fontSize: 10.0),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        })
      ],
    );
  }
}
