class ProfileModel {
  final int id;
  final String username, name, email, phone, photo;

  ProfileModel({this.id, this.username, this.name, this.email, this.phone, this.photo});

  factory ProfileModel.fromJSON(Map<String, dynamic> json) => ProfileModel(
    id: json["id"],
    username: json["username"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    photo: json["photo"]
  );
}