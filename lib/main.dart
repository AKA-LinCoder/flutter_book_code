import 'package:flutter/material.dart';
import 'package:flutter_book_code/themes/locale_notifier.dart';
import 'package:flutter_book_code/themes/theme_notifier.dart';
import 'package:provider/provider.dart';

import 'app_root.dart';

///程序入口
void main() {
  //启动根目录
  runApp(const RootApp());
  //自定义报错页面
  ErrorWidget.builder = (errorDetail){
    debugPrint(errorDetail.toString());
    return Center(child: Text(errorDetail.toString()),);
  };
}

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  @override
  Widget build(BuildContext context) {
    //Provider 的三个好兄弟
    // MultiProvider 供货商
    //Providers 货源
    //Provider.of<T>(context) 消费者
    return  MultiProvider(
      providers: [
          ChangeNotifierProvider<LocaleNotifier>.value(value: LocaleNotifier(null)),
          ChangeNotifierProvider<ThemeNotifier>.value(value: ThemeNotifier()),
    ],
      child: const AppRootPage());
  }
}



