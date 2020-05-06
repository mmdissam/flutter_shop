import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  File _image1, _image2, _image3;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  bool isLoading = false;
  bool _isWrongCategory = false;
  String dropdownValue = 'Select Category';

  Future getImage(File requiredImage) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      requiredImage = image;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Widget _isLoading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _addProduct() {
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
                _displayGridImages(),
                /* RaisedButton(
                  onPressed: getImage,
                  child: Text('Add Image'),
                ),*/
                SizedBox(height: 16),
                RaisedButton(
                  child: Text('Save Product'),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      String imageUrl1 = await uploadImage(_image1);
                      String imageUrl2 = await uploadImage(_image2);
                      String imageUrl3 = await uploadImage(_image3);
                      List<String> imagesUrl = [
                        imageUrl1,
                        imageUrl2,
                        imageUrl3
                      ];

                      await Firestore.instance
                          .collection('products')
                          .document()
                          .setData({
                        'title': _titleController.text,
                        'discription': _descriptionController.text,
                        'price': _priceController.text,
                        'title_category': dropdownValue,
                        'imagesUrl': imagesUrl,
                      }).then((onValue) {
                        setState(() {
                          isLoading = false;
                        });
                        _titleController.text = '';
                        _descriptionController.text = '';
                        _priceController.text = '';
                        dropdownValue = 'Select Category';
                      });
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
  @override
  Widget build(BuildContext context) {
    return (isLoading) ? _isLoading() : _addProduct();
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

  Future<String> uploadImage(File image) async {
    String now = formatDate(DateTime.now(), [HH, ':', nn, ':', ss, ' ', Z]);
    String name = '${_titleController.text}' + now;
    final StorageReference storageReference =
        FirebaseStorage().ref().child(name);
    final StorageUploadTask uploadTask = storageReference.putFile(image);
    StorageTaskSnapshot response = await uploadTask.onComplete;
    String url= await response.ref.getDownloadURL();
    return url;
  }

  Widget _displayGridImages() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            InkWell(
              child: Container(
                padding: EdgeInsets.all(8),
                color: Colors.tealAccent,
              ),
              onTap: () async{
                var image = await ImagePicker.pickImage(
                    source: ImageSource.camera);
                setState(() {
                  _image1 = image;
                });
              },
            ),
            InkWell(
              child: Container(
                padding: EdgeInsets.all(8),
                color: Colors.tealAccent,
              ),
              onTap: () async{
                var image = await ImagePicker.pickImage(
                    source: ImageSource.camera);
                setState(() {
                  _image2 = image;
                });
              },
            ),
            InkWell(
              child: Container(
                padding: EdgeInsets.all(8),
                color: Colors.tealAccent,
              ),
              onTap: () async{
                var image = await ImagePicker.pickImage(
                    source: ImageSource.camera);
                setState(() {
                  _image3 = image;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
