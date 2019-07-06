import 'package:flutter/material.dart';
import './show_list_of_product.dart';
import './purchase.dart';

class DetailProduct extends StatefulWidget{
  DetailProduct({
    this.user,
    this.producer,
    this.name,
    this.description,
    this.image,
    this.price,
    this.data,
    this.cart,
  });
  List<dynamic> cart;
  final String user;
  final String producer;
  final String name;
  final String image;
  final String description;
  final String price;
  final List data;

  @override
  _DetailProduct createState() => _DetailProduct(
    user: user,
    producer: producer,
    name: name,
    description: description,
    image: image,
    price: price,
    data: data,
    cart: cart,
  );
}

class _DetailProduct extends State<DetailProduct>{
  _DetailProduct({
    this.user,
    this.producer,
    this.name,
    this.description,
    this.image,
    this.price,
    this.data,
    this.cart,
  });
  List<dynamic> cart;
  final String user;
  final String producer;
  final String name;
  final String image;
  final String description;
  final String price;
  final List data;
  var cartValue = new Map();
  TextEditingController numOfProduct = TextEditingController();

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin sản phẩm'),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: ListView(
          children: <Widget>[
            //image of product
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Image.network('http://192.168.137.1/flutter_server/uploadImage/'+image),
            ),
            
            //name of product
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: RichText(
                softWrap: true,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.blue,
                    fontWeight: FontWeight.w700,),
                  children: [
                    TextSpan(text: name),
                  ],
                ),
              ),
            ),

            //description of product
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: RichText(
                softWrap: true,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(text: 'Mô tả: '+description)
                  ],
                ),
              ),
            ),

            //producer
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: RichText(
                softWrap: true,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(text: 'Nhà sản xuất: '+producer)
                  ],
                ),
              ),
            ),

            //price
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text('Giá (VND): '+price),
            ),

            //number of products
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text('Số lượng mua:'),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: TextField(
                controller: numOfProduct,
                style: new TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelStyle: TextStyle(),
                  labelText: 'Số lượng',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),

            //add to cart
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: RaisedButton(
                textColor: Theme.of(context).primaryColorLight,
                color: Theme.of(context).primaryColorDark,
                child: Text('Thêm vào giỏ hàng', textScaleFactor: 1.5),
                onPressed: (){
                  String mess;
                  if (cart == null){
                    mess = 'Có vẻ bạn chưa đăng nhập. Xin mời đăng nhập';
                  }else if(numOfProduct.text == ''){
                    mess = 'Bạn chưa nhập số lượng hàng mua';
                  }else{
                    cartValue['name'] = name;
                    cartValue['producer'] = producer;
                    cartValue['price'] = price.toString();
                    cartValue['numOfProduct'] = numOfProduct.text;
                    cart.add(cartValue);
                    mess = 'Sản phẩm đã được thêm vào giỏ hàng';
                  } 
                  return showDialog(
                    context: context,
                    child: SimpleDialog(
                      title: Text("Thông báo"),
                      children: <Widget>[
                        Center(
                          child: Text(mess),
                        ),
                      ],
                    )
                  );
                },
              ),
            ),

            //purchase
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: RaisedButton(
                textColor: Theme.of(context).primaryColorLight,
                color: Theme.of(context).primaryColorDark,
                child: Text('Thanh toán', textScaleFactor: 1.5),
                onPressed: (){    
                  if (cart == null){
                    return showDialog(
                      context: context,
                      child: SimpleDialog(
                        title: Text("Thông báo"),
                        children: <Widget>[
                          Center(
                            child: Text('Có vẻ bạn chưa đăng nhập. Xin mời đăng nhập'),
                          ),
                        ],
                      )
                    );
                  }else if (cart.length == 1){
                    return showDialog(
                      context: context,
                      child: SimpleDialog(
                        title: Text("Thông báo"),
                        children: <Widget>[
                          Center(
                            child: Text('Giỏ hàng của bạn trống'),
                          ),
                        ],
                      )
                    );
                  }
                  else{
                    //print(cart);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Purchase(cart: cart,user:user)));
                  }
                          
                },
              ),
            ),

            //display other products in a same category
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text('Các sản phẩm cùng loại', textScaleFactor: 1.5,),
            ),
            showListOfProduct(data, cart,user),
          ],
        ),
      ), 
    ); 
  }
}