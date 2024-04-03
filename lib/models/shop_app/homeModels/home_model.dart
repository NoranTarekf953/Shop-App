class HomeModel {
  late bool status;
  late HomeDataModel data;

 

  HomeModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
    List<BannersData> banners =[];
   List<ProductsData> products=[];
HomeDataModel.fromJson(Map<String,dynamic> json){

  //banners = (json['banners'] as List)?.map((e) => e == null ? null : BannersData.fromJson(e as Map<String, dynamic>))?.toList()
   json['banners'].forEach((element){
    banners.add(BannersData.fromJson(element));
   });
   json['products'].forEach((element){
    products.add(ProductsData.fromJson(element));
   });
  }
}
class BannersData{
  late int id;
  late String image;
BannersData.fromJson(Map<String,dynamic> json){
  id = json['id'];
  image = json['image'];
}
}
class ProductsData{
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late bool inFav;
  late bool inCart;

  ProductsData.fromJson(Map<String,dynamic> json){
  id = json['id'];
  price = json['price'];
    oldPrice = json['old_price'];
      price = json['price'];
        discount = json['discount'];


  image = json['image'];
    name = json['name'];
      inFav = json['in_favorites'];

  inCart = json['in_cart'];


}
}