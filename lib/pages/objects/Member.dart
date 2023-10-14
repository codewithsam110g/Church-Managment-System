class Member {
  int id;
  String name;
  String phoneNumber;
  String email;
  String address;
  int attendance;
  DateTime? addedDate;
  DateTime? lastAttended;

  Member(this.id, this.name, this.phoneNumber, this.email, this.address,
      this.attendance, this.addedDate, this.lastAttended);

  Member.fromMap(this.id, Map<dynamic, dynamic> map)
      : name = map['name'],
        phoneNumber = map['phoneNumber'],
        email = map['email'],
        address = map['address'],
        attendance = map['attendance'],
        addedDate = DateTime.tryParse(map['addedDate']),
        lastAttended = DateTime.tryParse(map['lastAttended']);

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address,
      'attendance': attendance,
      'addedDate': addedDate?.toIso8601String(),
      'lastAttended': lastAttended?.toIso8601String(),
    };
  }


}
