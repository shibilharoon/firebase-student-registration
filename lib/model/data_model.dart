class DataModel {
  String? name;
  String? age;
  String? phone;
  String? course;
  String? image;
  DataModel({
    required this.name,
    required this.age,
    required this.phone,
    required this.course,
    required this.image,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      name: json["Name"],
      age: json['Age'],
      phone: json['Phone'],
      course: json['course'],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Name": name,
      "Age": age,
      "Phone": phone,
      "course": course,
      "image": image
    };
  }
}
