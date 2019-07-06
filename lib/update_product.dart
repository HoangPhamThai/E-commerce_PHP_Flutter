import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import "package:image/image.dart" as Img;
import 'dart:math' as Math;

class UpdateProduct extends StatefulWidget{
  UpdateProduct({
    this.id,
    this.producer,
    this.image,
  });
  final String producer;
  final String id;
  final String image;
  @override
  _UpdateProduct createState() => _UpdateProduct(
    id: id,
    producer: producer,
    oldImage: image,
  );
}

class _UpdateProduct extends State<UpdateProduct>{
  _UpdateProduct({
    this.id,
    this.producer,
    this.oldImage,
  });
  final String id;
  final String producer;
  final String oldImage;
  TextEditingController nameUpdate = TextEditingController();
  TextEditingController priceUpdate = TextEditingController();
  TextEditingController descriptionUpdate = TextEditingController();
  File _image;
  String dropdownvalue = 'Quần áo';

  @override
  Widget build(BuildContext context){
    //Handle choosing action
    Future imageSelectorGallery() async{
      var galleryfile = await ImagePicker.pickImage(
        source: ImageSource.gallery,
      );
      var compressedImg;
      if (galleryfile != null){
        final tempDir = await getTemporaryDirectory();
        final path = tempDir.path;
        int rand = new Math.Random().nextInt(100000);
        Img.Image image = Img.decodeImage(galleryfile.readAsBytesSync());
        Img.Image smallerImg = Img.copyResize(image, 300);

        compressedImg = new File("$path/image_$rand.jpg")
        ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));
      }
      
      setState(() {       
        _image = compressedImg;
      });
    }

    Future imageSelectorCamera() async {
      var camerafile = await ImagePicker.pickImage(
        source: ImageSource.camera,
      );
      final tempDir = await getTemporaryDirectory();
      final path = tempDir.path;
      int rand = new Math.Random().nextInt(100000);
      Img.Image image = Img.decodeImage(camerafile.readAsBytesSync());
      Img.Image smallerImg = Img.copyResize(image, 300);

      var compressedImg = new File("$path/image_$rand.jpg")
      ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));

      setState(() {
        _image = compressedImg;
      });
    }

    Future update(File imageFile) async{
      var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();
      var uri = Uri.parse("http://192.168.137.1/flutter_server/flutter_updateProduct.php");
      var request = new http.MultipartRequest("POST", uri);
      var category;
      String announcement;
      if (dropdownvalue == "Quần áo"){
        category = 'quanao';
      }else if(dropdownvalue == "Giày dép"){
        category = 'giaydep';
      }else if(dropdownvalue == "Đồ gia dụng"){
        category = 'dogiadung';
      }else if(dropdownvalue == "Xà bông"){
        category = 'xabong';
      }else{
        category = 'smartphone';
      }
      request.fields['id'] = id.toString();
      request.fields['category'] = category;
      request.fields['name'] = nameUpdate.text;
      request.fields['description'] = descriptionUpdate.text;
      request.fields['price'] = priceUpdate.text;
      request.fields['oldImage'] = oldImage;
      var multipartFile = new http.MultipartFile("image", stream, length, filename: basename(imageFile.path));
      request.files.add(multipartFile);

      var response = await request.send();
      if (response.statusCode == 200){
        //print('image uploaded');
        announcement = 'Đã update sản phẩm';
      }else{
        //print('upload failed');
        announcement = 'Bị lỗi, xin update lại';
      }

      await showDialog(
        context: context,
        child: new SimpleDialog(
          title: Text('Thông báo'),
          children: <Widget>[
            Center(
              child: Text(announcement)), 
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Update sản phẩm"),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            //Name of product
            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Text('Nhập tên sản phẩm:', textScaleFactor: 1.5),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
              child: TextField(
                controller: nameUpdate,
                style:  new TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelStyle: TextStyle(),
                  labelText: 'Tên sản phẩm',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Text('Nhà sản xuất: ${producer}', textScaleFactor: 1.5),
            ),

            //Type of product
            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Text('Loại sản phẩm:', textScaleFactor: 1.5),
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
                items: <String>['Quần áo','Giày dép','Đồ gia dụng','Xà bông','Smartphone']
                .map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),

            //Description of product
            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Text('Đặc tả sản phẩm:', textScaleFactor: 1.5),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
              child: TextField(
                controller: descriptionUpdate,
                style:  new TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelStyle: TextStyle(),
                  labelText: 'Đặc tả sản phẩm',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),

            //Price of product
            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Text('Giá sản phẩm:', textScaleFactor: 1.5),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: TextField(
                controller: priceUpdate,
                style:  new TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelStyle: TextStyle(),
                  labelText: 'Giá sản phẩm',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),

            //Choose product's image
            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Text('Chọn ảnh sản phẩm', textScaleFactor: 1.5),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    child: Text('Tải ảnh lên', textScaleFactor: 1.5,),
                    onPressed: imageSelectorGallery,
                  ),

                  RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    child: Text('Chụp ảnh', textScaleFactor: 1.5,),
                    onPressed: imageSelectorCamera,
                  ),               
                ],
              ),
            ),
            
            Padding(
              padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
              child: displaySelectedFile(),
            ),

            //Action buttons
            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 10.0),
              child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text("Xong", textScaleFactor: 1.5,),
                      onPressed: () async{
                        update(_image);
                      },
                    ),
            ),
          ],
        ),
      )
    );
  }

  //display the chosen image
  Widget displaySelectedFile(){
    return new SizedBox(
      height: 200.0,
      width: 300.0,
      child: _image==null
        ? new Text('Không có ảnh đươc chọn')
        : new Image.file(_image),
    );
  }
}