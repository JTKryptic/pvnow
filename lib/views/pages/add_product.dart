// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, prefer_interpolation_to_compose_strings

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

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  File? _image;
  final picker = ImagePicker();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> uploadProduct() async {
    String description = _descriptionController.text;
    // Upload image to Firebase storage
    String fileName = currentUser.displayName!
            .replaceAll(RegExp('[^a-zA-Z0-9\\s]'), '') +
        ": " +
        _productNameController.text.replaceAll(RegExp('[^a-zA-Z0-9\\s]'), '');
    String brandname = currentUser.displayName!;
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('$brandname/productImages/$fileName');
    UploadTask uploadTask = reference.putFile(_image!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    // Save the image URL to Firestore
    FirebaseFirestore.instance
        .collection('Products')
        .doc(
            currentUser.displayName!.replaceAll(RegExp('[^a-zA-Z0-9\\s]'), '') +
                ": " +
                _productNameController.text
                    .replaceAll(RegExp('[^a-zA-Z0-9\\s]'), ''))
        .set({
      'imageUrl': imageUrl,
      'productName': _productNameController.text,
      'description': description,
      'vendorName': currentUser.displayName,
      'price': double.parse(_priceController.text),
      'timestamp': Timestamp.now(),
    });
    if (context.mounted) Navigator.pop(context);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _productNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
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
                  text: "Product Title",
                  mainAxisAlignment: MainAxisAlignment.start),
              SizedBox(height: 25),
              MyTextField(
                controller: _productNameController,
                hintText: 'Enter Product Title',
                obscureText: false,
              ),
              SizedBox(height: 25),
              TitleText(
                  text: "Product Image",
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
                  text: "Product Description",
                  mainAxisAlignment: MainAxisAlignment.start),
              SizedBox(height: 25),
              MyTextField(
                controller: _descriptionController,
                hintText: 'Enter Product Description',
                obscureText: false,
              ),
              SizedBox(height: 25),
              TitleText(
                text: "Product Price",
                mainAxisAlignment: MainAxisAlignment.start,
              ),
              SizedBox(height: 25),
              MyTextField(
                controller: _priceController,
                hintText: 'Enter Product Price',
                obscureText: false,
              ),
              const SizedBox(height: 25),
              MyButton(
                  text: "Add Product",
                  onTap: uploadProduct,
                  buttonColor: pvPurpleDark,
                  textColor: Theme.of(context).colorScheme.inversePrimary),
            ],
          ),
        ),
      ),
    );
  }
}
