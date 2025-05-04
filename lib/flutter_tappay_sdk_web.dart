import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'flutter_tappay_sdk_platform_interface.dart';
import 'flutter_tappay_sdk_method_channel.dart';        // 新增
import 'src/flutter_tappay_sdk_web_impl.dart';

/// A web implementation of the FlutterTapPay SDK.
/// 继承自 MethodChannel 实现，自动获取所有原生方法实现，仅覆盖 Web 专属逻辑。
class FlutterTapPaySdkWeb extends MethodChannelFlutterTapPaySdk {
  /// 注册点，Flutter Web 会调用
  static void registerWith(Registrar registrar) {
    FlutterTapPaySdkPlatform.instance = FlutterTapPaySdkWeb();
  }

  @override
  Future<void> setupSDK({
    required int appId,
    required String appKey,
    required String serverType,
  }) {
    return FlutterTappaySdkWebImpl().setupSDK(
      appId: appId,
      appKey: appKey,
      serverType: serverType,
    );
  }

  @override
  Future<String> getPrime() async {
    final prime = await TPDirect.card.getPrime(); // 舉例
    return prime!.prime; // 用 ! 保證它不為 null（如果你已驗證安全）
  }

  @override
  Future<String> getDeviceId() {
    return FlutterTappaySdkWebImpl().getDeviceId();
  }
}
