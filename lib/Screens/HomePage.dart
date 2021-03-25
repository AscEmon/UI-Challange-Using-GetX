import 'package:Uparjon/Screens/RotateScreen.dart';
import 'package:Uparjon/controller/JobController.dart';
import 'package:Uparjon/Utilites/CustomCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final JobController jobController = Get.put(JobController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          endDrawer: Drawer(),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Color(0xff34A798),
                actions: [
                  // GestureDetector(
                  //   onTap: (){
                  //     Navigator.push(context,MaterialPageRoute(builder: (context) => RotationScene(),));
                  //   },
                  //   child: Text("Goto next Page"))
                ],
                title: Row(
                  children: [
                    Image.asset(
                      "images/uparjon_icon.png",
                      width: 30,
                      height: 60,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Uparjon")
                  ],
                ),
                pinned: true,
                expandedHeight: 330,
                flexibleSpace: FlexibleSpaceBar(
                  background: Center(child: RotationScene()),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate(
                <Widget>[
                 
                 Container(
                    height: 300,
                    color: Colors.white24,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            
                            CustomCard(
                              cardNo: 1,
                              iconData: Icons.money,
                              text: "Savings",
                            ),
                              CustomCard(
                              cardNo: 2,
                              iconData: Icons.wallet_membership,
                              text: "Wallet",
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            
                            CustomCard(
                              cardNo: 3,
                              iconData: Icons.card_giftcard,
                              text: "Gift Card",
                            ),
                              CustomCard(
                              cardNo: 4,
                              iconData: Icons.perm_device_information_outlined,
                              text: "Information",
                            ),
                          ],
                        ),

                      ],
                    )
                  ),
                  Container(
                    height: 300,
                    color: Colors.white70,
                    child: Center(child: Text("UpComing.....")),
                  ),
                ],
              )),
            ],
          )),
    );
  }
}
