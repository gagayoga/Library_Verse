

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomListBuku2 extends StatelessWidget {
  final context;

  CustomListBuku2({
    super.key,
    required this.context,
  });

  List<CardItem> items = [
    CardItem(
      imageURl: "assets/buku/novel_gadisKretek.png",
      judulBuku: "Gadis Kretek",
    ),
    CardItem(
      imageURl: "assets/buku/novel_monster.png",
      judulBuku: "Monster",
    ),
    CardItem(
      imageURl: "assets/buku/ensiklopedia_atomicHabits.png",
      judulBuku: "Atomic Habits",
    ),
    CardItem(
      imageURl: "assets/buku/komik_detektifConan103.png",
      judulBuku: "Detektif Conan:103",
    ),
    CardItem(
      imageURl: "assets/buku/komik_sulitBerkomunikasi.png",
      judulBuku: "Kita Sulit Berkomunikasi",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount : 5,
        separatorBuilder: (context, _) => SizedBox(width: 15,),
        itemBuilder: (context, index) => builCard(items:items[index]),
      ),
    );
  }

  Widget builCard({
    required CardItem items,
})=> Container(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        child: ClipRRect(
          child: AspectRatio(
            aspectRatio: 3 / 4,
            child: Image.asset(
              items.imageURl,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
      const SizedBox(height: 5,),
      AutoSizeText(
        items.judulBuku,
        maxLines: 1,
        maxFontSize: 12,
        minFontSize: 12,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 16.0,
          color: Colors.black,
          fontWeight: FontWeight.w800,
        ),
      )
    ],
  ),
);
}

class CardItem {
  final String imageURl;
  final String judulBuku;

  const CardItem({
    required this.imageURl,
    required this.judulBuku,
});
}
