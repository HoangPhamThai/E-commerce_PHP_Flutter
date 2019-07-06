import 'package:flutter/material.dart';


//drawer of VendorManagement widget
class DrawerProducer extends StatelessWidget{
  DrawerProducer({this.producer, this.admin,});
  final String admin;
  final String producer;

  @override
  Widget build(BuildContext context){
    return Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: Text('Doanh nghiệp: '+ producer),
            accountEmail: Text('Admin: '+admin),
            currentAccountPicture: GestureDetector(
              child: new CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white,),
              ),
            ),
            decoration: new BoxDecoration(
              color: Colors.blue
            ),
          ),
        ],
      ),
    );
  }
}