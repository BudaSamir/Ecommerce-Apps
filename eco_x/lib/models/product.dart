// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:eco_x/utilities/assets.dart';

class Prodcut {
  final String id;
  final String title;
  final int price;
  final String imgUrl;
  final int? discountValue;
  final String category;
  final double? rate;
  Prodcut({
    required this.id,
    required this.title,
    required this.price,
    required this.imgUrl,
    this.discountValue,
    this.category = 'Other',
    this.rate,
  });
  static List<Prodcut> dummyProdcuts = [
    Prodcut(
        id: '1',
        title: "T-shirt",
        price: 300,
        imgUrl: AppAssets.tempProductAsset1,
        category: "Clothes",
        discountValue: 20),
    Prodcut(
        id: '1',
        title: "T-shirt",
        price: 300,
        imgUrl: AppAssets.tempProductAsset1,
        category: "Clothes",
        discountValue: 20),
    Prodcut(
        id: '1',
        title: "T-shirt",
        price: 300,
        imgUrl: AppAssets.tempProductAsset1,
        category: "Clothes",
        discountValue: 20),
    Prodcut(
        id: '1',
        title: "T-shirt",
        price: 300,
        imgUrl: AppAssets.tempProductAsset1,
        category: "Clothes",
        discountValue: 20),
    Prodcut(
        id: '1',
        title: "T-shirt",
        price: 300,
        imgUrl: AppAssets.tempProductAsset1,
        category: "Clothes",
        discountValue: 20)
  ];
}
