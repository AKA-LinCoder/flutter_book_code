import 'package:flutter/material.dart';
import 'package:flutter_book_code/res/string/strings.dart';
import 'package:flutter_book_code/res/string/strings_key.dart';
import 'package:flutter_book_code/utils/log_util.dart';
import 'package:flutter_book_code/widgets/shake/shake_animation_text.dart';
import 'package:permission_handler/permission_handler.dart';

import 'common/permission_request_page.dart';

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
          // initData();
        });
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
}
