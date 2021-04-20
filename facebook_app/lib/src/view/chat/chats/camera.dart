// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'dart:io';
// //
// // // void main() => runApp(AccessCamera());
// //
// // class AccessCamera extends StatefulWidget {
// //   @override
// //   _AccessCameraState createState() => _AccessCameraState();
// // }
// //
// // class _AccessCameraState extends State<AccessCamera> {
// //   File imageFile;
// //   //
// //   Widget showImageIfAvailable() {
// //     return imageFile == null
// //         ? Text('Please pick an image')
// //         : Image.file(
// //       imageFile,
// //       height: 300.0,
// //       fit: BoxFit.cover,
// //       alignment: Alignment.topCenter,
// //     );
// //   }
// //
// //   void getImage(ImageSource source) {
// //     //maxwidth : for not making image to be high resolution for preventing app from crash in some cases
// //     ImagePicker.pickImage(source: source, maxWidth: 400.0).then((File image) {
// //       setState(() {
// //         imageFile = image;
// //         //file path in memory
// //         print('hello $imageFile');
// //       });
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     Color defaultColor = Theme.of(context).accentColor;
// //     return MaterialApp(
// //       home: Scaffold(
// //           appBar: AppBar(
// //             title: Text(''),
// //           ),
// //           body: Center(
// //             child: Container(
// //               width: 300.0,
// //               child: Column(
// //                 children: <Widget>[
// //                   OutlineButton(
// //                     borderSide: BorderSide(
// //                       color: defaultColor,
// //                       width: 2.0,
// //                     ),
// //                     onPressed: () {
// //                       getImage(ImageSource.camera);
// //                     },
// //                     child: Row(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: <Widget>[
// //                         Icon(
// //                           Icons.camera_alt,
// //                           color: defaultColor,
// //                         ),
// //                         SizedBox(
// //                           width: 10.0,
// //                         ),
// //                         Text(
// //                           'Add Camera Image',
// //                           style: TextStyle(
// //                             color: defaultColor,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   OutlineButton(
// //                     borderSide: BorderSide(
// //                       color: defaultColor,
// //                       width: 2.0,
// //                     ),
// //                     onPressed: () {
// //                       getImage(ImageSource.gallery);
// //                     },
// //                     child: Row(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: <Widget>[
// //                         Icon(
// //                           Icons.camera_alt,
// //                           color: defaultColor,
// //                         ),
// //                         SizedBox(
// //                           width: 10.0,
// //                         ),
// //                         Text(
// //                           'Choose from gallery',
// //                           style: TextStyle(
// //                             color: defaultColor,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   SizedBox(
// //                     height: 30.0,
// //                   ),
// //                   // showImageIfAvailable(),
// //
// //                   //   showImageIfAvailable,
// //                 ],
// //               ),
// //             ),
// //           )),
// //     );
// //   }
// // }
//
//
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

// void main() {
//   runApp(new MaterialApp(
//     title: 'CAMERA',
//     home: new Camera(),
//   ));
// }

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  File imageFile;
  final _picker = ImagePicker();

  Future<void> _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Choose Your Option"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Open Gallery"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(12.0)),
                  GestureDetector(
                    child: Text("Open Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _imageView(),
            RaisedButton(
              onPressed: () {
                _openCamera(context);
              },
              child: Text('Click Me !!'),
            )
          ],
        ),
      ),
    );
  }

  void _openGallery(BuildContext context) async {
    final picture = await _picker.getImage(source: ImageSource.gallery);
    this.setState(() {
      if (picture != null) {
        imageFile = File(picture.path);
      } else {
        print('No image selected.');
      }
    });

    Navigator.of(context).pop();
  }

  void _openCamera(BuildContext context) async {
    final camPicture = await _picker.getImage(source: ImageSource.camera);
    this.setState(() {
      if (camPicture != null) {
        imageFile = File(camPicture.path);
      } else {
        print('No image selected.');
      }
    });

    Navigator.of(context).pop();
  }

  Widget _imageView() {
    if (imageFile == null) {
      return Text("No Image Selected");
    } else {
      return Image.file(imageFile, width: 400, height: 400);
    }
  }
}


