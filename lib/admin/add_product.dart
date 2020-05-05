import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  File _image;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  bool isLoading = false;
  bool _isWrongCategory = false;
  String dropdownValue = 'Select Category';

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(hintText: 'title'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'title is requier';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'description',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'description is requier';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(hintText: 'price'),
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'price is requier';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  child: _selectCategory(),
                  width: 500,
                ),
                SizedBox(height: 16),
                RaisedButton(
                  onPressed: getImage,
                  child: Text('Add Image'),
                ),
                SizedBox(height: 16),
                RaisedButton(
                  child: Text('Save Product'),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      await Firestore.instance
                          .collection('products')
                          .document()
                          .setData({
                        'title': _titleController.text,
                        'discription': _descriptionController.text,
                        'price': _priceController.text,
                        'title_category': dropdownValue,
                      }).then((onValue) {
                        setState(() {
                          isLoading = false;
                        });
                        _titleController.text = '';
                        _descriptionController.text = '';
                        _priceController.text = '';
                        dropdownValue = 'Select Category';
                      });
                      await uploadImage(_image);
                    }
                  },
                ),
                SizedBox(
                    width: double.infinity,
                    child: (_isWrongCategory)
                        ? Text(
                            'You Must Selecting Category',
                            style: TextStyle(color: Colors.red.shade800),
                          )
                        : Container()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _selectCategory() {
    return StreamBuilder(
      stream: Firestore.instance.collection('categories').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              isExpanded: true,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                if (newValue == 'Select Category') {
                  setState(() {
                    _isWrongCategory = true;
                  });
                } else {
                  setState(() {
                    dropdownValue = newValue;
                    _isWrongCategory = false;
                  });
                }
              },
              items: snapshot.data.documents.map((DocumentSnapshot document) {
                return DropdownMenuItem<String>(
                  value: document['title'],
                  child: Text(document['title']),
                );
              }).toList(),
            );
        }
      },
    );
  }

  Future<void> uploadImage(File image) async {
    String name = 'product_' + Random().nextInt(1000).toString();
    final StorageReference storageReference =
        FirebaseStorage().ref().child(name);
    final StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
  }


}
