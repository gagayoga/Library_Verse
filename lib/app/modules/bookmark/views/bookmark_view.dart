import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peminjam_perpustakaan_kelas_b/app/routes/app_pages.dart';

import '../controllers/bookmark_controller.dart';

class BookmarkView extends GetView<BookmarkController> {
  const BookmarkView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                onTap: (() => controller.getData()),
                child: const Text(
                  "Refresh",
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
      body: Center(
        child: RefreshIndicator(
          onRefresh: () async{
            await controller.getData();
          },
          child: SizedBox(
            width: width,
              height: heightContainer,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.020,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: kontenKoleksiBuku(),
                    ),
                    SizedBox(
                      height: height * 0.020,
                    ),
                  ],
                ),
              )
          ),
        ),
      )
    );
  }

  Widget kontenKoleksiBuku() {
    const Color background = Colors.redAccent;
    const Color borderColor = Color(0xFF424242);

    return SizedBox(
      child: Obx((){
        if (controller.dataBookmarkBook.isEmpty) {
          return Center(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: borderColor.withOpacity(0.2),
                    width: 0.3,
                  )
              ),
              child: Center(
                child: Text(
                  'Bookmarks is empty!',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }
          return
            SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    children:
                    List.generate(
                      controller.dataBookmarkBook.length,
                          (index) {
                        var dataKoleksi = controller.dataBookmarkBook[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            width: MediaQuery.of(Get.context!).size.width,
                            decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5).withOpacity(0.60),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            height: 150,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Gambar di sebelah kiri
                                Flexible(
                                  flex:3,
                                  child: InkWell(
                                    onTap: (){
                                      Get.toNamed(Routes.DETAILBUKU,
                                        parameters: {
                                          'id': (dataKoleksi.bukuID ?? 0).toString(),
                                          'judul': (dataKoleksi.judul!).toString()
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: 150,
                                      decoration : BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.05),
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            offset: const Offset(0, 5), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      // Lebar gambar 40% dari layar
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: AspectRatio(
                                          aspectRatio: 2 / 2,
                                          child: Image.network(
                                            dataKoleksi.coverBuku.toString(),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  width: 5,
                                ),

                                Flexible(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          dataKoleksi.judul!,
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFF260534),
                                            fontSize: 18.0,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          dataKoleksi.deskripsi!,
                                          style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 12.0,
                                          ),
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "Penulis : ${dataKoleksi.penulis!}",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            fontSize: 12.0,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Flexible(
                                  flex: 1,
                                  child: Center(
                                    child: InkWell(
                                      onTap: (){
                                        controller.deleteKoleksiBook(dataKoleksi.bukuID.toString(), Get.context!);
                                      },
                                      child: const Icon(
                                        CupertinoIcons.trash_fill,
                                        color: Color(0xFFFF0000),
                                        size: 26,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )
                )
            );
        }),
      );
  }
}
