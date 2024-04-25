/// Status : 200
/// Message : "Berhasil Get Koleksi"
/// data : [{"BukuID":2,"Deskripsi":"Wind Breaker menceritakan kisah tentang Jay Jay, seorang siswa SMA yang terkenal nakal dan suka berkelahi. Suatu hari, dia bertemu dengan trio pengendara sepeda motor bernama Wind Breaker, yang terdiri dari Bum, Min-soo, dan Yo-han. Jay Jay terkesan dengan keahlian mereka dan memutuskan untuk bergabung dengan klub mereka.0","CoverBuku":"http://192.168.4.95:8000/storage/images/coverbook/Detektif Conan.png","Judul":"Detektif Conan","Penulis":"Syoung Youn Kwon","Penerbit":"Naver Webtoon","TahunTerbit":"2013","JumlahHalaman":"438","Rating":5,"Total_ulasan":1,"JumlahRating":5,"JumlahPeminjam":0,"Kategori":["Novel"]},{"BukuID":1,"Deskripsi":"Wind Breaker menceritakan kisah tentang Jay Jay, seorang siswa SMA yang terkenal nakal dan suka berkelahi. Suatu hari, dia bertemu dengan trio pengendara sepeda motor bernama Wind Breaker, yang terdiri dari Bum, Min-soo, dan Yo-han. Jay Jay terkesan dengan keahlian mereka dan memutuskan untuk bergabung dengan klub mereka.0","CoverBuku":"http://192.168.4.95:8000/storage/images/coverbook/Gadis Kretek.png","Judul":"Gadis Kretek","Penulis":"Syoung Youn Kwon","Penerbit":"Naver Webtoon","TahunTerbit":"2013","JumlahHalaman":"438","Rating":5,"Total_ulasan":2,"JumlahRating":10,"JumlahPeminjam":0,"Kategori":["Novel"]},{"BukuID":3,"Deskripsi":"Wind Breaker menceritakan kisah tentang Jay Jay, seorang siswa SMA yang terkenal nakal dan suka berkelahi. Suatu hari, dia bertemu dengan trio pengendara sepeda motor bernama Wind Breaker, yang terdiri dari Bum, Min-soo, dan Yo-han. Jay Jay terkesan dengan keahlian mereka dan memutuskan untuk bergabung dengan klub mereka.0","CoverBuku":"http://192.168.4.95:8000/storage/images/coverbook/Atomic Habits.png","Judul":"Atomic Habits","Penulis":"Syoung Youn Kwon","Penerbit":"Naver Webtoon","TahunTerbit":"2013","JumlahHalaman":"438","Rating":0,"Total_ulasan":0,"JumlahRating":0,"JumlahPeminjam":0,"Kategori":["ensiklopedia"]},{"BukuID":4,"Deskripsi":"Wind Breaker menceritakan kisah tentang Jay Jay, seorang siswa SMA yang terkenal nakal dan suka berkelahi. Suatu hari, dia bertemu dengan trio pengendara sepeda motor bernama Wind Breaker, yang terdiri dari Bum, Min-soo, dan Yo-han. Jay Jay terkesan dengan keahlian mereka dan memutuskan untuk bergabung dengan klub mereka.0","CoverBuku":"http://192.168.4.95:8000/storage/images/coverbook/Monster.png","Judul":"Monster","Penulis":"Syoung Youn Kwon","Penerbit":"Naver Webtoon","TahunTerbit":"2013","JumlahHalaman":"438","Rating":0,"Total_ulasan":0,"JumlahRating":0,"JumlahPeminjam":0,"Kategori":["manga","ensiklopedia"]}]

class ResponseBookmarkBook {
  ResponseBookmarkBook({
    this.status,
    this.message,
    this.data,});

  ResponseBookmarkBook.fromJson(dynamic json) {
    status = json['Status'];
    message = json['Message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DataBookmark.fromJson(v));
      });
    }
  }
  int? status;
  String? message;
  List<DataBookmark>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    map['Message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// BukuID : 2
/// Deskripsi : "Wind Breaker menceritakan kisah tentang Jay Jay, seorang siswa SMA yang terkenal nakal dan suka berkelahi. Suatu hari, dia bertemu dengan trio pengendara sepeda motor bernama Wind Breaker, yang terdiri dari Bum, Min-soo, dan Yo-han. Jay Jay terkesan dengan keahlian mereka dan memutuskan untuk bergabung dengan klub mereka.0"
/// CoverBuku : "http://192.168.4.95:8000/storage/images/coverbook/Detektif Conan.png"
/// Judul : "Detektif Conan"
/// Penulis : "Syoung Youn Kwon"
/// Penerbit : "Naver Webtoon"
/// TahunTerbit : "2013"
/// JumlahHalaman : "438"
/// Rating : 5
/// Total_ulasan : 1
/// JumlahRating : 5
/// JumlahPeminjam : 0
/// Kategori : ["Novel"]

class DataBookmark {
  DataBookmark({
    this.bukuID,
    this.deskripsi,
    this.coverBuku,
    this.judul,
    this.penulis,
    this.penerbit,
    this.tahunTerbit,
    this.jumlahHalaman,
    this.rating,
    this.totalUlasan,
    this.jumlahRating,
    this.jumlahPeminjam,
    this.kategori,});

  DataBookmark.fromJson(dynamic json) {
    bukuID = json['BukuID'];
    deskripsi = json['Deskripsi'];
    coverBuku = json['CoverBuku'];
    judul = json['Judul'];
    penulis = json['Penulis'];
    penerbit = json['Penerbit'];
    tahunTerbit = json['TahunTerbit'];
    jumlahHalaman = json['JumlahHalaman'];
    rating = json['Rating'].toDouble();
    totalUlasan = json['Total_ulasan'];
    jumlahRating = json['JumlahRating'];
    jumlahPeminjam = json['JumlahPeminjam'];
    kategori = json['Kategori'] != null ? json['Kategori'].cast<String>() : [];
  }
  int? bukuID;
  String? deskripsi;
  String? coverBuku;
  String? judul;
  String? penulis;
  String? penerbit;
  String? tahunTerbit;
  String? jumlahHalaman;
  double? rating;
  int? totalUlasan;
  int? jumlahRating;
  int? jumlahPeminjam;
  List<String>? kategori;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['BukuID'] = bukuID;
    map['Deskripsi'] = deskripsi;
    map['CoverBuku'] = coverBuku;
    map['Judul'] = judul;
    map['Penulis'] = penulis;
    map['Penerbit'] = penerbit;
    map['TahunTerbit'] = tahunTerbit;
    map['JumlahHalaman'] = jumlahHalaman;
    map['Rating'] = rating;
    map['Total_ulasan'] = totalUlasan;
    map['JumlahRating'] = jumlahRating;
    map['JumlahPeminjam'] = jumlahPeminjam;
    map['Kategori'] = kategori;
    return map;
  }

}