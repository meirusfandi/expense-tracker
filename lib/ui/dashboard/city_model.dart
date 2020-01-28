class CityModel {
  int id;
  String cityName;
  String cityImage;
  int price;

  CityModel({this.id, this.cityName, this.cityImage, this.price});

  factory CityModel.fromJSON(Map<String, dynamic> json) => CityModel(
    id: json["id"],
    cityName: json["cityImage"],
    cityImage: json["cityImage"],
    price: json["price"]
  );
}

class ListCities {
  List<CityModel> listCity;

  ListCities({this.listCity});

  factory ListCities.fromJSON(Map<String, dynamic> json) => ListCities(
    listCity: List<CityModel>.from(json["cities"].map((x) => CityModel.fromJSON(x)))
  );
}