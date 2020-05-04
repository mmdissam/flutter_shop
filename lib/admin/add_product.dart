import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  bool isLoading = false;

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
                RaisedButton(
                  child: Text('Save Product'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      Firestore.instance
                          .collection('products')
                          .document()
                          .setData({
                        'title': _titleController.text,
                        'discription': _descriptionController.text,
                        'price': _priceController.text
                      }).then((onValue) {
                        setState(() {
                          isLoading = false;
                        });
                        _titleController.text = '';
                        _descriptionController.text = '';
                        _priceController.text = '';
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
