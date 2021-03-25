import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  int cardNo;
  IconData iconData;
  String text;
  CustomCard({Key key,this.cardNo,this.iconData,this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    height: 120,
    width: 120,
    decoration: BoxDecoration( 
     color: cardNo ==1?Colors.blueGrey:cardNo ==2?Colors.teal:cardNo==3?Colors.purple:Colors.brown,
     borderRadius: BorderRadius.all(Radius.circular(32)),
      boxShadow: [BoxShadow(
      color: Colors.grey,
      blurRadius: 16.0,
     ),]
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          SizedBox(
          height: 16,
        ),
        Icon(
          iconData,
          size: 36,
          color: Colors.white,
        ),
        SizedBox(
          height: 8,
        ),
        Text(text,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight:FontWeight.bold),)
      ],
    ),
      );
  }
}