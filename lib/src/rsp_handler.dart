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
      await _channel.invokeMethod(successMethod, rsp.toMap());
    } catch (e) {
      RspError rsp;
      if (e is Error) {
        rsp = RspError.fromError(e, requestId: requestId);
      } else if (e is Exception) {
        rsp = RspError.fromException(e, requestId: requestId);
      } else {
        rsp = RspError(
            message: "Unknown Error: ${e.runtimeType}", requestId: requestId);
      }
      await _channel.invokeMethod(errorMethod, rsp.toMap());
    }
  }

  Future<void> error(RspError error) async =>
      _channel.invokeMethod(errorMethod, error.toMap());
}
