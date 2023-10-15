import 'package:church_management_system/pages/objects/Member.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';

class CallList extends StatefulWidget {
  const CallList({super.key});
  @override
  State<CallList> createState() => _CallListState();
}

class _CallListState extends State<CallList> {
  final uid = FirebaseAuth.instance.currentUser?.uid ?? "";
  final ref = FirebaseDatabase.instance.ref("UserData/Members");
  List<Member> members = [];
  bool isDone = false;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> launchPhoneDialer(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  void fetchData() async {
    final snapshot = await ref.child(uid).get();
    final d_snap = await FirebaseDatabase.instance
        .ref("Users/$uid/lastConductedMeet")
        .get();

    DateTime? lastConductedMeet = DateTime.tryParse(d_snap.value.toString());
    if (snapshot.exists) {
      snapshot.children.forEach((e) {
        final value = e.value as Map;
        Member m = Member.fromMap(value['id'], value);
        if (lastConductedMeet != m.lastAttended) {
          members.add(m);
        }
      });
    }

    setState(() {
      isDone = true;
    });
  }

  Widget ShowMembers(BuildContext context) {
    return ListView.builder(
      itemCount: members.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      members[index].name,
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      members[index].phoneNumber,
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Call List"),
      ),
      body: isDone
          ? ShowMembers(context)
          : const Center(
              child: Text("No Members!"),
            ),
    );
  }
}
