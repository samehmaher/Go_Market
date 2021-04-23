import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_market/item_screen.dart';
class HomeCard extends StatelessWidget {
  HomeCard({
    this.name,this.description,this.money,this.rate,this.time
  });
  // final IconData rateIcon ;
  // final Color rateColor ;
  final String name , description , rate , money ;
  final int time;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ItemScreen()));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: EdgeInsets.all(15),
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage('https://lh3.googleusercontent.com/proxy/9Z16Bv2TxWYQ50GUCqDeXltN2xnH3USyGtnoXbuWXdWDtICYIRGpwJd49Eq4Kmh4UNHtPefRWVufQ0tnYgBIzd9fCmH1J3lDZGBTbLMdHViTCkf4WN2ZaSS2Xep9EmZNPAI'),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                width: 80,
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15 ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 20,),
                        Container(
                          width: 50,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                            BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Center(
                            child: Text(
                              'close',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 11),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:10,),
                    Text(
                      description,
                      style: TextStyle(
                          color: Colors.grey, fontSize: 13),
                    ),
                    SizedBox(height:10,),
                    Row(
                      children: [
                        Icon(FontAwesomeIcons.smile,
                            size: 11, color: Colors.grey),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          rate,
                          style: TextStyle(
                              color: Colors.black, fontSize: 11),
                        ),
                      ],
                    ),
                    SizedBox(height:10,),
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.clock,
                              size: 11,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              '$time min',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 11),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [
                            Icon(FontAwesomeIcons.motorcycle,
                                size: 11, color: Colors.grey),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              money,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 11),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
