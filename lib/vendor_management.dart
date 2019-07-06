import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './display_product.dart';
import './uploadInfo.dart';
import './drawer_company.dart';

class VendorManagement extends StatefulWidget{
  VendorManagement({
    this.producer, 
    this.admin});
  final String producer;
  final String admin;
  @override
  _VendorManagement createState() => _VendorManagement(
    producer: producer,
    admin: admin,
  );
}
class _VendorManagement extends State<VendorManagement>{
  _VendorManagement({
    this.producer,
    this.admin,
  });
  final String admin;
  final String producer;
  var category = 'Quần áo';
  var data = [];

  

  Widget build(BuildContext context){
    Future viewProducts() async{
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
      final response = await http.post("http://192.168.137.1/flutter_server/flutter_retrieveProduct.php",
      body: {
        "category": cat,
        "producer": producer,
      });
      data = json.decode(response.body);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý doanh nghiệp'),
      ),

      drawer: DrawerProducer(
        producer: producer,
        admin: admin,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: ListView(
          children: <Widget>[
            Text('Tên doanh nghiệp: ${producer}', textScaleFactor: 1.5),
            //choose category
            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Text('Loại sản phẩm'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: DropdownButton<String>(
                value: category,
                onChanged: (String newvalue){
                  setState(() {
                    category = newvalue; 
                  });
                },
                items: <String>['Quần áo','Giày dép','Đồ gia dụng','Xà bông','Smartphone']
                .map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: RaisedButton(
                color: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).primaryColorLight,
                child: Text('Thêm sản phẩm', textScaleFactor: 1.5,),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UploadInfo(
                    producer: producer,
                  )));
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: RaisedButton(
                color: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).primaryColorLight,
                child: Text('Xem sản phẩm', textScaleFactor: 1.5),
                onPressed: () {
                  viewProducts();
                },
              ),
            ),

            displayProducts(data,producer,category),
            
          ],
        ),
      ),
    );
  }
}