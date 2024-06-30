import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled5/modules/gallery/page_view_holder.dart';


class View extends StatefulWidget {
  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  late PageViewHolder holder;
  late PageController _controller;
  double fraction = 0.50;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    holder = PageViewHolder(value: 2.0);
    _controller = PageController(initialPage: 2, viewportFraction: fraction);
    _controller.addListener(() {
      holder.setValue(_controller.page);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Perspective PageView"),
        ),
        body: Container(
          child: Center(
            child: AspectRatio(
              aspectRatio: 1,
              child: ChangeNotifierProvider<PageViewHolder>.value(
                value: holder,
                child: PageView.builder(
                    controller: _controller,
                    itemCount: 12,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return MyPageApp(number: index.toDouble(), fraction: fraction);
                    }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyPageApp extends StatelessWidget {
  final double number;
  final double fraction;

  MyPageApp({required this.number, required this.fraction});

  @override
  Widget build(BuildContext context) {
    double value = Provider.of<PageViewHolder>(context).value;
    double diff = (number - value);

    //Matrix for Elements
    final Matrix4 pvMatrix = Matrix4.identity()
      ..setEntry(3, 3, 1 / 0.9) // Increasing Scale by 90%
      ..setEntry(1, 1, fraction) // Changing Scale Along Y Axis
      ..setEntry(3, 0, 0.004 * -diff); // Changing Perspective Along X Axis

    //Matrix for Shadow
    final Matrix4 shadowMatrix = Matrix4.identity()
      ..setEntry(3, 3, 1 / 1.6) // Increasing Scale by 60%
      ..setEntry(3, 1, -0.004) //Changing Perspective along Y-Axis
      ..setEntry(3, 0, 0.002 * diff) // Changing Perspective along X Axis
      ..rotateX(1.309); //Rotating Shadow along X Axis

    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: <Widget>[
        if(diff<=1.0 && diff >= -1.0) ... [
          AnimatedOpacity(
            duration: Duration(milliseconds: 100),
            opacity: 1-diff.abs(),
            child: Transform(
              transform: shadowMatrix,
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 10.0, spreadRadius: 1.0)
                ]),
              ),
            ),
          ),
        ],
        Transform(
          transform: pvMatrix,
          alignment: FractionalOffset.center,
          child: Container(
            child: Image.asset(
              "images/image_${number.toInt() + 1}.jpg",
              fit: BoxFit.fill,
            ),
          ),
        )
      ],
    );
  }
}
