import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../const.dart';
import '../widgets/back_icon_button.dart';
import '../widgets/category_widget.dart';
import 'FurnDetail.dart';

class DetailsPage extends StatefulWidget {
  final Offset catListOffset;
  final int selectedCat;
  final Function addAsFav;
  final Function remFav;

  const DetailsPage(
      {required this.catListOffset,
      required this.selectedCat,
      required this.addAsFav,
      required this.remFav});

  @override
  DetailsPageState createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage>
    with TickerProviderStateMixin {
  int selectedCat = 0;
  int selectedColor = 0;
  int qty = 0;
  bool showDragWidget = false;
  Offset dragOffset = const Offset(0, 0);
  double targetDistance = 0.0;

  late AnimationController _imagePulseController;
  late AnimationController _qtyPulseController;

  GlobalKey fabKey = GlobalKey();
  GlobalKey imageKey = GlobalKey();

  Offset fabOffset() => (fabKey.currentContext!.findRenderObject() as RenderBox)
      .localToGlobal(Offset.zero);

  Offset imageOffset() =>
      (imageKey.currentContext!.findRenderObject() as RenderBox)
          .localToGlobal(Offset.zero);

  _onLongPressStart(LongPressStartDetails details) {
    setState(() {
      dragOffset = Offset(imageOffset().dx - 30, imageOffset().dy - 180);
      showDragWidget = true;
      qty = 0;
    });
  }

  _onLongPressEnd(LongPressEndDetails details) {
    if (targetDistance > 80) {
      targetDistance = 140;
      dragOffset = Offset(fabOffset().dx - 85, fabOffset().dy - 270);
      addQty();
    } else {
      targetDistance = 0;
      dragOffset = Offset(imageOffset().dx, imageOffset().dy - 192);
      setState(() {});
    }

    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        showDragWidget = false;
        targetDistance = 0;
      });
    });
  }

  _onLongPressMoveUpdate(LongPressMoveUpdateDetails details) {
    var position = details.globalPosition;
    setState(() {
      dragOffset = Offset(position.dx - 100, position.dy - 192);
    });

    double offDistance = (dragOffset - fabOffset()).distance;

    if (offDistance < 400 && offDistance > 250) {
      targetDistance = (400.0 - offDistance);
    }
  }

  addQty() async {
    setState(() {
      qty = 1;
    });
    await Future.delayed(const Duration(seconds: 1));
    _qtyPulseController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _qtyPulseController.reverse();
  }

  @override
  void initState() {
    super.initState();
    selectedCat = widget.selectedCat;
    _imagePulseController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _qtyPulseController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Stack(
          children: [
            TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 600),
                tween: Tween(begin: 1, end: 0),
                builder: (context, double value, _) {
                  return Hero(
                      tag: 'blue_card',
                      child: Material(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(value * 15),
                          ),
                        ),
                      ));
                }),
            const BackIconButton(),
            Positioned(
              top: 80,
              child: categoryWithoutTag(),
            ),
            Positioned(
              top: 190,
              right: 0,
              left: 0,
              bottom: 0,
              child: SlideInUp(
                delay: const Duration(milliseconds: 1200),
                duration: const Duration(milliseconds: 600),
                from: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35.0),
                          topRight: Radius.circular(35.0),
                        ),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              height: 4,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  ScaleTransition(
                                    scale: Tween<double>(
                                      begin: 1.0,
                                      end: 1.2,
                                    ).animate(_imagePulseController),
                                    child: GestureDetector(
                                      onLongPressStart: _onLongPressStart,
                                      onLongPressEnd: _onLongPressEnd,
                                      onLongPressMoveUpdate:
                                          _onLongPressMoveUpdate,
                                      child: Container(
                                        height: 230,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: furnData.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                child: Hero(
                                                  tag: furnData[index].name,
                                                  child: Image.asset(
                                                      furnData[index].source,
                                                      width: 200,
                                                      height: 100,
                                                      fit: BoxFit.cover),
                                                ),
                                                onTap: () =>
                                                    Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        FurnDetail(
                                                      furnDataModel:
                                                          furnData[index],
                                                      togFav: widget.addAsFav,
                                                      delFav: widget.remFav,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: SizedBox(
                        height: 120,
                        width: 120,
                        child: Stack(
                          key: fabKey,
                          alignment: AlignmentDirectional.center,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 60 + targetDistance,
                              height: 60 + targetDistance,
                              transform: Matrix4.rotationZ(
                                  targetDistance * math.pi / 90),
                              transformAlignment: Alignment.center,
                            ),
                            Positioned(
                              right: 24,
                              top: 24,
                              child: AnimatedOpacity(
                                opacity: qty > 0 ? 1 : 0,
                                duration: Duration(
                                    milliseconds: qty > 0 ? 1000 : 100),
                                curve: Curves.easeIn,
                                child: ScaleTransition(
                                  scale: Tween<double>(
                                    begin: 1.0,
                                    end: 1.4,
                                  ).animate(_qtyPulseController),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 400),
                                    height: qty > 0 ? 16 : 1,
                                    width: qty > 0 ? 16 : 1,
                                    transform: Matrix4.rotationZ(
                                        targetDistance < 100
                                            ? 0
                                            : -50 * math.pi / 90),
                                    transformAlignment: Alignment.centerRight,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.purple,
                                    ),
                                    child: Center(
                                      child: Text(
                                        qty.toString(),
                                        style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget categoryWithTag() {
    return FadeOut(
      child: Hero(
        tag: "cat",
        child: Material(
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: SizedBox(
              height: 90,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: categories.length,
                padding: const EdgeInsets.only(left: 5),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CategoryWidget(
                      category: categories[index],
                      isSelected: selectedCat == index,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget categoryWithoutTag() {
    return SizedBox(
      height: 90,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: categories.length,
        padding: const EdgeInsets.only(left: 5),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return SlideInUp(
            key: Key(index.toString()),
            delay: Duration(milliseconds: 200 + (100 * index)),
            from: widget.catListOffset.dy - 80,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedCat = index;
                  });
                },
                child: CategoryWidget(
                  category: categories[index],
                  isSelected: selectedCat == index,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
