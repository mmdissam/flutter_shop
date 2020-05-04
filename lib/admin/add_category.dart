import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddCategoryScreen extends StatefulWidget {
  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _addCategoryController = TextEditingController();
  bool isLoading = false;
  bool isExist = false;

  @override
  void dispose() {
    _addCategoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading) ? _isLoading() : _categoryFrom();
  }

  Widget _isLoading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _categoryFrom() {
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: TextFormField(
                controller: _addCategoryController,
                decoration: InputDecoration(hintText: 'Category Title'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'category is required';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 16,
            ),
            RaisedButton(
              child: Text('Save Category'),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  setState(() {
                    isLoading = true;
                  });

                  //To Check is category added ???????
                  var response =  await Firestore.instance.collection('categories').where('title',isEqualTo: _addCategoryController.text ).snapshots().first;
                  if(response.documents.length > 0){
                    setState(() {
                      isLoading = false;
                      isExist = true;
                    });
                  }else{
                    Firestore.instance
                        .collection('categories')
                        .document()
                        .setData({
                      'title': _addCategoryController.text,
                    }).then((onValue) {
                      _addCategoryController.text = '';

                      setState(() {
                        isLoading = false;
                        isExist = false;
                      });
                    });
                  }

                }
              },
            ),
            (isExist) ? _exist() : Container(),
          ],
        ),
      ),
    );
  }


  Widget _exist(){
    return Container(
      child: Center(
        child: Text('This Category Is Exist!!',style: TextStyle(color: Colors.red.shade800),),
      ),
    );
  }
}
