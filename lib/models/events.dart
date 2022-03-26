class Events{
  String title;
  String Image;
  String starttime;
  String endtime;
  String venue;
  String description;

  Events(
      {required this.title,
      required this.Image,
      required this.starttime,
      required this.endtime,
      required this.venue,
      required this.description});

  factory Events.fromJson(Map<String, dynamic> json) {
    return Events(
      title: json["title"],
      Image: json["Image"],
      starttime: json["start time"],
      endtime: json["end time"],
      venue: json["Venue"],
      description: json["Description"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": this.title,
      "Image": this.Image,
      "starttime": this.starttime,
      "endtime": this.endtime,
      "venue": this.venue,
      "description": this.description,
    };
  }
//

}