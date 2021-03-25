import 'dart:math';
import 'dart:ui';
import 'package:Uparjon/controller/JobController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

int numItems = 3;
var onSelectCard = ValueNotifier<int>(0);

class RotationScene extends StatefulWidget {
  @override
  _RotationSceneState createState() => _RotationSceneState();
}

class _RotationSceneState extends State<RotationScene> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 320,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Color(0xff34A798),
                  spreadRadius: 10,
                  offset: Offset(0, 0),
                  blurRadius: 0)
            ],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(100),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              colors: [Color(0xff34A798), Color(0xff229389)],
              stops: [0, 1],
            )),
        child: Column(
          children: [
            SizedBox(
              height: 90,
            ),
            MyScener(),
          ],
        ),
      ),
    );
  }
}

class CardData {
  Color color;
  double x, y, z, angle;
  final int idx;

  Color get lightColor {
    var val = HSVColor.fromColor(color);
    return val.withSaturation(.1).withValue(.9).toColor();
  }

  CardData(this.idx) {
    color = Colors.primaries[idx % Colors.primaries.length];
    x = 0;
    y = 0;
    z = 0;
  }
}

class MyScener extends StatefulWidget {
  @override
  _MyScenerState createState() => _MyScenerState();
}

class _MyScenerState extends State<MyScener> with TickerProviderStateMixin {
  final JobController jobController = Get.put(JobController());
  AnimationController _scaleController;
  List<CardData> cardData = [];
  double radio = 100.0;
  double radioStep = 0;
  bool isMousePressed = false;
  double _dragX = 0;
  double selectedAngle = 0;

  @override
  void initState() {
    cardData = List.generate(numItems, (index) => CardData(index)).toList();
    radioStep = (pi * 2) / numItems;

    _scaleController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _scaleController.addListener(() => setState(() {}));

    onSelectCard.addListener(() {
      var idx = onSelectCard.value;
      _dragX = 0;
      selectedAngle = -idx * radioStep;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var initAngleOffset = pi / 2 + (-_dragX * .02);
    initAngleOffset += selectedAngle;

    // process positions.
    for (var i = 0; i < cardData.length; ++i) {
      var c = cardData[i];
      double ang = initAngleOffset + c.idx * radioStep;
      c.angle = ang + pi / 2;
      c.x = cos(ang) * radio;
      c.z = sin(ang) * radio;
    }

    // sort in Z axis.
    cardData.sort((a, b) => a.z.compareTo(b.z));

    var list = cardData.map((vo) {
      var alpha = ((1 - vo.z / radio) / 2) * .6;

      var c = Transform(
        alignment: Alignment.center,
        origin: Offset(0.0, 0),
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..translate(vo.x, vo.y, -vo.z)
          ..rotateY(vo.angle + pi),
        child: GestureDetector(
          onTap: () {
            print("print ${vo.idx}");
          },
          child: Container(
            margin: EdgeInsets.all(12),
            width: 150,
            height: 180,
            alignment: Alignment.center,
            foregroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black.withOpacity(alpha),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.1, .9],
                colors: [
                  vo.lightColor,
                  Colors.white,
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.2 + alpha * .2),
                    spreadRadius: 1,
                    blurRadius: 12,
                    offset: Offset(0, 2))
              ],
            ),
            child: Obx(() {
              if (jobController.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else
                return Container(
                    child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return vo.idx == 0
                              ? Center(
                                  child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10))),
                                      height: 25,
                                      width: Get.width,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [Text("Cash Balance",style: TextStyle(color: Colors.white),)],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      padding: EdgeInsets.all(30),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                              width: 2, color: Colors.red)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("৳"),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(jobController
                                              .categoryList.value.data[0].id),
                                        ],
                                      ),
                                    )
                                  ],
                                ))
                              : vo.idx == 1
                                  ? Center(
                                      child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.purple,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight:
                                                      Radius.circular(10))),
                                          height: 25,
                                          width: Get.width,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [Text("Reward Balance",style: TextStyle(color: Colors.white),)],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          padding: EdgeInsets.all(30),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              border: Border.all(
                                                  width: 2,
                                                  color: Colors.purple)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("৳"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(jobController.categoryList
                                                  .value.data[1].id),
                                            ],
                                          ),
                                        )
                                      ],
                                    ))
                                  : vo.idx == 2
                                      ? Center(
                                          child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10))),
                                              height: 25,
                                              width: Get.width,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text("Withdraw Balance",style: TextStyle(color: Colors.white),)
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              margin: EdgeInsets.all(10),
                                              padding: EdgeInsets.all(30),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  border: Border.all(
                                                      width: 2,
                                                      color: Colors.grey)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text("৳"),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(jobController
                                                      .categoryList
                                                      .value
                                                      .data[2]
                                                      .id),
                                                ],
                                              ),
                                            )
                                          ],
                                        ))
                                      : ("no data ");
                        }));
            }),
          ),
        ),
      );

      return c;
    }).toList();

    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanDown: (e) {
          isMousePressed = true;
          setState(() {});
          _scaleController.animateTo(1,
              duration: Duration(seconds: 2),
              curve: Curves.fastLinearToSlowEaseIn);
        },
        onPanUpdate: (e) {
          _dragX += e.delta.dx;
          setState(() {});
        },
        onPanEnd: (e) {
          isMousePressed = false;
          _scaleController.animateTo(0,
              duration: Duration(seconds: 2),
              curve: Curves.fastLinearToSlowEaseIn);
          setState(() {});
        },
        child: Container(
          alignment: Alignment.center,
          child: Stack(alignment: Alignment.center, children: list),
        ));
  }
}
