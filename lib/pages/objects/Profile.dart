class Profile {
  String uid;
  String name;
  String phoneNumber;
  String email;
  DateTime? lastConductedMeet;

  Profile(this.uid, this.name, this.phoneNumber, this.email,
      this.lastConductedMeet);

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'lastConducted': lastConductedMeet?.toIso8601String()
    };
  }
}
