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
  String uid;

  Events(
      {required this.title,
      required this.Image,
      required this.starttime,
      required this.endtime,
      required this.venue,
      required this.description,
      required this.stall,required this.price,required this.agecriteria,required this.educriteria,this.uid=''});

  factory Events.fromJson(Map<String, dynamic> json,String id) {
    return Events(
      title: json["title"]??'No data',
      Image: json["Image"]??'No data',
      starttime: json["start time"]??'No data',
      endtime: json["end time"]??'No data',
      venue: json["Venue"]??'No data',
      description: json["Description"]??'No data',
      price: json["Price"]??'0',
      stall: json["Stall"]??'0',
      agecriteria: json['age']??'No data',educriteria: json['edu']??'No data',uid: id

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