import 'package:church_management_system/pages/objects/Profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({Key? key}) : super(key: key);

  @override
  _CreateProfilePageState createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  String _nameError = '';
  String _phoneError = '';
  String _emailError = '';

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      final user = FirebaseAuth.instance.currentUser;
      _nameController.text = user?.displayName ?? "";
      _emailController.text = user?.email ?? "";
      _phoneController.text = user?.phoneNumber ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Create Profile Page'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFieldWidget(
                    label: 'Name',
                    hint: '',
                    controller: _nameController,
                    errorText: _nameError,
                  ),
                  TextFieldWidget(
                    label: 'Phone Number',
                    hint: '',
                    controller: _phoneController,
                    errorText: _phoneError,
                  ),
                  TextFieldWidget(
                    label: 'Email',
                    hint: '',
                    controller: _emailController,
                    errorText: _emailError,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _nameError = validateName(_nameController.text);
                        _phoneError = validatePhone(_phoneController.text);
                        _emailError = validateEmail(_emailController.text);

                        if (_nameError.isEmpty &&
                            _phoneError.isEmpty &&
                            _emailError.isEmpty) {
                          addToDatabase();
                          Navigator.of(context)
                              .pop(); // Go back to the previous screen
                        }
                      });
                    },
                    child: Text('Create Profile'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  String validateName(String value) {
    if (value.isEmpty) {
      return 'Name cannot be empty';
    }
    return '';
  }

  String validatePhone(String value) {
    final phonePattern = RegExp(r'^\d{10}$');
    if (value.isEmpty) {
      return 'Phone number cannot be empty';
    } else if (!phonePattern.hasMatch(value)) {
      return 'Invalid phone number format';
    }
    return '';
  }

  String validateEmail(String value) {
    final emailPattern = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!emailPattern.hasMatch(value)) {
      return 'Invalid email format';
    }
    return '';
  }

  void addToDatabase() async {
    String uid = FirebaseAuth.instance.currentUser?.uid ?? "";
    String name = _nameController.text;
    String phoneNumber = _phoneController.text;
    String email = _emailController.text;
    Profile p = Profile(uid, name, phoneNumber, email, 0, null);
    FirebaseDatabase.instance.ref("Users").child(uid).set(p.toJson());
    Navigator.of(context).pop();
  }
}

class TextFieldWidget extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final String errorText;

  TextFieldWidget({
    required this.label,
    required this.hint,
    required this.controller,
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.all(12),
              errorText: errorText.isNotEmpty ? errorText : null,
            ),
          ),
        ],
      ),
    );
  }
}
