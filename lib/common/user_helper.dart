import 'package:flutter_book_code/common/sp_key.dart';

import '../bean/bean_user.dart';
import '../utils/sp_utils.dart';

/// FileName user_helper
///
/// @Author LinGuanYu
/// @Date 2023/3/5 17:20
///
/// @Description TODO 用户信息辅助操作类

///用户信息辅助操作类
class  UserHelper{
  // 私有构造函数
  UserHelper._() {
    // 具体初始化代码
  }
  ///获取单例对象
  static UserHelper getInstance = UserHelper._();
  ///用户基本信息模型
  UserBean? _userBean;
  ///获取 UserBean
  UserBean? get userBean => _userBean;
  ///userBean的设置方法
  set userBeanDetail(UserBean bean){
    _userBean = bean;
    ///缓存用户信息
    SPUtil.saveObject(spUserBeanKey, bean);
  }
  ///判断用户是否登录的便捷方法
  bool get userIsLogin =>userBean==null?false:true;


  ///是否同同意隐私与用户协议
  bool _userProtocol = false;
  bool get userProtocol =>_userProtocol;
  set userProtocol(bool flag){
    _userProtocol=flag;
    ///保存同意的标识
    SPUtil.save(spUserProtocolKey,flag);
  }
  ///判断用户是否同意用户协议便捷方法
  bool get isUserProtocol =>_userProtocol ?? false;

  ///用来初始化用户信息的缓存数据
  Future<bool> init() async{
    ///加载缓存数据
    Map<String,dynamic>? map  = await SPUtil.getObject(spUserBeanKey);
    _userBean = UserBean.fromJson(map??{});
    return Future.value(true);
  }
}