import 'package:flutter/material.dart';
import 'package:flutter_book_code/themes/locale_notifier.dart';
import 'package:flutter_book_code/themes/theme_notifier.dart';
import 'package:flutter_book_code/utils/log_util.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'config/cupertino_delegate.dart';
import 'config/language_config.dart';
import 'config/observer_route.dart';

/// FileName app_root
///
/// @Author LinGuanYu
/// @Date 2023/3/5 15:46
///
/// @Description TODO

class AppRootPage extends StatefulWidget {
  const AppRootPage({Key? key}) : super(key: key);

  @override
  State<AppRootPage> createState() => _AppRootPageState();
}

class _AppRootPageState extends State<AppRootPage> {

  ///用户的国际化配置
  Locale? _userLocale;


  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeNotifier,LocaleNotifier>(builder: consumerbuilder);
  }

  Widget consumerbuilder(BuildContext context,ThemeNotifier value,LocaleNotifier localeState,Widget? child){

    ///记录国际化配制
    _userLocale = localeState.locale;
    LogUtil.e("根目录 修改语言环境 $_userLocale");
    ///通过 ColorFiltered 组件将应用内的内容一键变为灰色
    return ColorFiltered(colorFilter: ColorFilter.mode(selectColorFilterValue(value), BlendMode.color),child: buildMaterialApp(value),);
  }


  ///如果当前主题是灰色主题
  ///就启动ColorFiltered的过滤效果
  Color selectColorFilterValue(ThemeNotifier value) {
    return value.currentThemeData?.primaryColor == Colors.grey
        ? Colors.grey
        : Colors.transparent;
  }

  ///构建 MaterialApp 组件
  ///[value] 参数就是当前更新的主题
  MaterialApp buildMaterialApp(ThemeNotifier value) {
    return MaterialApp(
      ///应用的主题
      theme: value.currentThemeData,
      ///应用程序默认显示的页面
      home: Container(child: Text("dsadas"),),
      debugShowCheckedModeBanner: false,
      ///国际化语言环境
      localizationsDelegates: [
        ///初始化默认的 Material 组件本地化
        GlobalMaterialLocalizations.delegate,
        ///初始化默认的 通用 Widget 组件本地化
        GlobalWidgetsLocalizations.delegate,
        ///自定义的语言配制文件代理 初始化
        MyLocationsLanguageDelegates.delegate,
        ///支持使用 CupertinoAlertDialog 的代理
        FallbackCupertinoLocalisationsDelegate.delegate,
      ],
      ///路由导航观察者配置
      navigatorObservers: [routeObserver],
      ///用来监听当前设备语言设置的变化。
      ///在APP第一次启动的时候会被调用,
      localeResolutionCallback: localeCallback,
      ///配置程序语言环境
      locale: _userLocale,
      ///定义当前应用程序所支持的语言环境
      supportedLocales: const [
         Locale('en', 'US'), // English 英文
         Locale('zh', 'CN'), // 中文，
      ],
    );
  }


  ///[sysLocale]参数 反回当前系统的语言环境
  ///[supportedLocales] 返回 supportedLocales 中配制的语言环境支持的配置
  Locale? localeCallback(Locale? sysLocale, Iterable<Locale> supportedLocales) {

    ///判断应用程序是否支持当前系统语言
    List<String> locals = [];
    ///转List集合
    List<Locale> list = supportedLocales.toList();
    for (int i = 0; i < list.length; i++) {
      locals.add(list[i].languageCode);
    }

    ///如果当前系统的语言应用程序不支持
    ///那么在这里默认返回英文环境
    if (!locals.contains(sysLocale?.languageCode)) {
      sysLocale = const Locale('en', 'US');
    }

    return _userLocale ?? sysLocale;
  }

}
