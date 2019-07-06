import 'dart:convert';

import 'package:flutter/material.dart';
import './main.dart';
import './signin.dart';
import 'package:http/http.dart' as http;
import './vendor_management.dart';


class Login extends StatefulWidget {

  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {

  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameOfCompany = TextEditingController();
  String dropdownvalue = 'Khách hàng';
  String message = '';
  var initValue = new Map();

  Widget takeNameOfCompany(){
    initValue['name'] = '';
    initValue['producer'] = '';
    initValue['price'] = '';
    initValue['numOfProduct'] = '';
    if (dropdownvalue == 'Doanh nghiệp'){
      return Padding(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: TextField(
          controller: nameOfCompany,
          style: new TextStyle(color: Colors.black),
          decoration: InputDecoration(
            labelStyle: TextStyle(),
            labelText: 'Tên doanh nghiệp',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5)
            )
          ),
        ),
      );
    }else{
      return Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đăng nhập"),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            //account
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
              child: TextField(
                controller: accountController,
                style: new TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelText: 'Tên tài khoản',
                    labelStyle: TextStyle(),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),

            //password
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: passwordController,
                style: new TextStyle(color: Colors.black),
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),

            //vendor or client
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Text('Bạn là:'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: DropdownButton<String>(
                value: dropdownvalue,
                onChanged: (String newvalue){
                  setState(() {
                   dropdownvalue = newvalue; 
                  });
                },
                items: <String>['Khách hàng','Doanh nghiệp']
                .map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem<String>(
                    value:  value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),

            //name of company
            takeNameOfCompany(),

            //login button
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: RaisedButton(
                color: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).primaryColorLight,
                child: Text(
                  'Đăng nhập',
                  textScaleFactor: 1.5,
                ),
                onPressed: () async{
                  String typeOfCus;
                  if (dropdownvalue == 'Khách hàng'){
                    typeOfCus = 'client';
                  }else{
                    typeOfCus = 'vendor';
                  }
                  final response =await http.post("http://192.168.137.1/flutter_server/flutter_login.php", body:{
                    "account": accountController.text,
                    "password": passwordController.text, 
                    "type": typeOfCus,
                    "company": nameOfCompany.text,
                  });
                  //print(nameOfCompany.text);
                  var data = json.decode(response.body);
                  if (data.isEmpty){
                    message = 'Đăng nhập thất bại!';
                  }else{
                    if (typeOfCus == 'client'){
                      Navigator.of(context).pop();
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return HomePage(
                          accountName: accountController.text,
                          cart: [initValue],
                        );
                      }));
                    }else{
                      Navigator.of(context).pop();
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return VendorManagement(
                         producer: nameOfCompany.text,
                         admin: accountController.text,
                        ); 
                      }));
                    }
                  }
                },
              ),             
            ),

            //Login status
            Text(message, style: TextStyle(fontSize: 14.0, color: Colors.red),),

            //Info for Sign in navigation
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Text("Nếu bạn chưa có tài khoản, xin mời đăng ký"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: RaisedButton(
                color: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).primaryColorLight,
                child: Text(
                  'Đăng ký',
                  textScaleFactor: 1.5,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()
                  ));
                },
              ),
            ),          
          ],
        ),
      ),
    );
  }
}
