import 'package:get/get.dart';
import 'package:peminjam_perpustakaan_kelas_b/app/modules/article/controllers/article_controller.dart';
import 'package:peminjam_perpustakaan_kelas_b/app/modules/book/controllers/book_controller.dart';
import 'package:peminjam_perpustakaan_kelas_b/app/modules/login/controllers/login_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<BookController>(
          () => BookController(),
    );
    Get.lazyPut<ArticleController>(
          () => ArticleController(),
    );
  }
}
