/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/services.dart';

import '../channel.dart';
import '../req_default.dart';
import '../rsp_error.dart';
import '../rsp_handler.dart';
import 'req/req_guard.dart';
import 'req/req_license.dart';
import 'req/req_license_all.dart';
import 'req/req_license_get.dart';
import 'req/req_payable.dart';
import 'req/req_payable_all.dart';
import 'req/req_payable_get.dart';
import 'req/req_receipt.dart';
import 'req/req_receipt_all.dart';
import 'req/req_receipt_get.dart';
import 'req/req_title.dart';
import 'req/req_title_get.dart';
import 'req/req_title_id.dart';
import 'trail_wrapper.dart';

class TrailHandler {
  static const name = "${Channel.name}.trail";
  final TrailWrapper _trail;
  late final RspHandler _rsp;

  TrailHandler(this._trail, this._rsp);

  Future<void> handler(MethodCall call) async {
    switch (call.method) {
      case "$name.isInitialized":
        ReqDefault req = ReqDefault.from(call.arguments);
        await _rsp.handle(
            req.requestId!, () => Future.value(_trail.isInitialized));
        break;
      case "$name.address":
        ReqDefault req = ReqDefault.from(call.arguments);
        await _rsp.handle(req.requestId!, () => Future.value(_trail.address));
        break;
      case "$name.id":
        ReqDefault req = ReqDefault.from(call.arguments);
        await _rsp.handle(req.requestId!, () => Future.value(_trail.id));
        break;
      case "$name.guard":
        ReqGuard req = ReqGuard.from(call.arguments);
        await _rsp.handle(
            req.requestId!, () => Future.value(_trail.guard(req)));
        break;
      case "$name.title.create":
        ReqTitle req = ReqTitle.from(call.arguments);
        await _rsp.handle(req.requestId!, () => _trail.title.create(req));
        break;
      case "$name.title.get":
        ReqTitleGet req = ReqTitleGet.from(call.arguments);
        await _rsp.handle(
            req.requestId!, () => Future.value(_trail.title.get(req)));
        break;
      case "$name.title.id":
        ReqTitleId req = ReqTitleId.from(call.arguments);
        await _rsp.handle(
            req.requestId!, () => Future.value(_trail.title.id(req)));
        break;
      case "$name.license.create":
        ReqLicense req = ReqLicense.from(call.arguments);
        await _rsp.handle(req.requestId!, () => _trail.license.create(req));
        break;
      case "$name.license.all":
        ReqLicenseAll req = ReqLicenseAll.from(call.arguments);
        await _rsp.handle(
            req.requestId!, () => Future.value(_trail.license.all(req)));
        break;
      case "$name.license.get":
        ReqLicenseGet req = ReqLicenseGet.from(call.arguments);
        await _rsp.handle(
            req.requestId!, () => Future.value(_trail.license.get(req)));
        break;
      case "$name.payable.create":
        ReqPayable req = ReqPayable.from(call.arguments);
        await _rsp.handle(req.requestId!, () => _trail.payable.create(req));
        break;
      case "$name.payable.all":
        ReqPayableAll req = ReqPayableAll.from(call.arguments);
        await _rsp.handle(
            req.requestId!, () => Future.value(_trail.payable.all(req)));
        break;
      case "$name.payable.get":
        ReqPayableGet req = ReqPayableGet.from(call.arguments);
        await _rsp.handle(
            req.requestId!, () => Future.value(_trail.payable.get(req)));
        break;
      case "$name.receipt.create":
        ReqReceipt req = ReqReceipt.from(call.arguments);
        await _rsp.handle(req.requestId!, () => _trail.receipt.create(req));
        break;
      case "$name.receipt.all":
        ReqReceiptAll req = ReqReceiptAll.from(call.arguments);
        await _rsp.handle(
            req.requestId!, () => Future.value(_trail.receipt.all(req)));
        break;
      case "$name.receipt.get":
        ReqReceiptGet req = ReqReceiptGet.from(call.arguments);
        await _rsp.handle(
            req.requestId!, () => Future.value(_trail.receipt.get(req)));
        break;
      default:
        ReqDefault req = ReqDefault.from(call.arguments);
        await _rsp.error(RspError(
            requestId: req.requestId!,
            message: 'no method handler for method ${call.method}',
            stackTrace: StackTrace.current));
    }
  }
}
