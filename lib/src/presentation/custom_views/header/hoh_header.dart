import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HoHHeader  extends StatelessWidget implements PreferredSizeWidget {


  HoHHeader({
    Key key,
  })  : preferredSize = Size.fromHeight(98),
        super(key: key){}

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 98,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Container(
              width: 270,
              height: 98,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage('assets/images/hoh.png')
                )
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 286,
            height: 98,
            decoration: BoxDecoration(
              color: Color(0xFF0667b1),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32)
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    blurRadius: 1,
                    offset: Offset(1,1)
                )
              ]
            ),
          )
        ],
      ),
    );
  }


  @override
  final Size preferredSize;


}