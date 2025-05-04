import 'dart:async';
import 'dart:js_util';
import 'dart:js';

class FlutterTappaySdkWebImpl {
  /// 初始化 TPDirect Web SDK
  Future<void> setupSDK({
    required int appId,
    required String appKey,
    required String serverType,
  }) async {
    final tpDirect = getProperty(context, 'TPDirect');
    if (tpDirect == null) {
      throw Exception('TPDirect is not available. Make sure you included the TapPay SDK script in index.html');
    }

    callMethod(tpDirect, 'setupSDK', [appId, appKey, serverType]);
  }

  /// 呼叫 TPDirect.card.getPrime 並取回 Prime Token
  Future<String> getPrime() {
    final completer = Completer<String>();
    final tpDirect = getProperty(context, 'TPDirect');
    final card = getProperty(tpDirect, 'card');

    callMethod(card, 'getPrime', [
      allowInterop((result) {
        final status = getProperty(result, 'status');
        if (status != 0) {
          final msg = getProperty(result, 'msg')?.toString() ?? 'Unknown error';
          completer.completeError(Exception('getPrime failed: $msg'));
          return;
        }

        final cardInfo = getProperty(result, 'card');
        final prime = getProperty(cardInfo, 'prime');
        completer.complete(prime.toString());
      })
    ]);

    return completer.future;
  }

  /// 取得裝置 ID（若有使用 RBA）
  Future<String> getDeviceId() async {
    final tpDirect = getProperty(context, 'TPDirect');
    if (tpDirect == null) {
      throw Exception('TPDirect is not available');
    }
    final deviceId = callMethod(tpDirect, 'getDeviceId', []);
    return deviceId.toString();
  }
}
