import 'dart:developer';
import 'dart:io';
import 'package:akpa/service/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? image;
  final ImagePicker picker = ImagePicker();
  final ProfileService profileService = ProfileService();

  Future<void> pickImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  Future<void> uploadProfilePicture() async {
    if (image != null) {
      try {
        final response = await profileService.updateProfilePicture(image!);
        if (response.status) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.message)),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update profile picture')),
          );
        }
      } catch (e) {
        log('Error during profile upload: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading profile picture')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an image first')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile Picture',
          style: TextStyle(color: Colors.black), // Changed text color to black
        ),
        backgroundColor: Colors.white, // Changed background to white
        iconTheme: IconThemeData(color: Colors.black), // Back button color
      ),
      body: Container(
        color: Colors.white, // Changed background color to white
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              image == null
                  ? Text(
                      'No image selected.',
                      style: TextStyle(
                        color: Colors.black, // Text color changed to black
                      ),
                    )
                  : Image.file(image!, height: 150),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: pickImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Button background color
                  foregroundColor: Colors.white, // Button text color
                ),
                child: Text('Pick Image'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: uploadProfilePicture,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Button background color
                  foregroundColor: Colors.white, // Button text color
                ),
                child: Text('Upload Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
