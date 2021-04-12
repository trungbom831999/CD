import 'package:flutter/material.dart';

class BlackBackgroundShowImage extends StatelessWidget {
  final String pathImage;

  BlackBackgroundShowImage(this.pathImage);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.black,
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: NetworkImage(pathImage),
              ),
            ),
          )
          // SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
