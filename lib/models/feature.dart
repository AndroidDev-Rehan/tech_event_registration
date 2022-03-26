class Feature{
  String title;
  String Image;
  Feature({required this.title, required this.Image});

  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      title: json["title"],
      Image: json["Image"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": this.title,
      "Image": this.Image,
    };
  }
//

}