import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_market/component/drawer_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_market/component/home_card.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'component/background_Image.dart';
import 'component/style.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var spinner = false;
  var _fireStore = FirebaseFirestore.instance;
  var _auth = FirebaseAuth.instance;
  ScrollController scrollController=new ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Go Market',
            style: kBodyText,
          ),
          backgroundColor: Colors.black12,
        ),
        drawer: ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(35), bottomRight: Radius.circular(35)),
          child: Drawer(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.all(12),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 35,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Center(
                        child: Text(
                      'Go Market',
                      style: TextStyle(fontSize: 50, color: Colors.black),
                    )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DrawerList(
                    text: 'Sign Out',
                    onTap: () async {
                      _auth.signOut();
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      pref.remove('email');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    icon: Icons.login_outlined,
                    color: Colors.black,
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Copyright © 2021 Go Market \nAll Rights Reserved \nVersion 1.0',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            BackgroundImage(
              image: 'assets/login_bg.png',
            ),
            Builder(
              builder: (context) => ModalProgressHUD(
                inAsyncCall: spinner,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _fireStore.collection('home').snapshots(),
                  builder: (context, snapshot){
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    var snap = snapshot.data.docs;
                    List<HomeCard> cardList = [];
                    for (var item in snap) {
                      String name = item.data()['name'];
                      String description = item.data()['description'];
                      String rate = item.data()['rate'];
                      String money = item.data()['money'];
                      int time = item.data()['time'];
                      // Color rateColor = item.data()['rateColor'];
                      // IconData rateIcon = item.data()['rateIcon'];


                      var itemList = HomeCard(
                        name: name,
                        description: description,
                        money: money,
                        rate: rate,
                        // rateColor: rateColor,
                        // rateIcon: rateIcon,
                        time: time,
                      );
                      cardList.add(itemList);
                    }
                    return ListView.builder(
                      controller: scrollController,
                      itemCount:cardList.length ,
                      itemBuilder:(context,index){
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (scrollController.hasClients){
                            scrollController.jumpTo(scrollController.position.maxScrollExtent);
                          }
                        });
                        return cardList[index];
                      } ,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

