import 'package:flutter/material.dart';
import './categories.dart';
import './recent_products.dart';
import './create_drawer.dart';
import './purchase.dart';
  
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  HomePage({
    this.cart,
    this.accountName,
  });
  List<dynamic> cart;
  final String accountName;
  @override
  _HomePageState createState() => _HomePageState(
    accountName: accountName,
    cart: cart,
  );
}

class _HomePageState extends State<HomePage> {
  _HomePageState({
    this.cart,
    this.accountName,
  });
  List<dynamic> cart;
  final String accountName;

  Widget LoginRequire(){
    if (accountName == null){
      return Text('Bạn chưa đăng nhập, xin mời đăng nhập',style: TextStyle(fontSize: 14.0, color: Colors.red));
    }else{
      return Text('Xin chào ${accountName}', style: TextStyle(fontSize: 20, color: Colors.blue, fontWeight: FontWeight.w700),);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:  AppBar(
        elevation: 0.1,
        backgroundColor: Colors.blue,
        title: Text('FastMarket'),
        //view cart
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                if (cart == null){
                  return showDialog(
                    context: context,
                    child: SimpleDialog(
                      title: Text('Thông báo'),
                      children: <Widget>[
                        Center(
                          child: Text('Có vẻ bạn chưa đăng nhập. Xin mời đăng nhập'),
                        ),
                      ],
                    )
                  );
                }
                else if (cart.length == 1){
                  return showDialog(
                    context: context,
                    child: SimpleDialog(
                      title: Text('Thông báo'),
                      children: <Widget>[
                        Center(
                          child: Text('Giỏ hàng của bạn rỗng'),
                        ),
                      ],
                    )
                  );
                }else{
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Purchase(cart: cart,)));
                }
              })
        ],
      ),

      drawer: CreateDrawer(
        name: accountName,
        cart: cart,
      ),

      body: new ListView(
        children: <Widget>[

          LoginRequire(),
          //padding widget
          new Padding(padding: const EdgeInsets.all(8.0),
          child: new Text('Loại sản phẩm', textScaleFactor: 1.5,),),

          //Horizontal category
          CategoriesList(
            name: accountName,
            cart: cart,
          ),

          new Padding(padding: const EdgeInsets.all(8.0),
            child: new Text('Sản phẩm mới', textScaleFactor: 1.5,),),
          
          //display some new products
          RecentProducts(),

          new Padding(padding: const EdgeInsets.all(8.0),
            child: new Text('Đồ án tin học - VP2015'),),
        ],
      ),
    );
  }
}