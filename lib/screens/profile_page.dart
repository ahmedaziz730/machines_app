import 'package:flutter/material.dart';
import 'package:login/screens/home_page.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  static String routeName = '/profile';

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _fmKey = GlobalKey();
  static late File pickedImage;
  bool _load = false;

  final TextEditingController username = TextEditingController();
  static String ff = '';

  Future<void> _pickImage() async {
    final pickedImageFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      pickedImage = File(pickedImageFile!.path);
      _load = !_load;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Form(
        key: _fmKey,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 80,
                backgroundColor: Colors.grey,
                backgroundImage: _load ? FileImage(pickedImage) : null,
              ),
              SizedBox(
                height: 15,
              ),
              TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColor,
                ),
                onPressed: _pickImage,
                icon: Icon(Icons.image),
                label: Text('Add Image'),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 300,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Enter User Name',
                    contentPadding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  controller: username,
                  keyboardType: TextInputType.name,
                  validator: (newvalue) {
                    if (newvalue!.isEmpty || newvalue.length < 5) {
                      return 'this username is very short';
                    }
                    return null;
                  },
                  onSaved: (newValue) => {
                    username.text = newValue!,
                  },
                ),
              ),
              SizedBox(
                height: 98,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_load) {
                    if (_fmKey.currentState!.validate()) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => HomePage(image: pickedImage),
                        ),
                      );
                    }
                    setState(() {
                      ff = username.text;
                    });
                  }
                  if (!_load) {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Attention!'),
                        content: Text(
                          'You must choose image for profile',
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                          )
                        ],
                      ),
                    );
                  }
                },
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
