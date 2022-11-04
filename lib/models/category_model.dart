import '../utils/images.dart';

class CategoryModel{
  String? name;
  int color;
  String? icon;

  CategoryModel({required this.name, required this.color, required this.icon});

  static List<CategoryModel> lists = [
    CategoryModel(color: 0xFFCCFF80,icon: MyImages.ic_grocery,name:  'Grocery'),
    CategoryModel(color: 0xFFFF9680,icon: MyImages.ic_work,name: 'Work'),
    CategoryModel(color: 0xFF80FFFF,icon: MyImages.ic_sport,name: 'Sport'),
    CategoryModel(color: 0xFF80FFD9,icon: MyImages.ic_design,name: 'Design'),
    CategoryModel(color: 0xFF809CFF,icon: MyImages.ic_university,name: 'University'),
    CategoryModel(color: 0xFFFF80EB,icon: MyImages.ic_social,name: 'Social'),
    CategoryModel(color: 0xFFFC80FF,icon: MyImages.ic_music,name: 'Music'),
    CategoryModel(color: 0xFF80FFA3,icon: MyImages.ic_healty,name: 'Health'),
    CategoryModel(color: 0xFF80D1FF,icon: MyImages.ic_movie,name: 'Movie'),
    CategoryModel(color: 0xFFFF8080,icon: MyImages.icc_home,name: 'Home'),
    CategoryModel(color: 0xFF80FFD1,icon: MyImages.ic_create,name: 'Create New'),
  ];
}