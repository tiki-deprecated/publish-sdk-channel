/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

/// Native platform channels for TIKI SDK.
///
/// The Flutter Platform Channels are used to call native code from Dart and
/// vice-versa. In TIKI SDK we use it to call [TikiSdk] methods **from** native code.
/// It is **not used** in pure Flutter implementations.
library tiki_sdk_flutter_platform;

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:tiki_idp/tiki_idp.dart';
import 'package:tiki_sdk_platform_channel/src/idp/idp_wrapper.dart';
import 'package:tiki_sdk_platform_channel/src/req_init.dart';
import 'package:tiki_sdk_platform_channel/src/rsp_handler.dart';

import 'idp/idp_handler.dart';
import 'rsp_error.dart';
import 'trail/trail_handler.dart';
import 'trail/trail_wrapper.dart';

/// The definition of native platform channels
class Channel {
  final channel = const MethodChannel('com.mytiki.sdk');
  final IdpWrapper _idp = IdpWrapper();
  final TrailWrapper _trail = TrailWrapper();

  late final RspHandler _rsp = RspHandler(channel);
  late final IdpHandler _idpHandler = IdpHandler(_idp, _rsp);
  late final TrailHandler _trailHandler = TrailHandler(_trail, _rsp);

  Channel() {
    channel.setMethodCallHandler(handler);
  }

  Future<void> handler(MethodCall call) async {
    String jsonReq = call.arguments['request'];
    String requestId = call.arguments['requestId'];
    switch (call.method) {
      case "initialize":
        ReqInit req = ReqInit.fromJson(jsonReq);
        TikiIdp idp = _idp.initialize(req.publishingId);
        await _rsp.handle(requestId,
            () => _trail.initialize(req.id, req.publishingId, req.origin, idp));
        break;
      default:
        if (call.method.startsWith("idp.")) {
          await _idpHandler.handler(call);
        } else if (call.method.startsWith("trail.")) {
          await _trailHandler.handler(call);
        } else {
          await channel.invokeMethod(
              RspHandler.errorMethod,
              RspError(
                  requestId: requestId,
                  message: 'no method handler for method ${call.method}',
                  stackTrace: StackTrace.current));
        }
    }
  }
}
