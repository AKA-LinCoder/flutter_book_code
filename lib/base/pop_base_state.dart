import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// FileName pop_base_state
///
/// @Author LinGuanYu
/// @Date 2023/3/5 18:25
///
/// @Description TODO

abstract class PopBaseState <T extends StatefulWidget> extends State<T> {
  @override
  void initState() {
    super.initState();

    ///状态栏的全透明沉浸
    SystemUiOverlayStyle systemUiOverlayStyle =
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    ///显示顶部的状态栏
    ///这个方法也可把状态栏和虚拟按键隐藏掉
    ///   SystemUiOverlay.top 状态栏
    ///   SystemUiOverlay.bottom 底部的虚拟键盘
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);

  }
}
