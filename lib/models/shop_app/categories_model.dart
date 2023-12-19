
// ignore_for_file: non_constant_identifier_names

class CategoryModel{
 late bool status;
 late CategoriesDataModel data;

CategoryModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }}

class CategoriesDataModel {
  late int current_page;
  List<CatDataDataModel> data=[];
  CategoriesDataModel.fromJson(Map<String,dynamic> json){
    current_page = json['current_page'];
    json['data'].forEach((element){
      data.add(CatDataDataModel.fromJson(element));
    });
  }
}

class CatDataDataModel{
   late int id;
   late String name;
   late String image;

  CatDataDataModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name']!;
    image = json['image']!;
  }

}