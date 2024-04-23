// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pvnow/components/button.dart';
import 'package:pvnow/components/helper_functions.dart';
import 'package:pvnow/components/textfield.dart';
import 'package:pvnow/components/title_text.dart';
import 'package:pvnow/theme/pv_colors.dart';

class VendorInformationPage extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  const VendorInformationPage(
      {super.key,
      required this.name,
      required this.password,
      required this.email});

  @override
  State<VendorInformationPage> createState() => _VendorInformationPageState();
}

class _VendorInformationPageState extends State<VendorInformationPage> {
  File? _image;
  final picker = ImagePicker();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController brandnameController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final collection = FirebaseFirestore.instance.collection("Users");

  // register function
  void registerVendor() async {
    try {
      // try to create user
      UserCredential? userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: widget.email, password: widget.password);

      userCredential.user!.updateDisplayName(brandnameController.text);

      String fileName =
          brandnameController.text.replaceAll(RegExp('[^a-zA-Z0-9\\s]'), '') +
              "-logo ";
      String brandname = brandnameController.text;
      Reference reference =
          FirebaseStorage.instance.ref().child('$brandname/logos/$fileName');
      UploadTask uploadTask = reference.putFile(_image!);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      userCredential.user!.updatePhotoURL(imageUrl);

      // create user document and add to firestore database
      createVendorDocument(
          userCredential,
          widget.name,
          brandnameController.text,
          phoneNumberController.text,
          imageUrl,
          websiteController.text);

      if (context.mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      // display error message to user
      displayMessageToUser(e.code, context);
    }
  }

  Future<void> createVendorDocument(
      UserCredential? userCredential,
      String name,
      String brandname,
      String phoneNumber,
      String logoUrl,
      String website) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Vendors")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'name': name,
        'brandname': brandname,
        'phoneNumber': phoneNumber,
        'website': website,
        'logo': logoUrl,
      });
    }
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    brandnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brand Information'),
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
                  text: "Brand Name",
                  mainAxisAlignment: MainAxisAlignment.start),
              SizedBox(height: 25),
              MyTextField(
                controller: brandnameController,
                hintText: 'Enter Brand Name',
                obscureText: false,
              ),
              SizedBox(height: 25),
              TitleText(
                  text: "Logo", mainAxisAlignment: MainAxisAlignment.start),
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
                text: 'Upload Logo Image',
                onTap: getImage,
                buttonColor: Theme.of(context).colorScheme.primary,
                textColor: pvPurple,
              ),
              SizedBox(height: 25),
              TitleText(
                  text: "Phone Number",
                  mainAxisAlignment: MainAxisAlignment.start),
              SizedBox(height: 25),
              MyTextField(
                controller: phoneNumberController,
                hintText: 'Enter Contact Phone Number',
                obscureText: false,
              ),
              SizedBox(height: 25),
              TitleText(
                  text: "Website", mainAxisAlignment: MainAxisAlignment.start),
              SizedBox(height: 25),
              MyTextField(
                controller: websiteController,
                hintText: 'Enter Store Website',
                obscureText: false,
              ),
              SizedBox(height: 25),
              MyButton(
                  text: "Register",
                  onTap: registerVendor,
                  buttonColor: pvPurpleDark,
                  textColor: Theme.of(context).colorScheme.inversePrimary),
            ],
          ),
        ),
      ),
    );
  }
}
