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

  Widget _image(var document) {
    return (document['imagesUrl'] != null)
        ? Image(
      fit: BoxFit.cover,
      image: NetworkImage(
        document['imagesUrl'][0],
      ),
    )
        : Container();
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
                    return Column(
                      children: <Widget>[
                        _image(document),
                        Card(
                          child: ListTile(
                            title: Text(document['title']),
                            subtitle: Text(document['price']),
                          ),
                          borderOnForeground: true,
                          elevation: 120,
                        ),
                      ],
                );
              }).toList(),
            );
        }
      },
    );
  }
}
