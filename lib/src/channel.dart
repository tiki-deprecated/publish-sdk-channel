/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

library tiki_sdk_flutter_platform;

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:tiki_idp/tiki_idp.dart';

import 'idp/idp_handler.dart';
import 'idp/idp_wrapper.dart';
import 'req_init.dart';
import 'rsp_error.dart';
import 'rsp_handler.dart';
import 'trail/trail_handler.dart';
import 'trail/trail_wrapper.dart';

class Channel {
  static const name = 'com.mytiki.sdk';
  final _channel = const MethodChannel(name);
  final IdpWrapper _idp;
  final TrailWrapper _trail;

  late final RspHandler _rsp = RspHandler(_channel);
  late final IdpHandler _idpHandler = IdpHandler(_idp, _rsp);
  late final TrailHandler _trailHandler = TrailHandler(_trail, _rsp);

  Channel({IdpWrapper? idp, TrailWrapper? trail})
      : _idp = idp ?? IdpWrapper(),
        _trail = trail ?? TrailWrapper() {
    _channel.setMethodCallHandler(handler);
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
          await _rsp.error(RspError(
              requestId: requestId,
              message: 'no method handler for method ${call.method}',
              stackTrace: StackTrace.current));
        }
    }
  }
}
