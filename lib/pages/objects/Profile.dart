class Profile {
  String uid;
  String name;
  String phoneNumber;
  String email;
  int memberCount;
  DateTime? lastConductedMeet;

  Profile(this.uid, this.name, this.phoneNumber, this.email, this.memberCount,
      this.lastConductedMeet);
  Profile.fromMap(Map<dynamic, dynamic> map)
      : uid = map['uid'],
        name = map['name'],
        phoneNumber = map['phoneNumber'],
        email = map['email'],
        memberCount = map['memberCount'],
        lastConductedMeet = DateTime.tryParse(map['lastConductedMeet'] ?? "");

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'memberCount': memberCount,
      'lastConductedMeet': lastConductedMeet?.toIso8601String()
    };
  }
}
