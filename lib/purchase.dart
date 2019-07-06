import 'package:flutter/material.dart';

class Purchase extends StatefulWidget{
  Purchase({
    this.cart,
    this.user,
  });
  final String user;
  final List<dynamic> cart;
  @override
  _Purchase createState() => _Purchase(
    cart: cart,
    user: user,
  );
}

class _Purchase extends State<Purchase>{
  _Purchase({
    this.user,
    this.cart,
  });
  final List<dynamic> cart;
  final String user;
  TextEditingController address = TextEditingController();
  
  Widget showBill() {
    int numOfCart = cart.length;
    String bill = 'HÓA ĐƠN\n'+'Khách hàng: ${user}\n'+'Người bán: Fastapp\n';
    int productPrice;
    int totalCost = 0;
    for (int index = 1; index < numOfCart; index++){
      productPrice = int.parse(cart[index]['numOfProduct'])*int.parse(cart[index]['price']);
      bill = bill + 'Sản phẩm: ${cart[index]['name']}, Nhà sản xuất: ${cart[index]['producer']}, Giá: ${cart[index]['price']}, Số lượng: ${cart[index]['numOfProduct']}, Thành tiền: ${productPrice.toString()}\n';
      totalCost = totalCost + productPrice;
    }
    bill = bill + 'Tổng cộng: ${totalCost} VNĐ';
    return RichText(
      softWrap: true,
      text: TextSpan(
        style: TextStyle(
          fontSize: 15,
          color: Colors.black),
        children: [
          TextSpan(text: '${bill}'),
        ],
      ),
    );
  }
  
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Thanh toán'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: ListView(
          children: <Widget>[
            showBill(),
            TextField(
              controller: address,
              style: new TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Nhập địa chỉ gửi hàng',
                labelStyle: TextStyle(),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColorDark,
              textColor: Theme.of(context).primaryColorLight,
              child: Text('Xác nhận thanh toán'),
              onPressed: (){
                String mes;
                if (address.text == null){
                  mes = 'Bạn chưa nhập địa chỉ giao hàng';
                }else{
                  mes = 'Chúng tôi đã nhận đơn hàng của bạn. Bạn sẽ nhận hàng tại địa chỉ ${address.text} trong khoảng 2 ngày nữa';
                }
                showDialog(
                  context: context,
                  child: SimpleDialog(
                    title: Text("Thông báo"),
                    children: <Widget>[
                      Text(mes),
                    ],
                  ),
                );
              },
            ),
            
          ],
        ),
      ),
    );
  }
}