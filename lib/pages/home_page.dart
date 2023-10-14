import 'package:church_management_system/pages/members/add_attendance.dart';
import 'package:church_management_system/pages/members/members_list.dart';
import 'package:church_management_system/pages/members/new_members_list.dart';
import 'package:flutter/material.dart';
import 'package:church_management_system/auth.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'members/add_new_members.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
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
          buildCard('This Month', context),
          buildCard('Last Month', context),
          buildCard('This Year', context),
          buildCard('Last Year', context),
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
                      return const NewMembersPage();
                    },
                  ));
                  break;
                }
              case "Call list for Unattended Members":
                {
                  print("Call list for Unattended Members Selected!");
                  break;
                }
              case "This Month":
                {
                  print("This Month Selected!");
                  break;
                }
              case "Last Month":
                {
                  print("Last Month Selected!");
                  break;
                }
              case "This Year":
                {
                  print("This Year Selected!");
                  break;
                }
              case "Last Year":
                {
                  print("Last Year Selected!");
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
