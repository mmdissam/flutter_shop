import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllProducts extends StatefulWidget {
  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: _allProduct(),
    );
  }

  Widget _allProduct() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('products').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return new ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return new ListTile(
                  title: new Text(document['title']),
                  subtitle: new Text(document['price']),
                  trailing: (document['imagesUrl'] != null)
                      ? SizedBox(
                          width: 100,
                          height: 100,
                          child: Image(
                              image: NetworkImage(document['imagesUrl'][0])))
                      : SizedBox(),
                );
              }).toList(),
            );
        }
      },
    );
  }
}
