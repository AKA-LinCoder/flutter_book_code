import 'package:flutter/cupertino.dart';
import 'package:flutter_book_code/utils/log_util.dart';
import 'package:flutter_book_code/utils/sp_utils.dart';

import '../common/sp_key.dart';

/// FileName locale_notifier
///
/// @Author LinGuanYu
/// @Date 2023/3/5 15:12
///
/// @Description TODO

class LocaleNotifier extends ChangeNotifier{
  Locale? _locale;
  LocaleNotifier(this._locale);

  factory LocaleNotifier.zh() => LocaleNotifier(const Locale('zh','CH'));
  factory LocaleNotifier.en() => LocaleNotifier(const Locale('en','US'));

  //修改语言环境
  void changeLocaleState(LocaleNotifier? state){
    LogUtil.e("修改语言环境$state");
    if(state==null){
      return;
    }
    _locale = state.locale;

    //通知
    notifyListeners();

    //TODO 保存
    SPUtil.save(spUserLocalLanguageKey, state.toString());

  }

  //获取语言环境
  Locale? get locale => _locale;


}