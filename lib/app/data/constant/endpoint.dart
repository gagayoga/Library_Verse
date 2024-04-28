class Endpoint {
  static const String baseUrlApi =
      //"http://127.0.0.1:8000/api/users/";
      "http://127.0.0.1:8000/api/users/";

  // Authenticated
  static const String register = "${baseUrlApi}registrasi";
  static const String login = "${baseUrlApi}login";
  static const String logout = "${baseUrlApi}logout";
  static const String getDataProfile = "${baseUrlApi}get-profile";
  static const String updateProfile = "${baseUrlApi}update/profile";

  // Book
  static const String buku = "${baseUrlApi}buku";
  static const String bukuSearch = baseUrlApi;
  static const String bukuNew = "${baseUrlApi}buku/new";
  static const String detailBuku = "${baseUrlApi}buku/detail";
  static const String bukuPopular = "${baseUrlApi}popular/buku";

  // Ulasan Buku
  static const String ulasanBuku = "${baseUrlApi}ulasan";

  // Bookmark
  static const String bookmark = "${baseUrlApi}koleksi";
  static const String deleteBookmark = "${baseUrlApi}";

  // Peminjaman
  static const String pinjam = "${baseUrlApi}pinjam";
  static const String pinjamBuku = "${baseUrlApi}pinjam";
  static const String detailPeminjaman = "${baseUrlApi}detail/pinjam";
  static const String updatePeminjaman = "${baseUrlApi}update-peminjaman/";
}