import 'package:flutter/material.dart';
import 'package:flutter_book_code/widgets/shake/shake_animation_text.dart';

/// FileName index
///
/// @Author LinGuanYu
/// @Date 2023/3/5 16:04
///
/// @Description TODO 第一个页面，展示一个图片，在initState中异步开启一系列功能

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,right: 0,top: 0,bottom: 0,
              child: Image.asset("assets/images/3.0x/welcome.png",fit: BoxFit.fill,)),
          Container(
            color: const Color.fromARGB(155, 100, 100, 100),
          ),
          Center(
            child: ShakeTextAnimationWidget(
              animationString: "Hello World",
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: 'UniTortred'
              ),
            ),
          )
        ],
      ),
    );
  }
}
