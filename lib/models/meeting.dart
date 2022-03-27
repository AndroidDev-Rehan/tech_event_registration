class Meeting {
  final String meetingTopic;
  final String meetingDescription;
  final String meetingDate;
  final String meetingTime;
  final String meetingLocation;

  Meeting(
      {required this.meetingTopic,
      required this.meetingDescription,
      required this.meetingDate,
      required this.meetingTime,
      required this.meetingLocation});

  Map<String, dynamic> toMap() {
    return {
      'meetingTopic': this.meetingTopic,
      'meetingDescription': this.meetingDescription,
      'meetingDate': this.meetingDate,
      'meetingTime': this.meetingTime,
      'meetingLocation': this.meetingLocation,
    };
  }

  factory Meeting.fromMap(Map<String, dynamic> map) {
    return Meeting(
      meetingTopic: map['meetingTopic'] as String,
      meetingDescription: map['meetingDescription'] as String,
      meetingDate: map['meetingDate'] as String,
      meetingTime: map['meetingTime'] as String,
      meetingLocation: map['meetingLocation'] as String,
    );
  }
}