class DigimonModel {
  final String name;
  final String img;
  final String level;

  DigimonModel({required this.name, required this.img, required this.level});

  factory DigimonModel.fromJson(Map<String, dynamic> json) {
    return DigimonModel(
      name: json['name'],
      img: json['img'],
      level: json['level'],
    );
  }
}
