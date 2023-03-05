import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/sp_key.dart';
import '../utils/sp_utils.dart';

/// FileName theme_notifier
///
/// @Author LinGuanYu
/// @Date 2023/3/5 15:40
///
/// @Description TODO 主题相关

///快速获取当前主题配置的全局方法
ThemeData? golbalCurrentTheme(BuildContext context) {
  return Provider.of<ThemeNotifier>(context, listen: false).currentThemeData;
}
//ChangeNotifier 消息监听者与notifyListeners()结合实现消息通信
//类似iOS中的notify与Android中的广播
class ThemeNotifier extends ChangeNotifier {
  ///亮色主题
  ///应用程序默认的主题
  final ThemeData lightTheme = ThemeData(brightness: Brightness.light,
      ///主背景色
      primaryColor: Colors.blue,
      ///Scaffold脚手架的背景色
      scaffoldBackgroundColor: const Color(0xffeeeeee),
      ///AppBar的样式
      appBarTheme: const AppBarTheme(elevation: 1.0,brightness: Brightness.dark, color: Color(0xff212f38),),
      ///底部弹框的样式
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Color(0x99999999), elevation: 1.0
      ));

  ///暗色主题
  final ThemeData dartTheme = ThemeData(brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xff212f38),
      appBarTheme: const AppBarTheme(elevation: 1.0),
      ///底部弹框的样式
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Color(0x50999999)
      ));
  ///灰色主题
  final ThemeData grayTheme = ThemeData(primaryColor: Colors.grey,
      ///底部弹框的样式
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Color(0x50999999)
      ));

  ///当前的主题色配制
  ThemeData? _currentThemeData;
  ///获取当前的主题色
  ThemeData? get currentThemeData=> _currentThemeData ?? lightTheme;

  ///主题切换
  void setThem(num? index) {
    switch (index) {
      case 0:
        _currentThemeData = dartTheme;
        break;
      case 1:
        _currentThemeData = lightTheme;
        break;
      case 2:
        _currentThemeData = grayTheme;
        break;
      default :
        _currentThemeData = lightTheme;
        break;
    }

    if(index==null){
      return;
    }
    ///使用 notifyListeners() 函数通知监听者以更新界面。
    notifyListeners();
    ///保存主题
    SPUtil.save(spUserThemeKey, index);
  }
}