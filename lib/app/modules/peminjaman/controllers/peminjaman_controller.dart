import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peminjam_perpustakaan_kelas_b/app/data/provider/storage_provider.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/peminjaman/response_detail_peminjaman.dart';
import '../../../data/model/peminjaman/response_history_peminjaman.dart';
import '../../../data/provider/api_provider.dart';

class PeminjamanController extends GetxController with StateMixin{

  var historyPeminjaman = RxList<DataHistory>();
  String idUser = StorageProvider.read(StorageKey.idUser);

  var detailPeminjaman = Rxn<DetailPeminjaman>();

  // Post Ulasan
  double ratingBuku= 0;
  final loadingUlasan = false.obs;
  final loadingPinjam = false.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController ulasanController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getDataPeminjaman();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getDataPeminjaman() async {
    change(null, status: RxStatus.loading());

    try {
      final responseHistoryPeminjaman = await ApiProvider.instance().get(
          '${Endpoint.pinjamBuku}/$idUser');

      if (responseHistoryPeminjaman.statusCode == 200) {
        final ResponseHistoryPeminjaman responseHistory = ResponseHistoryPeminjaman.fromJson(responseHistoryPeminjaman.data);

        if (responseHistory.data!.isEmpty) {
          historyPeminjaman.clear();
          change(null, status: RxStatus.empty());
        } else {
          historyPeminjaman.assignAll(responseHistory.data!);
          change(null, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal Memanggil Data"));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final responseData = e.response?.data;
        if (responseData != null) {
          final errorMessage = responseData['Message'] ?? "Unknown error";
          change(null, status: RxStatus.error(errorMessage));
        }
      } else {
        change(null, status: RxStatus.error(e.message));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> getDataDetailPeminjaman(String? idPinjam) async {
    detailPeminjaman.value == null;
    change(null, status: RxStatus.loading());

    try {
      final responseDetailBuku = await ApiProvider.instance().get(
          '${Endpoint.detailPeminjaman}/$idPinjam');

      if (responseDetailBuku.statusCode == 200) {
        final ResponseDetailPeminjaman responseDetailPeminjaman = ResponseDetailPeminjaman.fromJson(responseDetailBuku.data);

        if (responseDetailPeminjaman.data == null) {
          detailPeminjaman.value == null;
          change(null, status: RxStatus.empty());
        } else {
          detailPeminjaman(responseDetailPeminjaman.data);
          change(null, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal Memanggil Data"));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final responseData = e.response?.data;
        if (responseData != null) {
          final errorMessage = responseData['message'] ?? "Unknown error";
          change(null, status: RxStatus.error(errorMessage));
        }
      } else {
        change(null, status: RxStatus.error(e.message));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  postUlasanBuku(String buku, String namaBuku) async {
    loadingUlasan(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        int ratingBukuInt = ratingBuku.round();
        final response = await ApiProvider.instance().post(Endpoint.ulasanBuku,
            data: dio.FormData.fromMap(
                {
                  "Rating": ratingBukuInt,
                  "BukuID": buku,
                  "Ulasan": ulasanController.text.toString()
                }
            )
        );
        if (response.statusCode == 201) {
          Navigator.of(Get.context!).pop();
          Get.snackbar("Success", "Ulasan Buku $namaBuku berhasil di simpan", backgroundColor: Colors.green,
              colorText: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
          );
          ulasanController.text = '';
        } else {
          Get.snackbar(
              "Sorry",
              "Ulasan buku gagal di simpan, Coba kembali",
              backgroundColor: Colors.red,
              colorText: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
          );
        }
      }
      loadingUlasan(false);
    } on dio.DioException catch (e) {
      loadingUlasan(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          Get.snackbar("Sorry", "${e.response?.data['Message']}",
              backgroundColor: Colors.red, colorText: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
          );
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red,
            colorText: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
        );
      }
    } catch (e) {
      loadingUlasan(false);
      Get.snackbar(
          "Error", e.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
      );
    }
  }

  Future<void> showUlasan(String namaBuku, String buku) async {
    return ArtSweetAlert.show(
        context: Get.context!,
        artDialogArgs: ArtDialogArgs(
            title: "Review Book",
            getTitleSize: 24,
            confirmButtonText: "Send Review",
            showCancelBtn: false,
            confirmButtonColor: Colors.deepOrange,
            dialogPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            customColumns: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  width: double.infinity,
                  color: const Color(0xFFF5F5F5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        Text(
                          'Review Book $namaBuku',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                        ),

                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),

                              Center(
                                child: RatingBar.builder(
                                  allowHalfRating: false,
                                  itemCount: 5,
                                  minRating: 1,
                                  initialRating: 5,
                                  direction: Axis.horizontal,
                                  itemSize: 50,
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Color(0xFFFD5B35),
                                  ),
                                  onRatingUpdate: (double value) {
                                    ratingBuku = value;
                                  },
                                ),
                              ),

                              const SizedBox(
                                height: 20,
                              ),

                              TextFormField(
                                controller: ulasanController,
                                autocorrect: true,
                                maxLines: 2,
                                validator: (value) {
                                  if(value!.isEmpty){
                                    return 'Please input review book here';
                                  }
                                  return null;
                                },
                                //style: ,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                    const Color(0xFFB6B3B3).withOpacity(0.4),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 2.0),
                                      borderRadius: BorderRadius.circular(15.15),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.red, width: 2.0),
                                        borderRadius: BorderRadius.circular(15.15)),
                                    hintText: 'Review Book',
                                    hintStyle: const TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.deepOrange)),
                              ),

                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
            onConfirm: () {
              postUlasanBuku(buku, namaBuku);
          },
        ),
    );
  }

  updatePeminjaman(String peminjamanID, String asal) async {
    loadingPinjam(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      var response;
      if (asal == "booking"){
        response = await ApiProvider.instance().patch(
            '${Endpoint.updatePeminjaman}booking/$peminjamanID');
      }else{
        response = await ApiProvider.instance().patch(
            '${Endpoint.updatePeminjaman}$peminjamanID');
      }

      if (response.statusCode == 200) {
        ArtSweetAlert.show(
            context: Get.context!,
            artDialogArgs: ArtDialogArgs(
              title: "Success",
              text: "Buku berhasil dikembalikan",
            )
        );
        Navigator.of(Get.context!).pop();
        getDataPeminjaman();
      } else {
        Fluttertoast.showToast(
          msg: "Buku gagal dikembalikan",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xFFF5F5F5),
          textColor: Colors.black,
        );
      }
      loadingPinjam(false);
    } on DioException catch (e) {
      loadingPinjam(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          Fluttertoast.showToast(
            msg: e.response?.data?['Message'] ?? "Terjadi kesalahan",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: const Color(0xFFF5F5F5),
            textColor: Colors.black,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: e.message ?? "Terjadi kesalahan",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xFFF5F5F5),
          textColor: Colors.black,
        );
      }
    } catch (e) {
      loadingPinjam(false);
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color(0xFFF5F5F5),
        textColor: Colors.black,
      );
    }
  }

  void showkonfirmasiPeminjaman(String idPeminjaman, String asal) async{
    ArtDialogResponse response = await ArtSweetAlert.show(
        barrierDismissible: false,
        context: Get.context!,
        artDialogArgs: ArtDialogArgs(
            denyButtonText: "Belum",
            title: "Konfirmasi Peminjaman Buku",
            text: "Apakah buku Anda sudah di ambil di perpustakaan?",
            confirmButtonText: "Sudah",
            type: ArtSweetAlertType.question
        )
    );

    if(response==null) {
      return;
    }

    if(response.isTapConfirmButton) {
      updatePeminjaman(idPeminjaman, asal);
      return null;
    }
  }
}
