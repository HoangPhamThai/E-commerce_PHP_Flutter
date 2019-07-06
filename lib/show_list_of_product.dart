import 'package:flutter/material.dart';
import './detailed_product.dart';

Widget showListOfProduct(data, cart, name){  
  if (data == null){
      return Text('No data');
  }else{
    int numOfProduct = data.length;
    List<String> nameList = new List();
    List<String> imageList = new List();
    List<String> descriptionList = new List();
    List<String> priceList = new List();
    List<String> producerList = new List();
    
    for (int index = 0; index < numOfProduct; index++){
      nameList.add(data[index]['name']);
      imageList.add(data[index]['image']);
      descriptionList.add(data[index]['description']);
      priceList.add(data[index]['price']);
      producerList.add(data[index]['producer']);
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      //height of display cell
      height: 400,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: numOfProduct,
        itemBuilder: (BuildContext context, int i){
          return ListOfProducts(
            user: name,
            producer: producerList[i],
            name: nameList[i],
            image: imageList[i],
            description: descriptionList[i],
            price: priceList[i],
            data: data,
            cart: cart,
          );
        }
      ),
    );
  }
}

class ListOfProducts extends StatelessWidget{
  ListOfProducts({
    @required this.user,
    @required this.cart,
    @required this.producer,
    @required this.name,
    @required this.image,
    @required this.description,
    @required this.price,
    @required this.data}
  );
  List<dynamic> cart;
  final String user;
  final String producer;
  final String name;
  final String description;
  final String image;
  final String price;
  final List data;
  @override
  Widget build(BuildContext context){
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailProduct(
              user: user,
              name: name,
              description: description,
              image: image,
              price: price,
              data: data,
              producer: producer,
              cart: cart,
            )));
          },
          child: Container(
            padding: EdgeInsets.all(5),
            //width of a display cell
            width: 330,
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
                      fontSize: 20,
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
                  height: 30,
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
                            TextSpan(text: 'Mô tả: ${description}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //blank space between description and producer
                SizedBox(
                  height: 10,
                ),

                //producer
                SizedBox(
                  height: 30,
                  child: Text('Nhà sản xuất: ${producer}'),
                ),
                
                //blank space between producer and price
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