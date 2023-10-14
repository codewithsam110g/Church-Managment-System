import 'package:flutter/material.dart';
import 'package:church_management_system/pages/objects/Member.dart';
import 'package:firebase_database/firebase_database.dart';

class AddAttendancePage extends StatefulWidget {
  const AddAttendancePage({Key? key}) : super(key: key);

  @override
  _AddAttendancePageState createState() => _AddAttendancePageState();
}

class _AddAttendancePageState extends State<AddAttendancePage> {
  final databaseReference = FirebaseDatabase.instance.ref('UserData/Members');
  List<bool> checked = [];
  List<Member> members = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    DataSnapshot snapshot = await databaseReference.get();
    if (snapshot.value != null) {
      List<dynamic> data = snapshot.value as List;
      data.forEach((e) {
        if (e != null) {
          Member m = Member.fromMap(e['id'], e);
          members.add(m);
        }
      });
      checked = List.generate(members.length, (index) => false);
      setState(() {});
    }
  }

  void updateAttendance() {
    final ref = FirebaseDatabase.instance.ref("UserData/Members");
    for (int i = 0; i < members.length; i++) {
      if (checked[i]) {
        ref.child((i + 1).toString()).update({
          "attendance": members[i].attendance + 1,
          "lastAttended": DateTime.now().toIso8601String()
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Attendance'),
      ),
      body: members.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: buildMembersList(),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      updateAttendance();
                      Navigator.of(context).pop();
                    },
                    child: const Text("Submit Attendance"),
                  ),
                )
              ],
            ),
    );
  }

  Widget buildMembersList() {
    return ListView.builder(
      itemCount: members.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    members[index].name,
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  Checkbox(
                    value: checked[index],
                    onChanged: (value) {
                      setState(() {
                        checked[index] = !checked[index];
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
