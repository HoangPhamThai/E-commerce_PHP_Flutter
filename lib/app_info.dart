import 'package:flutter/material.dart';

class AppInfo extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin'),
      ),
      body: RichText(
        softWrap: true,
        text: TextSpan(
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
          children: [
            TextSpan(text: 'Sản phẩm này là đồ án mô phỏng - dự án tin học của nhóm sinh viên VP2015, ĐHBK TPHCM.'),
          ],
        ),
      ),
    );
  }
}