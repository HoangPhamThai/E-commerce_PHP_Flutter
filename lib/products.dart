import 'package:flutter/material.dart';
import 'dart:convert';
import './show_list_of_product.dart';
import './drawer_category.dart';
import 'package:http/http.dart' as http;


class Products extends StatefulWidget {
  Products({
    this.name,
    this.productType,//category of product
    this.producerList,//List of producer of a product
    this.cart,
  });
  final String name;
  final String productType;
  final List<dynamic> producerList;
  List<dynamic> cart;

  @override
  _Products createState() => _Products(
    name: name,
    productType: productType,
    producerList: producerList,
    cart: cart,
  );
}

class _Products extends State<Products> {
  _Products({
    this.name,
    this.productType,
    this.producerList,
    this.cart,
  });
  final String name;
  final String productType;
  final List<dynamic> producerList;
  List<dynamic> cart;

  String choseProducer;
  var data;

  Widget typeOfProduct(){
    if (productType == 'quanao'){
      return Text('Loại sản phẩm: Quần áo', textScaleFactor: 1.5,);
    }else if (productType == 'giaydep'){
      return Text('Loại sản phẩm: Giày dép', textScaleFactor: 1.5,);
    }else if (productType == 'dogiadung'){
      return Text('Loại sản phẩm: Đồ gia dụng', textScaleFactor: 1.5,);
    }else if (productType == 'xabong'){
      return Text('Loại sản phẩm: Xà bông', textScaleFactor: 1.5,);
    }else if (productType == 'smartphone'){
      return Text('Loại sản phẩm: Smartphone', textScaleFactor: 1.5,);
    }
  }

  Widget showListOfProducer(){
    if (producerList[0] == "Tất cả"){
      return Padding(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Text(''),
      );
    }else{
      List<String> listAllProducer = new List();
      int index;
      for (index = 0; index < producerList.length; index++){
        listAllProducer.add(producerList[index]['producer']);
      }

      return Row(
        children: <Widget>[
          new Text('Chọn nhà sản xuất: ', textScaleFactor: 1.5,),
          new DropdownButton<String>(
            value: choseProducer,
            onChanged: (String newvalue){
              setState(() {
              choseProducer = newvalue; 
              });
            },
            items:listAllProducer.map<DropdownMenuItem<String>>((String value){
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      );
    }
  }

  Future getProduct() async{
    if (choseProducer == "Tất cả"){
      choseProducer = 'all';
    }
    final response = await http.post("http://192.168.137.1/flutter_server/flutter_retrieveProduct.php",
    body:{
      "category": productType,
      "producer": choseProducer,
    });
    data = json.decode(response.body);
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Sản phẩm"),
      ),

      drawer: DrawerCategory(
        name: name,
        cart: cart,
      ),

      body: new ListView(
        children: <Widget>[
          typeOfProduct(),
          showListOfProducer(),
          Center(
            child: RaisedButton(
              textColor: Theme.of(context).primaryColorLight,
              color: Theme.of(context).primaryColorDark,
              child: Text('Xem sản phẩm', textScaleFactor:1.5),
              onPressed: () async {
                getProduct();
              },
            ),
          ),
          showListOfProduct(data, cart, name),
        ],
      ),
    );
  }
}
