/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/services.dart';

import '../req_default.dart';
import '../rsp_error.dart';
import '../rsp_handler.dart';
import 'idp_wrapper.dart';
import 'req/req_export.dart';
import 'req/req_import.dart';
import 'req/req_key.dart';
import 'req/req_sign.dart';
import 'req/req_verify.dart';

class IdpHandler {
  static const name = "idp";
  final IdpWrapper _idp;
  late final RspHandler _rsp;

  IdpHandler(this._idp, this._rsp);

  Future<void> handler(MethodCall call) async {
    switch (call.method) {
      case "$name.isInitialized":
        ReqDefault req = ReqDefault.from(call);
        await _rsp.handle(
            req.requestId!, () => Future.value(_idp.isInitialized));
        break;
      case "$name.key":
        ReqKey req = ReqKey.from(call);
        await _rsp.handle(req.requestId!, () => _idp.key(req));
        break;
      case "$name.export":
        ReqExport req = ReqExport.from(call);
        await _rsp.handle(req.requestId!, () => _idp.export(req));
        break;
      case "$name.import":
        ReqImport req = ReqImport.from(call);
        await _rsp.handle(req.requestId!, () => _idp.import(req));
        break;
      case "$name.sign":
        ReqSign req = ReqSign.from(call);
        await _rsp.handle(req.requestId!, () => _idp.sign(req));
        break;
      case "$name.verify":
        ReqVerify req = ReqVerify.from(call);
        await _rsp.handle(req.requestId!, () => _idp.verify(req));
        break;
      case "$name.token":
        ReqDefault req = ReqDefault.from(call);
        await _rsp.handle(req.requestId!, () => _idp.token());
        break;
      default:
        ReqDefault req = ReqDefault.from(call);
        await _rsp.error(RspError(
            requestId: req.requestId!,
            message: 'no method handler for method ${call.method}',
            stackTrace: StackTrace.current));
    }
  }
}
