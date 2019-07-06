import 'package:flutter/material.dart';

import './update_product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Widget displayProducts(data,producer,category){
  if (data.length == 0){
    return Text('No data');
  }else{
    int numOfProduct = data.length;
    List<String> idList = new List();
    List<String> nameList = new List();
    List<String> imageList = new List();
    List<String> descriptionList = new List();
    List<String> priceList = new List();
   
    for (int index = 0; index < numOfProduct; index++){
      idList.add(data[index]['id']);
      nameList.add(data[index]['name']);
      imageList.add(data[index]['image']);
      descriptionList.add(data[index]['description']);
      priceList.add(data[index]['price']);
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      //height of display cell
      height: 320,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: numOfProduct,
        itemBuilder: (BuildContext context, int i){
          return ListOfProducts(
            id: idList[i],
            name: nameList[i],
            image: imageList[i],
            description: descriptionList[i],
            price: priceList[i],
            //data: data,
            producer: producer,
            category: category,
          );
        }
      ),
    );
  }
}

class ListOfProducts extends StatelessWidget{
  const ListOfProducts({
    @required this.id,
    @required this.name,
    @required this.image,
    @required this.description,
    @required this.price,
    //@required this.data,
    @required this.producer,
    @required this.category,
  });
  final String id;
  final String name;
  final String description;
  final String image;
  final String price;
  //final List data;
  final String producer;
  final String category;
  @override
  Widget build(BuildContext context){
    Future verifydeleteProduct() async{
      await showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Xóa sản phẩm'),
            content: Text('Bạn có muốn xóa sản phẩm?'),
            actions: <Widget>[
              new FlatButton(
                child: Text('Không'),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: Text('Có'),
                onPressed: () async{
                  var cat;
                  if (category == 'Quần áo'){
                    cat = 'quanao';
                  }else if (category == 'Giày dép'){
                    cat = 'giaydep';
                  }else if (category == 'Đồ gia dụng'){
                    cat = 'dogiadung';
                  }else if (category == 'Xà bông'){
                    cat = 'xabong';
                  }else if (category == 'Smartphone'){
                    cat = 'smartphone';
                  }
                  final response =await http.post("http://192.168.137.1/flutter_server/flutter_deleteProduct.php", body:{
                    "id": id,
                    "image": image, 
                    "category": cat,
                  });
                  var data = json.decode(response.body);
                  String mess;
                  if (data == true){
                    mess = "Đã xóa sản phẩm";
                  }else{
                    mess = "Xóa không thành công";
                  }
                  await showDialog(
                    context: context,
                    child: new SimpleDialog(
                      title: Text('Thông báo'),
                      children: <Widget>[
                        Center(
                          child: Text(mess)), 
                      ],
                    ),
                  );
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
      );
    }
    return Row(
          children: <Widget>[           
            //view all products
            GestureDetector(
              child: Container(
                padding: EdgeInsets.all(5),
                //width of a display cell
                width: 305,
                decoration: BoxDecoration(
                  //color of cell
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ListView(
                  children: <Widget>[
                    //name of product
                    RichText(
                      softWrap: true,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,),
                        children: [
                          TextSpan(text: name),
                        ],
                      ),
                    ),
                    //blank space between name and image
                    SizedBox(
                      height: 10,
                    ),

                    //image of product
                    SizedBox(
                      height: 200,
                      child: Image.network('http://192.168.137.1/flutter_server/uploadImage/'+image),
                    ),
                    //blank space between image and description
                    SizedBox(
                      height: 10,
                    ),
                    
                    //description of product
                    Container(
                      height: 50,
                      width: 280,
                      child: ListView(
                        children: <Widget>[
                          RichText(
                            softWrap: true,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black),
                              children: [
                                TextSpan(text: 'Mô tả:\n'),
                                TextSpan(text: description),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //blank space between description and price
                    SizedBox(
                      height: 10,
                    ),

                    //price of product
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(price+' VND',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.update),
                          onPressed: (){
                            print(description);
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return UpdateProduct(
                                id: id,
                                producer: producer,
                                image: image,
                              );
                            }));
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async{
                            verifydeleteProduct();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
 
  
  }
}