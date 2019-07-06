import 'package:flutter/material.dart';
import './main.dart';
import './products.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


//drawer of Product widget
class DrawerCategory extends StatelessWidget{
  DrawerCategory({
    this.name,
    this.cart,
  });
  final String name;
  List<dynamic> dataProducer = new List();
  List<dynamic> cart;

  @override
  Widget build(BuildContext context){
    return Drawer(
      child: new ListView(
        children: <Widget>[
          //homepage
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

          Divider(),

          new Text('Category', textScaleFactor: 1.5,),

          //quanao
          InkWell(
            onTap: () async{
              final response = await http.post("http://192.168.137.1/flutter_server/flutter_chooseproducer.php",
                body:{
                  "productType": 'quanao',
                });
                dataProducer = json.decode(response.body);
                dataProducer.add({'producer':'Tất cả'});

                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return Products(
                    name: name,
                    productType: 'quanao',
                    producerList: dataProducer,
                    cart: cart,
                  );
                }));
              
            },
            child: ListTile(
              title: Text('Quần áo'),
            ),
          ),

          //giaydep
          InkWell(
            onTap: ()async{
              final response = await http.post("http://192.168.137.1/flutter_server/flutter_chooseproducer.php",
                body:{
                  "productType": 'giaydep',
                });
                dataProducer = json.decode(response.body);
                dataProducer.add({'producer':'Tất cả'});

                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return Products(
                    name: name,
                    productType: 'giaydep',
                    producerList: dataProducer,
                    cart: cart,
                  );
                }));

            },
            child: ListTile(
              title: Text('Giày dép'),
            ),
          ),

          //dogiadung
          InkWell(
            onTap: () async{
              final response = await http.post("http://192.168.137.1/flutter_server/flutter_chooseproducer.php",
                body:{
                  "productType": 'dogiadung',
                });
                dataProducer = json.decode(response.body);
                dataProducer.add({'producer':'Tất cả'});

                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return Products(
                    name: name,
                    productType: 'dogiadung',
                    producerList: dataProducer,
                    cart: cart,
                  );
                }));
    
            },
            child: ListTile(
              title: Text('Đồ gia dụng'),
            ),
          ),

          //xabong
          InkWell(
            onTap: ()async{
              final response = await http.post("http://192.168.137.1/flutter_server/flutter_chooseproducer.php",
                body:{
                  "productType": 'xabong',
                });
                dataProducer = json.decode(response.body);
                dataProducer.add({'producer':'Tất cả'});
   
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return Products(
                    name: name,
                    productType: 'xabong',
                    producerList: dataProducer,
                    cart: cart,
                  );
                }));

            },
            child: ListTile(
              title: Text('Xà bông'),
            ),
          ),

          //smartphone
          InkWell(
            onTap: ()async{
              final response = await http.post("http://192.168.137.1/flutter_server/flutter_chooseproducer.php",
                body:{
                  "productType": 'smartphone',
                });
                dataProducer = json.decode(response.body);
                dataProducer.add({'producer':'Tất cả'});

                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return Products(
                    name: name,
                    productType: 'smartphone',
                    producerList: dataProducer,
                    cart: cart,
                  );
                }));
        
            },
            child: ListTile(
              title: Text('Smartphone'),
            ),
          ),
        ],
      ),
    );
  }
}