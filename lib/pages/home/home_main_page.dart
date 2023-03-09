/// FileName home_main_page
///
/// @Author LinGuanYu
/// @Date 2023/3/9 10:39
///
/// @Description TODO 首页

import 'package:flutter/material.dart';

import '../../common/user_helper.dart';
import '../../res/string/strings.dart';
import '../../res/string/strings_key.dart';
import 'home_item_main_page.dart';

class HomeMainPage extends StatefulWidget {
  const HomeMainPage({Key? key}) : super(key: key);

  @override
  State<HomeMainPage> createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {
  int tabIndex = 0;
  PageController pageController = PageController();

  //底部导航栏使用到的图标
  List<Icon> normalIcon = const [
    Icon(Icons.home),
    Icon(Icons.message),
    Icon(Icons.people)
  ];

  //底部导航栏使用到的标题文字
  List<String> normalTitle = [
    StringKey.homeBottonTitle1,
    StringKey.homeBottonTitle2,
    StringKey.homeBottonTitle3,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBodyFunction(),
      bottomNavigationBar: buildBottomNavigation(),
    );
  }

  buildBodyFunction() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      children: const [HomeItemMainPage(), Text("2"), Text("3")],
    );
  }

  buildBottomNavigation() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: normalIcon[0],
            label: StringLanguages.of(context).get(normalTitle[0])),
        BottomNavigationBarItem(
            icon: normalIcon[1],
            label: StringLanguages.of(context).get(normalTitle[1])),
        BottomNavigationBarItem(
            icon: normalIcon[2],
            label: StringLanguages.of(context).get(normalTitle[2])),
      ], //显示效果
      type: BottomNavigationBarType.fixed,
      //当前选中的页面
      currentIndex: tabIndex,
      //图标的大小
      iconSize: 24.0,
      //点击事件
      onTap: (index) {
        if (index == 2) {
          ///未登录时跳转登录页面
          if (UserHelper.getInstance.userBean == null) {
            ///打开登录页面
            // openLoginPage(context, dismissCallback: (isSuccess) {
            //   ///如果登录成功了就打开我的页面
            //   if (isSuccess) {
            //     setState(() {
            //       _tabIndex = 2;
            //       _pageController.jumpToPage(2);
            //     });
            //   }
            //
            //   ///如果没有成功就还停留在当前页面
            // });
            return;
          }
        }

        ///切换PageView中的页面显示
        pageController.jumpToPage(index);
        tabIndex = index;
        setState(() {});
      },
    );
  }
}
