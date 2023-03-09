/// FileName home_item_main_page
///
/// @Author LinGuanYu
/// @Date 2023/3/9 11:23
///
/// @Description TODO 主页

import 'package:flutter/material.dart';

import '../../bean/bean_video.dart';
import '../play/play_list_page.dart';
class HomeItemMainPage extends StatefulWidget {
  const HomeItemMainPage({Key? key}) : super(key: key);

  @override
  State<HomeItemMainPage> createState() => _HomeItemMainPageState();
}

///使用到tabbar，所以需要绑定一个Ticker,当前页面被装在[PageView] 中，使用keepAlive保持状态
class _HomeItemMainPageState extends State<HomeItemMainPage> with AutomaticKeepAliveClientMixin,SingleTickerProviderStateMixin{

  @override
  // 保持页面状态
  bool get wantKeepAlive => true;

  ///[TabBar]使用的文本
  List<String> tabTextList = ["关注", "推荐"];
  ///[TabBar]使用的[Tab]集合
  List<Tab> tabWidgetList = [];
  ///[TabBar]的控制器
  late TabController tabController;

  ///推荐模拟数据
  List<VideoModel> videoList = [];
  ///关注模拟数据
  List<VideoModel> videoList2 = [];

  @override
  void initState() {
    super.initState();

    ///构建TabBar中使用的Tab数据
    for (var value in tabTextList) {
      tabWidgetList.add(Tab(
        text: value,
      ));
    }
    ///创建TabBar使用的控制器
    tabController = TabController(length: tabTextList.length, vsync: this);

    buildTestData();
  }

  void buildTestData(){

    ///创建模拟数据

    for (int i = 0; i < 10; i++) {
      VideoModel videoModel =  VideoModel();
      videoModel.videoName = "推荐测试数据$i";
      videoModel.pariseCount = i * 22;
      if (i % 3 == 0) {
        videoModel.isAttention = true;
        videoModel.isLike = true;
      } else {
        videoModel.isAttention = false;
        videoModel.isLike = false;
      }
      videoModel.videoImag =
      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582996017736&di=101751f6d5b16e03d501001ca62633d4&imgtype=0&src=http%3A%2F%2Fupload.idcquan.com%2F2018%2F0125%2F1516851762394.jpg";
      videoModel.videoUrl = "https://well.gmbicloud.com/welldrilling/tmp_616039a7cb7a841acf7407b10bcf83586ffaaeda2e167137.mp4";

      videoList.add(videoModel);
    }

    for (int i = 0; i < 3; i++) {
      VideoModel videoModel =  VideoModel();
      videoModel.videoName = "关注测试数据$i";
      videoModel.pariseCount = i * 22;
      videoModel.isAttention = true;
      if (i % 3 == 0) {
        videoModel.isLike = true;
      } else {
        videoModel.isLike = false;
      }
      videoModel.videoImag =
      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582996017736&di=101751f6d5b16e03d501001ca62633d4&imgtype=0&src=http%3A%2F%2Fupload.idcquan.com%2F2018%2F0125%2F1516851762394.jpg";
      videoModel.videoUrl =
      "https://well.gmbicloud.com/welldrilling/tmp_616039a7cb7a841acf7407b10bcf83586ffaaeda2e167137.mp4";

      videoList2.add(videoModel);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ///视频列表
          Positioned(child: buildTableViewWidget(),top: 0,bottom: 0,left: 0,right: 0,),
          ///顶部选项卡
          Positioned(child: buildTabBarWidget(),top: 54,bottom: 0,left: 0,right: 0,),
        ],
      ),
    );
  }

  buildTableViewWidget() {
    return TabBarView(
        controller: tabController,
        children:[
          PlayListPage(
            list:videoList,
            initIndex: 0,
          ),
          PlayListPage(
            list: videoList2,
            initIndex: 0,
          )
        ]
    );
  }

  buildTabBarWidget() {
    return Container(
      ///对齐在顶部中间
      alignment: Alignment.topCenter,
      child: TabBar(
        controller: tabController,
        tabs: tabWidgetList,
        ///指示器的颜色
        indicatorColor: Colors.white,
        ///指示器的高度
        indicatorWeight: 2.0,
        isScrollable: true,
        ///指示器的宽度与文字对齐
        indicatorSize: TabBarIndicatorSize.label,
      ),
    );
  }


}
