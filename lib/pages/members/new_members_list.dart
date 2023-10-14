import 'package:flutter/material.dart';
import 'package:church_management_system/pages/objects/Member.dart';
import 'package:firebase_database/firebase_database.dart';

class NewMembersPage extends StatefulWidget {
  const NewMembersPage({Key? key}) : super(key: key);

  @override
  _NewMembersPageState createState() => _NewMembersPageState();
}

class _NewMembersPageState extends State<NewMembersPage> {
  final databaseReference = FirebaseDatabase.instance.ref('UserData/Members');
  List<Member> members = [];
  bool isDone = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    DataSnapshot snapshot =
        await databaseReference.orderByChild("attendance").endAt(0).get();
    if (snapshot.value != null) {
      Map data = snapshot.value as Map;
      data.values.forEach((e) {
        if (e != null) {
          Member m = Member.fromMap(e['id'], e);
          members.add(m);
        }
      });
      isDone = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Members'),
      ),
      body: isDone
          ? const Center(child: CircularProgressIndicator())
          : buildMembersList(),
    );
  }

  Widget buildMembersList() {
    if (members.isEmpty) {
      return const Align(
        alignment: Alignment.center,
        child: Text("No New Members!"),
      );
    }

    return ListView.builder(
      itemCount: members.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  members[index].name,
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
