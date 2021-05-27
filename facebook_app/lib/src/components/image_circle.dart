import 'dart:math';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageCircle extends StatelessWidget {
  final String url;
  final Function onTap;

  const ImageCircle(this.url, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: Container(
          width: 48.0,
          height: 48.0,
          child: FadeInImage(
            placeholder: AssetImage('assets/images/avatar_default.jpg'),
            image: url.isNotEmpty
                ? NetworkImage(url)
                : AssetImage("assets/images/avatar_default.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
