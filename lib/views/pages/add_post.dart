// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pvnow/components/button.dart';
import 'package:pvnow/components/textfield.dart';
import 'package:pvnow/components/title_text.dart';
import 'package:pvnow/theme/pv_colors.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  File? _image;
  final picker = ImagePicker();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _postTitleController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;
  final collection = FirebaseFirestore.instance.collection("Users");

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> uploadPost() async {
    String description = _descriptionController.text;
    // Upload image to Firebase storage
    String fileName =
        "${currentUser.displayName!}: ${_postTitleController.text}";
    Reference reference =
        FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = reference.putFile(_image!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    // Save the image URL to Firestore
    FirebaseFirestore.instance.collection('Posts').add({
      'image': imageUrl,
      'title': _postTitleController.text,
      'description': description,
      'vendorName': currentUser.displayName,
      'timestamp': Timestamp.now(),
    });
    if (context.mounted) Navigator.pop(context);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _postTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TitleText(
                  text: "Post Title",
                  mainAxisAlignment: MainAxisAlignment.start),
              SizedBox(height: 25),
              MyTextField(
                controller: _postTitleController,
                hintText: 'Enter Post Title',
                obscureText: false,
              ),
              SizedBox(height: 25),
              TitleText(
                  text: "Post Image",
                  mainAxisAlignment: MainAxisAlignment.start),
              _image != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 25),
                      child: Image.file(
                        _image!,
                        height: 200,
                        width: 200,
                      ),
                    )
                  : SizedBox(height: 25),
              MyButton(
                text: 'Upload Image',
                onTap: getImage,
                buttonColor: Theme.of(context).colorScheme.primary,
                textColor: pvPurple,
              ),
              SizedBox(height: 25),
              TitleText(
                  text: "Post Description",
                  mainAxisAlignment: MainAxisAlignment.start),
              SizedBox(height: 25),
              MyTextField(
                controller: _descriptionController,
                hintText: 'Enter Post Description',
                obscureText: false,
              ),
              SizedBox(height: 25),
              MyButton(
                  text: "Post",
                  onTap: uploadPost,
                  buttonColor: pvPurpleDark,
                  textColor: Theme.of(context).colorScheme.inversePrimary),
            ],
          ),
        ),
      ),
    );
  }
}
