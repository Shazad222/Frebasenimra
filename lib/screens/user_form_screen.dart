import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class UserFormScreen extends StatefulWidget {
  @override
  _UserFormScreenState createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form inputs
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController ideasController = TextEditingController();
  final TextEditingController futureTaskController = TextEditingController();

  String selectedGender = 'Male';

  Future<void> saveData() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirestoreService.saveUserData(
          username: usernameController.text,
          gender: selectedGender,
          location: locationController.text,
          ideas: ideasController.text,
          futureTask: futureTaskController.text,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data saved successfully!')),
        );

        // Clear the form fields
        usernameController.clear();
        locationController.clear();
        ideasController.clear();
        futureTaskController.clear();
        setState(() {
          selectedGender = 'Male';
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving data: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Data Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedGender,
                items: ['Male', 'Female', 'Other']
                    .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedGender = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Gender'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: locationController,
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: ideasController,
                decoration: InputDecoration(labelText: 'Ideas in Your Mind'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please share your ideas';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: futureTaskController,
                decoration: InputDecoration(labelText: 'Future Task'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please share your future task';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: saveData,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
