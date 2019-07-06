import 'package:flutter/material.dart';
import './products.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class CategoriesList extends StatelessWidget {
  CategoriesList({
    this.name, 
    this.cart
  });
  final String name;
  List<dynamic> cart;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            name: name,
            image_location: 'images/cats/quanao.png',
            image_caption: 'quanao',
            cart: cart,
          ),
          Category(
            name: name,
            image_location: 'images/cats/giaydep.png',
            image_caption: 'giaydep',
            cart: cart,
          ),
          Category(
            name: name,
            image_location: 'images/cats/dogiadung.png',
            image_caption: 'dogiadung',
            cart: cart,
          ),
          Category(
            name: name,
            image_location: 'images/cats/xabong.jpg',
            image_caption: 'xabong',
            cart: cart,
          ),
          Category(
            name: name,
            image_location: 'images/cats/dienthoai.png',
            image_caption: 'smartphone',
            cart: cart,
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  Category({
    this.name,
    this.image_location, 
    this.image_caption, 
    this.cart,
  });
  final String image_location;
  final String image_caption;
  final String name;
  List<dynamic> cart;

  List<dynamic> dataProducer = new List();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () async{
          final response = await http.post("http://192.168.137.1/flutter_server/flutter_chooseproducer.php",
            body:{
              "productType": image_caption,
            });
            dataProducer = json.decode(response.body);
            dataProducer.add({'producer':'Tất cả'});

            Navigator.push(context, MaterialPageRoute(builder: (context) => Products(
              name: name,
              productType: image_caption,
              producerList: dataProducer,
              cart: cart,
            )));
        },
        child: Container(
          width: 100.0,
          child: ListTile(
            title: Image.asset(
              image_location,
              width: 100.0,
              height: 80.0,
            ),
          ),
        ),
      ),
    );
  }
}
