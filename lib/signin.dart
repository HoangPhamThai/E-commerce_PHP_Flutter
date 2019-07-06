import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignIn extends StatefulWidget {
  @override
  _SignIn createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  TextEditingController nameController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameOfCompany = TextEditingController();
  String dropdownvalue = 'Khách hàng';
  String message = '';

  Widget takeNameOfCompany(){
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
        title: Text("Đăng ký"),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            //họ và tên
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
              child: TextField(
                controller: nameController,
                style: new TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelText: 'Họ và tên',
                    labelStyle: TextStyle(),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),

            //account
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
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

            //email
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: emailController,
                style: new TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),

            //phone
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: phoneController,
                style: new TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelText: 'Số điện thoại',
                    labelStyle: TextStyle(),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                keyboardType: TextInputType.number,
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

            //button
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: RaisedButton(
                color: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).primaryColorLight,
                child: Text(
                  'Đăng ký',
                  textScaleFactor: 1.5,
                ),
                onPressed: () async{
                  String typeOfCus;
                  if (dropdownvalue == 'Khách hàng'){
                    typeOfCus = 'client';
                  }else{
                    typeOfCus = 'vendor';
                  }
                  final response = await http.post("http://192.168.137.1/flutter_server/flutter_signin.php", body:{
                    "name":nameController.text,
                    "account":accountController.text,
                    "password":passwordController.text,
                    "email":emailController.text,
                    "phone":phoneController.text,
                    "type": typeOfCus,
                    "company": nameOfCompany.text,
                  });
                  var data = json.decode(response.body);
                  if (data == "1"){
                    message = 'Account hoặc email đã tồn tại!';
                  }else if (data == "0"){
                    message = '';
                    Navigator.pop(context);
                  }
                },
              ),
            ),
            Text(message, style: TextStyle(fontSize: 14.0, color: Colors.red),),
          ],
        ),
      ),
    );
  }
}
