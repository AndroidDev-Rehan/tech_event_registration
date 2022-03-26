class Events{
  String title;
  String Image;
  String starttime;
  String endtime;
  String venue;
  String description;
  String stall;
  String price;
  String agecriteria;
  String educriteria;

  Events(
      {required this.title,
      required this.Image,
      required this.starttime,
      required this.endtime,
      required this.venue,
      required this.description,
      required this.stall,required this.price,required this.agecriteria,required this.educriteria});

  factory Events.fromJson(Map<String, dynamic> json) {
    return Events(
      title: json["title"],
      Image: json["Image"],
      starttime: json["start time"],
      endtime: json["end time"],
      venue: json["Venue"],
      description: json["Description"],
      price: json["Price"],
      stall: json["Stall"],
      agecriteria: json['age'],educriteria: json['edu']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": this.title,
      "Image": this.Image,
      "starttime": this.starttime,
      "endtime": this.endtime,
      "Venue": this.venue,
      "Description": this.description,
      'Stall':this.stall,
      'Price':this.price,
      'edu':this.educriteria,
      'age':this.agecriteria
    };
  }
//

}