

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Custom_Font{
  static const String fontFamily = 'Poppins-Bold';

  static const TextStyle regular = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.normal,
    color: Colors.white,
    fontSize: 30,


  );


  static const TextStyle buttom_text=TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.normal,
    color: Colors.white,
    fontSize: 18,


  );

  static const TextStyle bold = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.bold,
    fontSize: 60,
    color: Colors.white,
      shadows: [
        Shadow(
          color: Colors.blue, // Shadow color
          offset: Offset(4, 4), // Horizontal and vertical offset of the shadow
          blurRadius: 4,
        )
      ]
  );
}