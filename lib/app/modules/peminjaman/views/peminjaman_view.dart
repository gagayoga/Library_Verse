import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/peminjaman_controller.dart';

class PeminjamanView extends GetView<PeminjamanController> {
  const PeminjamanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
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
                onTap: (() => controller.getDataPeminjaman()),
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
      body: SizedBox(
        width: width,
        height: heightContainer,
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: kontenKoleksiBuku(context),
        )),
      ),
    );
  }

  Widget kontenKoleksiBuku(BuildContext context) {
    const Color background = Colors.redAccent;
    const Color borderColor = Color(0xFF424242);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      child: Obx((){
        if (controller.historyPeminjaman.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
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
                  'History borrow books is empty!',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        } else {
          return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    children:
                    List.generate(
                      controller.historyPeminjaman.length,
                          (index) {
                        var dataKoleksi = controller.historyPeminjaman[index];

                        DateTime tanggalPinjamDateTime = DateTime.parse(dataKoleksi.tanggalPinjam!);
                        DateTime? tanggalKembaliDateTime;
                        if (dataKoleksi.tanggalKembali != 'Belum dikembalikan') {
                          tanggalKembaliDateTime = DateTime.parse(dataKoleksi.tanggalKembali!);
                        }

                        Duration? durasiPeminjaman = tanggalKembaliDateTime?.difference(tanggalPinjamDateTime);

                        int? lamaHari = durasiPeminjaman?.inDays;

                        if(dataKoleksi.isNull){
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
                        return Dismissible(
                          key: Key(dataKoleksi.kodePeminjaman!),
                          direction: DismissDirection.endToStart,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              width: MediaQuery.of(Get.context!).size.width,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF5F5F5).withOpacity(0.60),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              height: 200,
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Gambar di sebelah kiri
                                      InkWell(
                                        onTap: (){
                                          if(dataKoleksi.status == "Selesai"){
                                            controller.showUlasan(dataKoleksi.judulBuku.toString(), dataKoleksi.bukuId.toString());
                                          }else if(dataKoleksi.status == "Dipinjam"){
                                            controller.getDataDetailPeminjaman(dataKoleksi.peminjamanID.toString());
                                            showModalBottomSheet(
                                                context: Get.context!,
                                                builder: (BuildContext context){
                                                  return buktiPeminjaman(width, height);
                                                }
                                            );
                                          }else if(dataKoleksi.status == "Booking"){
                                            controller.showkonfirmasiPeminjaman(dataKoleksi.peminjamanID.toString(), "booking");
                                          }
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

                                      const SizedBox(
                                        width: 10,
                                      ),

                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                dataKoleksi.kodePeminjaman!,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.deepOrange,
                                                  fontSize: 24.0,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                dataKoleksi.judulBuku!,
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.0,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                "Tanggal Pinjam : ${dataKoleksi.tanggalPinjam!}",
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  fontSize: 12.0,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                "Deadline Pinjam : ${dataKoleksi.deadline!}",
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  fontSize: 12.0,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                lamaHari == null ? "Lama Pinjam : - Hari" : "Lama Pinjam : $lamaHari Hari",
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  fontSize: 12.0,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),

                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: dataKoleksi.status == 'Booking' ? Colors.yellowAccent : dataKoleksi.status == 'Dipinjam' ? Colors.deepOrange : Colors.greenAccent,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Statuse Borrowed : ${dataKoleksi.status}",
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onDismissed: (direction) {
                            // Hapus item dari daftar UI
                            controller.historyPeminjaman.removeAt(index);

                            // Tampilkan snackbar untuk memberi tahu pengguna bahwa item telah dihapus
                            ScaffoldMessenger.of(Get.context!).showSnackBar(
                              SnackBar(
                                content: const Text('History borrowed book dismissed'),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {
                                    // Kembalikan item ke daftar jika pengguna membatalkan tindakan
                                    controller.historyPeminjaman.insert(index, dataKoleksi);
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                    )
                )
            );
        }
      },
      ),
    );
  }

  Widget buktiPeminjaman(double width, double height){
    return Obx((){
      if(controller.detailPeminjaman.value == null){
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.black,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF0000)),
            ),
          ),
        );
      }else{
        var dataPeminjaman = controller.detailPeminjaman.value;
        return SingleChildScrollView(
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFF5F5F5)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    dataPeminjaman!.kodePeminjaman.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFFFF0000),
                      letterSpacing: -0.3,
                      fontSize: 30.0,
                    ),
                    textAlign: TextAlign.start,
                    softWrap: true,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Divider(
                      color: Colors.grey,
                      height: 2,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            "Nama Peminjam :",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              letterSpacing: -0.3,
                              fontSize: 16.0,
                            ),
                            textAlign: TextAlign.start,
                            softWrap: true,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            dataPeminjaman.username.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              letterSpacing: -0.3,
                              fontSize: 18.0,
                            ),
                            textAlign: TextAlign.end,
                            softWrap: true,
                          ),
                        ),

                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex:2,
                          child: Text(
                            "Tanggal Peminjaman :",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              letterSpacing: -0.3,
                              fontSize: 16.0,
                            ),
                            textAlign: TextAlign.start,
                            softWrap: true,
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Text(
                            dataPeminjaman.tanggalPinjam.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              letterSpacing: -0.3,
                              fontSize: 16.0,
                            ),
                            textAlign: TextAlign.end,
                            softWrap: true,
                          ),
                        ),

                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex:2,
                          child: Text(
                            "Deadline Peminjaman :",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              letterSpacing: -0.3,
                              fontSize: 16.0,
                            ),
                            textAlign: TextAlign.start,
                            softWrap: true,
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Text(
                            dataPeminjaman.deadline.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              letterSpacing: -0.3,
                              fontSize: 16.0,
                            ),
                            textAlign: TextAlign.end,
                            softWrap: true,
                          ),
                        ),

                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex:2,
                          child: Text(
                            "Tanggal Pengembalian :",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              letterSpacing: -0.3,
                              fontSize: 16.0,
                            ),
                            textAlign: TextAlign.start,
                            softWrap: true,
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Text(
                            dataPeminjaman.tanggalKembali.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              letterSpacing: -0.3,
                              fontSize: 16.0,
                            ),
                            textAlign: TextAlign.end,
                            softWrap: true,
                          ),
                        ),

                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            "Judul Buku :",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              letterSpacing: -0.3,
                              fontSize: 16.0,
                            ),
                            textAlign: TextAlign.start,
                            softWrap: true,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            dataPeminjaman.judulBuku.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              letterSpacing: -0.3,
                              fontSize: 16.0,
                            ),
                            textAlign: TextAlign.end,
                            softWrap: true,
                          ),
                        ),

                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Divider(
                      color: Colors.grey,
                      height: 2,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Note :",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                              fontSize: 16
                          ),
                        ),

                        const SizedBox(
                          height: 5,
                        ),

                        Text(
                          "Kembalikan buku sesuai jadwal yang tertera di bukti peminjaman",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              letterSpacing: -0.3,
                              fontSize: 14
                          ),
                        ),

                        const SizedBox(
                          height: 25,
                        ),

                        SizedBox(
                          width: double.infinity,
                          height: 50.50,
                          child: ElevatedButton(
                              onPressed: () {
                                controller.updatePeminjaman(dataPeminjaman.peminjamanID.toString(), "dipinjam");
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF0000),
                              ),
                              child: Obx(
                                    () => controller.loadingPinjam.value
                                    ? const CircularProgressIndicator(
                                  color: Color(0xFFFFFFFF),
                                )
                                    : const Text(
                                  "Kembalikan Buku",
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
                  )
                ],
              ),
            ),
          ),
        );
      }
    });
  }

}
