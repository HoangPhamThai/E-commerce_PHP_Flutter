import 'package:flutter/material.dart';
import './login.dart';
import './main.dart';
import './products.dart';
import './app_info.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateDrawer extends StatelessWidget{
  CreateDrawer({
    this.name,
    this.cart,
  });
  List<dynamic> cart;
  final String name;

  String takeLetter(String str){
    if (str == null){
      return '';
    }else{
      return str;
    }
  }

  List<dynamic> listOfProducer = new List();

  @override
  Widget build(BuildContext context){
    return Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: Text('Xin chào '+takeLetter(name)),
            accountEmail: Text(''),
            currentAccountPicture: GestureDetector(
              child: new CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white,),
              ),
            ),
            decoration: new BoxDecoration(
              color: Colors.blue
            ),
          ),

          //to the homepage
          InkWell(
            onTap: (){
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(
                accountName: name,
                cart: cart,
              )));
            },
            child: ListTile(
              title: Text('Trang chủ'),
              leading: Icon(Icons.home),
            ),
          ),

          //to the login page
          InkWell(
            onTap: (){
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return Login();
              }));
            },
            child: ListTile(
              title: Text('Tài khoản'),
              leading: Icon(Icons.person),
            ),
          ),

          //view products
          InkWell(
            onTap: () async{
              final response = await http.post("http://192.168.137.1/flutter_server/flutter_chooseproducer.php",
              body:{
                "productType": 'quanao',
              });
              listOfProducer = json.decode(response.body);
              listOfProducer.add({'producer':'Tất cả'});
              //debugPrint(listOfProducer);
              if (listOfProducer.isEmpty){}else{
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return Products(
                    name: name,
                    productType: 'quanao',
                    producerList: listOfProducer,
                    cart: cart,
                  );
                }));
              }
            },
            child: ListTile(
              title: Text('Sản phẩm'),
              leading: Icon(Icons.dashboard),
            ),
          ),

          Divider(),

          //to the info page
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => AppInfo()));
            },
            child: ListTile(
              title: Text('Thông tin'),
              leading: Icon(Icons.help, color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}