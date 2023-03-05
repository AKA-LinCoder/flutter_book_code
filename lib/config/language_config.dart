import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../res/string/strings.dart';

/// FileName language_config
///
/// @Author LinGuanYu
/// @Date 2023/3/5 15:58
///
/// @Description TODO

///配置自定义语言配置代理 MyLocationsLanguageDelegates的实现
class MyLocationsLanguageDelegates extends LocalizationsDelegate<StringLanguages>{

  ///创建默认构造
  const MyLocationsLanguageDelegates();
  ///创建静态构造
  static MyLocationsLanguageDelegates delegate = MyLocationsLanguageDelegates();

  @override
  bool isSupported(Locale locale) {
    ///判断是否支持 ['en','zh'] 其中的一个
    return ['en','zh'].contains(locale.languageCode);
  }

  ///通过load方法关联我们自定义的多语言配制文件MyLocationsLanguages的
  @override
  Future<StringLanguages> load(Locale locale) {
    ///异步初始化MyLocationsLanguages
    return SynchronousFuture(StringLanguages(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate old) {
    ///是否需要重载
    return false;
  }
}
