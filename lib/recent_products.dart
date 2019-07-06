import 'package:flutter/material.dart';

class RecentProducts extends StatefulWidget {
  @override
  _RecentProducts createState() => _RecentProducts();
}

class _RecentProducts extends State<RecentProducts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 385.0,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Category(
            image_location: 'images/products/dienthoai_1.jpg',
            image_caption: 'Điện thoại Galaxy S4',
          ),
          Category(
            image_location: 'images/products/giaydep_1.jpg',
            image_caption: 'Dép kẹp nữ Ardene',
          ),
          Category(
            image_location: 'images/products/quanao_1.jpg',
            image_caption: 'Sơ mi nam Abercrombie',
          ),
          Category(
            image_location: 'images/products/xabong_1.jpg',
            image_caption: 'Dầu gội Head and Shoulder',
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;
  Category({this.image_location, this.image_caption});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {
          //debugPrint('${this.image_caption} was tapped');
        },
        child: Container(
          width: 100.0,
          child: ListTile(
            title: Image.asset(
              image_location,
              width: 258.0,
              height: 258.0,
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(image_caption, style: new TextStyle(fontSize: 16.0),),
            )
          ),
        ),
      ),
    );
  }
}
