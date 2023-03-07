import 'package:flutter/material.dart';
import 'package:flutter_book_code/res/string/strings.dart';
import 'package:flutter_book_code/res/string/strings_key.dart';
import 'package:flutter_book_code/splash.dart';
import 'package:flutter_book_code/themes/locale_notifier.dart';
import 'package:flutter_book_code/themes/theme_notifier.dart';
import 'package:flutter_book_code/utils/log_util.dart';
import 'package:flutter_book_code/utils/navigator_utils.dart';
import 'package:flutter_book_code/utils/sp_utils.dart';
import 'package:flutter_book_code/welcome.dart';
import 'package:flutter_book_code/widgets/shake/shake_animation_text.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'common/permission_request_page.dart';
import 'common/sp_key.dart';
import 'common/user_helper.dart';
import 'common/user_protocol_page.dart';

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
  ///用户是否第一次使用
  bool? _userFirst = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Widget渲染完成的回调
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //检查权限
      print("hahahah");
      LogUtil.e("检查权限");
      checkPermissionFunction();
    });

  }

  void checkPermissionFunction(){
    ///根据语言环境加载的文案
    List<String> messageList = [
      StringLanguages.of(context).get(StringKey.storePermisson1),
      StringLanguages.of(context).get(StringKey.storePermisson2),
      StringLanguages.of(context).get(StringKey.storePermisson3),
    ];
    ///权限请求封装功能
    ///如果当前配制的权限通过就直接回调dismissCallback方法
    showPermissionRequestPage(
        context: context,
        ///在这里请求的是文件读写权限
        permission: Permission.storage,
        ///对应的弹框提示语
        permissionMessageList: messageList,
        ///权限请求完成后的回调
        dismissCallback: (value) {
          ///权限请求结束获取权限后进行初始化操作
          ///如果未获取权限是对权限进行关闭的
          initData();
        });
  }


  ///@title initData
  ///@description TODO  加载用户偏好配置，如主题，语言环境，用户的基本信息等，第三方SDK的初始化，一些工具类的初始化
  ///@updateTime 2023/3/5 17:14
  ///@author LinGuanYu
  void initData()async{
    ///获取当前的运行环境
    ///当App运行在Release环境时，inProduction为true；
    ///当App运行在Debug和Profile环境时，inProduction为false。
    const bool inProduction = bool.fromEnvironment("dart.vm.product");
    ///为ture时输出日志
    const bool isLog = !inProduction;
    ///初始化友盟统计
    await initUmeng(isLog: isLog);
    ///初始化本地存储工具
    await SPUtil.init();
    ///初始化日志工具
    LogUtil.init(tag: "flutter_log", isDebug: isLog);

    ///获取用户保存偏好设置
    ///国际化
    String? _languageCode = await SPUtil.getString(spUserLocalLanguageKey);
    ///如果用户有选择过语言环境设置在这里根据用户的选择再重置一下App的语言环境
    if (_languageCode != null && _languageCode.isNotEmpty) {
      LocaleNotifier localeState=LocaleNotifier.zh();
      if(_languageCode==LocaleNotifier.en().toString()){
        localeState=LocaleNotifier.en();
      }
      ///更新语言环境
      Provider.of<LocaleNotifier>(context, listen: false)
          .changeLocaleState(localeState);
    }

    ///获取缓存的应用主题
    int? themIndex = await SPUtil.getInt(spUserThemeKey);
    Provider.of<ThemeNotifier>(context, listen: false).setThem(themIndex);
    ///获取用户是否第一次登录
    _userFirst = await SPUtil.getBool(spUserIsFirstKey)??false;
    ///获取用户隐私协议的状态
    bool? _userProtocol = await SPUtil.getBool(spUserProtocolKey);
    ///记录
    UserHelper.getInstance.userProtocol=_userProtocol??false;
    ///初始化用户的登录信息
    UserHelper.getInstance.init();
    ///下一步
    openUserProtocol();
  }

  ///构建[IndexPage]中的友盟统计
  Future<bool> initUmeng({bool isLog = false}) async {
    return true;
    /// 监听原生消息
    // FlutterFaiUmeng.receiveMessage((message) {
    //   LogUtil.e(message.toString());
    // });
    // ///友盟的初始化
    // ///参数一 appkey
    // ///参数二 推送使用的pushSecret
    // ///参数三 是否打开调试日志
    // await FlutterFaiUmeng.uMengInit("5dcfb8f84ca357f70e000b0a",
    //     pushSecret: "5cb4fc014c143a77fb85cb17edd807a2", logEnabled: isLog);
    // return Future.value(true);
  }


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


  ///判断用户隐私协议
  void openUserProtocol() {
    ///已同意用户隐私协议 下一步
    if (UserHelper.getInstance.isUserProtocol) {
      openNext();
    } else {
      ///未同意用户协议 弹框显示
      showUserProtocolPage(context: context, dismissCallback: (value) {
        openNext();
      });
    }
  }
  ///进入首页面或者是引导页面
  void openNext() {
    if (_userFirst == null || _userFirst == false) {
      ///第一次 隐藏logo 显示左右滑动的引导
      NavigatorUtils.openPageByFade(context, const SplashPage(), isReplace: true);
    } else {
      ///非第一次 隐藏logo 显示欢迎
      NavigatorUtils.openPageByFade(context, const WelcomePage(), isReplace: true);
    }
  }

}
