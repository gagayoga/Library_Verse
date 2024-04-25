import 'package:get/get.dart';
import 'package:peminjam_perpustakaan_kelas_b/app/modules/bookmark/controllers/bookmark_controller.dart';
import 'package:peminjam_perpustakaan_kelas_b/app/modules/home/controllers/home_controller.dart';
import 'package:peminjam_perpustakaan_kelas_b/app/modules/peminjaman/controllers/peminjaman_controller.dart';
import 'package:peminjam_perpustakaan_kelas_b/app/modules/profile/controllers/profile_controller.dart';

import '../../article/controllers/article_controller.dart';
import '../../book/controllers/book_controller.dart';
import '../controllers/layout_controller.dart';

class LayoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LayoutController>(
      () => LayoutController(),
    );
    Get.lazyPut<HomeController>(
          () => HomeController(),
    );
    Get.lazyPut<BookController>(
          () => BookController(),
    );
    Get.lazyPut<BookmarkController>(
          () => BookmarkController(),
    );
    Get.lazyPut<ArticleController>(
          () => ArticleController(),
    );
    Get.lazyPut<PeminjamanController>(
          () => PeminjamanController(),
    );
    Get.lazyPut<ProfileController>(
          () => ProfileController(),
    );
  }
}
