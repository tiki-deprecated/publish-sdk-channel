/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/services.dart';

import 'rsp.dart';
import 'rsp_error.dart';

class RspHandler {
  static const successMethod = "success";
  static const errorMethod = "error";
  final MethodChannel _channel;

  RspHandler(this._channel);

  Future<void> handle<T extends Rsp>(
      String requestId, Future<T> Function() process) async {
    try {
      T rsp = await process();
      rsp.requestId = requestId;
      await _channel.invokeMethod(successMethod, rsp.toJson());
    } catch (e) {
      RspError rsp = RspError.fromError(e as Error, requestId: requestId);
      await _channel.invokeMethod(errorMethod, rsp.toJson());
    }
  }

  Future<void> error(RspError error) async =>
      _channel.invokeMethod(errorMethod, error.toJson());
}
