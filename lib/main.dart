import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappnew/admin/add_category.dart';
import 'package:flutterappnew/admin/add_product.dart';
import 'package:flutterappnew/admin/categories.dart';
import 'package:flutterappnew/admin/products.dart';
import 'package:hidden_drawer_menu/controllers/hidden_drawer_controller.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_menu.dart';
import 'package:hidden_drawer_menu/hidden_drawer/screen_hidden_drawer.dart';
import 'package:hidden_drawer_menu/menu/hidden_menu.dart';
import 'package:hidden_drawer_menu/menu/item_hidden_menu.dart';
import 'package:hidden_drawer_menu/menu/item_hidden_menu_right.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/animated_drawer_content.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/bloc/simple_hidden_drawer_bloc.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/provider/simple_hidden_drawer_provider.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/simple_hidden_drawer.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/streams/streams_simple_hidden_menu.dart';

main() {
  runApp(FlutterShop());
}

class FlutterShop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.pink),
      home: AuthTest(),
//      routes: {
//        '/categories': (context) => AddCategoryScreen(),
//        '/products': (context) => AllProducts(),
//        '/add_product': (context) => AddProduct(),
//        '/add_category': (context) => AddCategoryScreen(),
//      },
    );
  }
}

class AuthTest extends StatefulWidget {
  @override
  _AuthTestState createState() => _AuthTestState();
}

class _AuthTestState extends State<AuthTest> {
  List<ScreenHiddenDrawer> items = new List();

//  TextEditingController _emailController = TextEditingController();
//  TextEditingController _passwordController = TextEditingController();
//  FirebaseAuthentication firebaseAuthentication = FirebaseAuthentication();

  @override
  void initState() {
    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Categories".toUpperCase(),
          baseStyle: TextStyle(
              color: Colors.white.withOpacity(0.8), fontSize: 28.0),
          colorLineSelected: Colors.teal,
        ),
        Categories()));

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Products".toUpperCase(),
          baseStyle: TextStyle(
              color: Colors.white.withOpacity(0.8), fontSize: 28.0),
          colorLineSelected: Colors.orange,
        ),
        AllProducts()));
    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Add Product".toUpperCase(),
          baseStyle: TextStyle(
              color: Colors.white.withOpacity(0.8), fontSize: 28.0),
          colorLineSelected: Colors.orange,
        ),
        AddProduct()));
    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Add Category".toUpperCase(),
          baseStyle: TextStyle(
              color: Colors.white.withOpacity(0.8), fontSize: 28.0),
          colorLineSelected: Colors.orange,
        ),
        AddCategoryScreen()));
//    firebaseAuthentication.getCurrentUser();
    super.initState();
  }

  @override
  void dispose() {
//    _emailController.dispose();
//    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return HiddenDrawerMenu(
      backgroundColorMenu: Colors.blueGrey,
      backgroundColorAppBar: Colors.cyan,
      screens: items,
//          typeOpen: TypeOpen.FROM_RIGHT,
          enableScaleAnimin: true,
//          enableCornerAnimin: true,
          slidePercent: 80.0,
          verticalScalePercent: 80.0,
          contentCornerRadius: 60.0,
      //    iconMenuAppBar: Icon(Icons.menu),
      //    backgroundContent: DecorationImage((image: ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
          whithAutoTittleName: true,
//          styleAutoTittleName: TextStyle(color: Colors.white),

      //    actionsAppBar: <Widget>[],
      //    backgroundColorContent: Colors.blue,
//          elevationAppBar: 10.0,
//          tittleAppBar: Center(child: Icon(Icons.ac_unit),),
          enableShadowItensMenu: true,
      //    backgroundMenu: DecorationImage(image: ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
    );




    /*List<int> number = [1,2,3,4,5];

    List<int> newNumbers = number.map((int number) {
      return number*5;
    }).toList();
    */




   /* return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Shop'),
          centerTitle: true,
        ),
        drawer:
    );*/
  }
}

/*
Widget _scaffold(){
  return Scaffold(
    appBar: AppBar(
      title: Text('Auth Test'),
      centerTitle: true,
    ),
    body: ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Register'),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                SizedBox(height: 16),
                RaisedButton(
                  child: Text('Register'),
                  onPressed: () async {
                    String email = _emailController.text.trim();
                    String password = _passwordController.text.trim();
                    await firebaseAuthentication.register(email, password);
                  },
                ),
                SizedBox(height: 16),
                RaisedButton(
                  child: Text('Sign Out'),
                  onPressed: () async {
                    await firebaseAuthentication.signOut();
                  },
                ),
                SizedBox(height: 16),
                RaisedButton(
                  child: Text('Sign In'),
                  onPressed: () async {
                    String email = _emailController.text.trim();
                    String password = _passwordController.text.trim();
                    await firebaseAuthentication.singIn(email, password);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
*/
/*
DrawerHeader(
        margin: EdgeInsets.only(left: 120),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text('Categories'.toUpperCase()),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/categories');
                },
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text('products'.toUpperCase()),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/products');
                },
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text('add category'.toUpperCase()),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/add_category');
                },
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text('add product'.toUpperCase()),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/add_product');
                },
              ),
            ),
          ],
        ),
      ),
* */


