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
import 'req_default.dart';
import 'req_initialize.dart';
import 'rsp_error.dart';
import 'rsp_handler.dart';
import 'trail/trail_handler.dart';
import 'trail/trail_wrapper.dart';

class Channel {
  static const name = 'com.mytiki.sdk';
  final _channel = const MethodChannel(name);
  final IdpWrapper _idp;
  final TrailWrapper _trail;

  late final RspHandler _rsp;
  late final IdpHandler _idpHandler;
  late final TrailHandler _trailHandler;

  Channel({IdpWrapper? idp, TrailWrapper? trail, RspHandler? rsp})
      : _idp = idp ?? IdpWrapper(),
        _trail = trail ?? TrailWrapper() {
    _rsp = rsp ?? RspHandler(_channel);
    _idpHandler = IdpHandler(_idp, _rsp);
    _trailHandler = TrailHandler(_trail, _rsp);
    _channel.setMethodCallHandler(handler);
  }

  Future<void> handler(MethodCall call) async {
    switch (call.method) {
      case "$name.initialize":
        ReqInitialize req = ReqInitialize.from(call.arguments);
        TikiIdp idp = _idp.initialize(req.publishingId!);
        await _rsp.handle(
            req.requestId!,
            () => _trail.initialize(
                req.id!, req.publishingId!, req.origin!, idp));
        break;
      default:
        if (call.method.startsWith("idp.")) {
          await _idpHandler.handler(call);
        } else if (call.method.startsWith("trail.")) {
          await _trailHandler.handler(call);
        } else {
          ReqDefault req = ReqDefault.from(call.arguments);
          await _rsp.error(RspError(
              requestId: req.requestId,
              message: 'no method handler for method ${call.method}',
              stackTrace: StackTrace.current));
        }
    }
  }
}
