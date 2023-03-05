import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// FileName cupertino_delegate
///
/// @Author LinGuanYu
/// @Date 2023/3/5 16:02
///
/// @Description TODO

/// flutter使用CupertinoAlertDialog，点击弹出按键时报
/// The getter 'alertDialogLabel' was called on null
/// 跳入到上一层dialog.dart中的确有个label: localizations.alertDialogLabel,
/// 但是CupertinoAlertDialog没有该属性 所以会报错
class FallbackCupertinoLocalisationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {

  ///创建默认构造
  const FallbackCupertinoLocalisationsDelegate();
  ///创建静态构造
  static FallbackCupertinoLocalisationsDelegate delegate = const FallbackCupertinoLocalisationsDelegate();
  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      DefaultCupertinoLocalizations.load(locale);

  @override
  bool shouldReload(FallbackCupertinoLocalisationsDelegate old) => false;
}
