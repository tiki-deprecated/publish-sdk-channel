/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/services.dart';

import '../rsp_error.dart';
import '../rsp_handler.dart';
import 'idp_wrapper.dart';
import 'req/req_export.dart';
import 'req/req_import.dart';
import 'req/req_key.dart';
import 'req/req_sign.dart';
import 'req/req_verify.dart';

class IdpHandler {
  final IdpWrapper _idp;
  late final RspHandler _rsp;

  IdpHandler(this._idp, this._rsp);

  Future<void> handler(MethodCall call) async {
    String request = call.arguments['request'];
    String requestId = call.arguments['requestId'];
    switch (call.method) {
      case "isInitialized":
        await _rsp.handle(requestId, () => Future.value(_idp.isInitialized));
        break;
      case "key":
        await _rsp.handle(requestId, () => _idp.key(ReqKey.from(request)));
        break;
      case "export":
        await _rsp.handle(
            requestId, () => _idp.export(ReqExport.from(request)));
        break;
      case "import":
        await _rsp.handle(
            requestId, () => _idp.import(ReqImport.from(request)));
        break;
      case "sign":
        await _rsp.handle(requestId, () => _idp.sign(ReqSign.from(request)));
        break;
      case "verify":
        await _rsp.handle(
            requestId, () => _idp.verify(ReqVerify.from(request)));
        break;
      case "token":
        await _rsp.handle(requestId, () => _idp.token());
        break;
      default:
        await _rsp.error(RspError(
            requestId: requestId,
            message: 'no method handler for method ${call.method}',
            stackTrace: StackTrace.current));
    }
  }
}
