/// FileName welcome
///
/// @Author LinGuanYu
/// @Date 2023/3/7 14:33
///
/// @Description TODO 欢迎页面 用于展示广告啥的

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_book_code/pages/home/home_main_page.dart';
import 'package:flutter_book_code/utils/log_util.dart';
import 'package:flutter_book_code/utils/navigator_utils.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  ///时间计时器
  Timer? timer;
  ///初始的时间
  double progress = 1000;
  ///倒计时时间
  double totalProgress = 6000;
  ///AnimatedContainer的装饰的阴影的宽度
  double borderWidth = 1.0;

  @override
  void initState() {
    super.initState();
    ///初始化时间计时器
    ///每100毫秒执行一次
    timer = Timer.periodic(const Duration(milliseconds: 100), (time) {
      ///进度每次累加100，
      progress += 100;
      ///每一秒进行一次
      ///AnimatedContainer的装饰的阴影的高度的修改
      if (progress % 1000 == 0) {
        if (borderWidth == 1.0) {
          borderWidth = 8.0;
        } else {
          borderWidth = 1.0;
        }
      }
      ///计时完成后进入首页面
      if (progress >= totalProgress) {
        timer?.cancel();
        goHome();
      }
      LogUtil.e("定时器 $progress");
      setState(() {});
    });
  }

  @override
  void dispose() {
    if (timer != null) {
      timer?.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            ///放置背景图片
            buildBackgroundImage(),

            ///右上角的时间
            buildTimerProgress(),
          ],
        ),
      ),
    );
  }

  buildBackgroundImage() {
    return Positioned(
      right: 0,
      bottom: 0,
      top: 0,
      left: 0,
      child: Image.asset("assets/images/3.0x/welcome.png"),
    );
  }

  buildTimerProgress() {
    return Positioned(
      right: 20,
      top: 60,
      child: InkWell(
        onTap: () {
          goHome();
        },
        child: buildAnimatedContainer(),
      ),
    );
  }

  buildAnimatedContainer() {
    return AnimatedContainer(
      duration: const Duration(microseconds: 1000),
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              blurRadius: borderWidth
            )
          ],
          border: Border.all(color: Colors.grey, width: 2)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: progress/totalProgress,
          ),
          Text("${progress ~/1000}",style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  goHome() {
    NavigatorUtils.openPageByFade(context, HomeMainPage(), isReplace: true);
  }
}
