import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllProduct extends StatefulWidget {
  @override
  _AllProductState createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Products'),
        centerTitle: true,
      ),
      body: Center(
        child: _allProduct(),
      ),
    );
  }


  Widget _allProduct(){
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('products').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return new ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return new ListTile(
                  title: new Text(document['title']),
                  subtitle: new Text(document['price']),
                );
              }).toList(),
            );
        }
      },
    );
  }
}
