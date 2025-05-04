import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'flutter_tappay_sdk_platform_interface.dart';
import 'src/flutter_tappay_sdk_web_impl.dart';

/// A web implementation of the FlutterTappaySdkPlatform.
class FlutterTappaySdkWeb extends FlutterTappaySdkPlatform {
  static void registerWith(Registrar registrar) {
    FlutterTappaySdkPlatform.instance = FlutterTappaySdkWeb();
  }

  @override
  Future<void> setupSDK({
    required int appId,
    required String appKey,
    required String serverType,
  }) async {
    return FlutterTappaySdkWebImpl().setupSDK(
      appId: appId,
      appKey: appKey,
      serverType: serverType,
    );
  }

  @override
  Future<String> getPrime() async {
    return FlutterTappaySdkWebImpl().getPrime();
  }

  @override
  Future<String> getDeviceId() async {
    return FlutterTappaySdkWebImpl().getDeviceId();
  }
}
