import 'package:church_management_system/pages/objects/Member.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class MembersListPage extends StatelessWidget {
  final databaseReference = FirebaseDatabase.instance.ref('UserData/Members');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Members List'),
      ),
      body: FutureBuilder(
        future: databaseReference.once(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final data = snapshot.data!.snapshot.value;
            if (data != null) {
              // Process data and create a list of member objects
              // You can use a ListView or other widgets to display the list
              return buildMembersList(data);
            } else {
              return const Center(child: Text('No member data available.'));
            }
          } else {
            return const Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }

  Widget buildMembersList(Object data_) {
    List<dynamic> data = data_ as List;
    List<Member> members = List.empty(growable: true);
    data.forEach((e) {
      if (e != null) {
        Member m = Member.fromMap(e['id'] ?? 0, e);
        members.add(m);
      }
    });
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
                )),
          ),
        );
      },
    );
  }
}
