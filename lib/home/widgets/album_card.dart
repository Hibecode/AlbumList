

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget card(BuildContext context, String text, String url){
  return Container(
    padding:EdgeInsets.all(10),
    width: (MediaQuery.of(context).size.width - 60) / 2,
    height: 160,
    decoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.circular(3.9),
    ),
    child: Column(
      children: [
        Image.network(url),
        SizedBox(height: 8,),
        Text(text, style: TextStyle(fontSize: 14),),
      ],
    ),
  );
}