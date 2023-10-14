import 'package:church_management_system/pages/objects/Member.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AddNewMemberPage extends StatefulWidget {
  const AddNewMemberPage({super.key});

  @override
  _AddNewMemberPageState createState() => _AddNewMemberPageState();
}

class _AddNewMemberPageState extends State<AddNewMemberPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  String _nameError = '';
  String _phoneError = '';
  String _emailError = '';
  String _addressError = '';

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Member Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFieldWidget(
                label: 'Name',
                hint: 'John Doe',
                controller: _nameController,
                errorText: _nameError,
              ),
              TextFieldWidget(
                label: 'Phone Number',
                hint: '123-456-7890',
                controller: _phoneController,
                errorText: _phoneError,
              ),
              TextFieldWidget(
                label: 'Email',
                hint: 'johndoe@example.com',
                controller: _emailController,
                errorText: _emailError,
              ),
              TextFieldWidget(
                label: 'Address',
                hint: '123 Main St, City, Country',
                controller: _addressController,
                errorText: _addressError,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _nameError = validateName(_nameController.text);
                    _phoneError = validatePhone(_phoneController.text);
                    _emailError = validateEmail(_emailController.text);
                    _addressError = validateAddress(_addressController.text);

                    if (_nameError.isEmpty &&
                        _phoneError.isEmpty &&
                        _emailError.isEmpty &&
                        _addressError.isEmpty) {
                      addToDatabase();
                      Navigator.of(context).pop();
                    }
                  });
                },
                child: Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
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

  String validateAddress(String value) {
    if (value.isEmpty) {
      return 'Address cannot be empty';
    }
    return '';
  }

  void addToDatabase() async {
    String name = _nameController.text;
    String phoneNumber = _phoneController.text;
    String email = _emailController.text;
    String address = _addressController.text;
    int attendance = 0;
    DateTime addedDate = DateTime.now();
    DateTime lastAttended = DateTime.now();
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child("Users/0/prof_nums").get();
    int id = 0;
    if (snapshot.exists) {
      id = (snapshot.value as int) + 1;
    }

    Member m = Member(id, name, phoneNumber, email, address, attendance,
        addedDate, lastAttended);
    ref.child("UserData/Members").child(id.toString()).set(m.toJson());
    ref.child("Users/0/prof_nums").set(id);
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
