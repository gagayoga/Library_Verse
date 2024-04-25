import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class customSlide extends StatelessWidget {
  final context;

  customSlide({
    super.key,
    required this.context,
  });

  List<CardItem> items = [
    CardItem(imageURl: 'assets/kategoriBuku/novel.svg'),
    CardItem(imageURl: 'assets/kategoriBuku/manga.svg'),
    CardItem(imageURl: 'assets/kategoriBuku/komik.svg'),
    CardItem(imageURl: 'assets/kategoriBuku/ensiklopedia.svg'),
    CardItem(imageURl: 'assets/kategoriBuku/majalah.svg'),
    CardItem(imageURl: 'assets/kategoriBuku/biografi.svg'),

  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
      child: Container(
        height: 120,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          separatorBuilder: (context, _) => SizedBox(
            width: 15,
          ),
          itemBuilder: (context, index) => builCard(items: items[index]),
        ),
      ),
    );
  }

  Widget builCard({
    required CardItem items,
  }) =>
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          width: 150,
          height: 50,
          child: SvgPicture.asset(
            items.imageURl,
            fit: BoxFit.cover,
          ),
        ),
      );
}

class CardItem {
  final String imageURl;

  const CardItem({
    required this.imageURl,
  });
}
