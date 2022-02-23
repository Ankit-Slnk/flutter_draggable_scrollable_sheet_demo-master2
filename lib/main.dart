import 'package:bottom_sheet/utility/appAssets.dart';
import 'package:bottom_sheet/utility/utility.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double extent = 0;
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: body(),
    );
  }

  Widget body() {
    print("extent");
    print(extent);
    return Stack(
      children: [
        Utility.imageLoader(
          "https://picsum.photos/200/300",
          AppAssets.placeHolder,
        ),
        SizedBox.expand(
          child: NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              if (mounted)
                setState(() {
                  extent = notification.extent;
                });
            },
            child: DraggableScrollableSheet(
              initialChildSize: 0.1,
              minChildSize: 0.1,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    controller: scrollController,
                    child: Column(
                      children: [
                        AnimatedOpacity(
                          opacity: isVisible ? 1 : 0,
                          curve: Curves.easeInOut,
                          duration: Duration(milliseconds: 500),
                          child: AnimatedContainer(
                            height: extent > 0.2
                                ? 0
                                : MediaQuery.of(context).size.height * 0.0897,
                            duration: Duration(milliseconds: 500),
                            color: Colors.white,
                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.height *
                                      0.0897,
                                  child: Utility.imageLoader(
                                    "https://picsum.photos/200/300",
                                    AppAssets.placeHolder,
                                  ),
                                ),
                                Spacer(),
                                AnimatedOpacity(
                                  opacity: extent > 0.2 ? 0 : 1,
                                  curve: Curves.easeInOut,
                                  duration: Duration(milliseconds: 500),
                                  child: Container(
                                    margin: EdgeInsets.all(16),
                                    child: GestureDetector(
                                      child: Icon(
                                        Icons.arrow_drop_down_circle_rounded,
                                      ),
                                      onTap: () {
                                        isVisible = false;
                                        _notify();
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 1000,
                          width: 50,
                          color: Colors.red,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  _notify() {
    if (mounted) setState(() {});
  }
}
