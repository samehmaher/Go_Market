import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  DrawerList({
    this.icon , this.text , this.onTap , this.color
  });
  final IconData icon;
  final String text;
  final Function onTap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon , color: color, size: 25,),
            SizedBox(width: 20,),
            Text(text , style: TextStyle(color: color , fontSize: 17),) ,
          ],
        ),
      ),
    );
  }
}
