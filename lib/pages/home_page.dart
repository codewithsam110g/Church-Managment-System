import 'package:church_management_system/pages/create_profile_page.dart';
import 'package:church_management_system/pages/members/add_attendance.dart';
import 'package:church_management_system/pages/members/members_list.dart';
import 'package:church_management_system/pages/members/new_members_list.dart';
import 'package:church_management_system/pages/members/unattended_list.dart';
import 'package:church_management_system/pages/objects/Member.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:church_management_system/auth.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'members/add_new_members.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int this_month = 0, this_year = 0, last_month = 0, last_year = 0;

  @override
  void initState() {
    super.initState();
    checkForFirstTimer();
    checkAndUpdateReports();
  }

  void checkAndUpdateReports() async {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? "";
    final snapshot =
        await FirebaseDatabase.instance.ref("UserData/Members/$uid").get();
    if (snapshot.exists) {
      snapshot.children.forEach((e) {
        final value = e.value as Map;
        Member m = Member.fromMap(value['id'], value);
        DateTime? date = m.addedDate;
        DateTime now = DateTime.now();
        if (date!.year == now.year) {
          if (date.month == now.month) {
            this_month++;
            this_year++;
          } else if (date.month == now.month - 1) {
            last_month++;
            this_year++;
          } else {
            this_year++;
          }
        } else if (date.year == now.year - 1) {
          if (date.month == 12 && now.month == 1) {
            last_month++;
          } else {
            last_year++;
          }
        } else {
          last_year++;
        }
      });
      setState(() {});
    }
  }

  void checkForFirstTimer() async {
    String uid = FirebaseAuth.instance.currentUser?.uid ?? "";
    final ref = FirebaseDatabase.instance.ref("Users").child(uid);
    final snapshot = await ref.get();
    if (snapshot.value == null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return const CreateProfilePage();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          GestureDetector(
            onTap: () {
              showLogoutDialog(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(
                    FirebaseAuth.instance.currentUser!.photoURL ?? ""),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          // Members Section
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Members',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          buildCard('Add New Member', context),
          buildCard('Add Attendance', context),
          buildCard('Members List', context),
          buildCard('New Members', context),
          buildCard('Call list for Unattended Members', context),
          const Divider(),

          // Reports Section
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Reports',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          buildCard('This Month: ' + this_month.toString(), context),
          buildCard('Last Month: ' + last_month.toString(), context),
          buildCard('This Year: ' + this_year.toString(), context),
          buildCard('Last Year: ' + last_year.toString(), context),
        ],
      ),
    );
  }

  Widget buildCard(String text, BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: GestureDetector(
          onTap: () {
            switch (text) {
              case "Add New Member":
                {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return AddNewMemberPage();
                    },
                  ));
                  break;
                }
              case "Add Attendance":
                {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const AddAttendancePage();
                    },
                  ));
                  break;
                }
              case "Members List":
                {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return MembersListPage();
                    },
                  ));
                  break;
                }
              case "New Members":
                {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return NewMembersPage();
                    },
                  ));
                  break;
                }
              case "Call list for Unattended Members":
                {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const CallList();
                    },
                  ));
                  break;
                }
            }
          },
          child: Card(
            elevation: 4.0,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 18.0),
                  ),
                )),
          ),
        ));
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                GoogleSignInProvider().logout();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
