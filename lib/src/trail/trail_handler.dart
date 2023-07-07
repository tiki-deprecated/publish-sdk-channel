/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/services.dart';

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
  final TrailWrapper _trail;
  late final RspHandler _rsp;

  TrailHandler(this._trail, this._rsp);

  Future<void> handler(MethodCall call) async {
    String request = call.arguments['request'];
    String requestId = call.arguments['requestId'];
    switch (call.method) {
      case "isInitialized":
        await _rsp.handle(requestId, () => Future.value(_trail.isInitialized));
        break;
      case "address":
        await _rsp.handle(requestId, () => Future.value(_trail.address));
        break;
      case "id":
        await _rsp.handle(requestId, () => Future.value(_trail.id));
        break;
      case "guard":
        await _rsp.handle(requestId,
            () => Future.value(_trail.guard(ReqGuard.from(request))));
        break;
      case "title.create":
        await _rsp.handle(
            requestId, () => _trail.title.create(ReqTitle.from(request)));
        break;
      case "title.get":
        await _rsp.handle(requestId,
            () => Future.value(_trail.title.get(ReqTitleGet.from(request))));
        break;
      case "title.id":
        await _rsp.handle(requestId,
            () => Future.value(_trail.title.id(ReqTitleId.from(request))));
        break;
      case "license.create":
        await _rsp.handle(
            requestId, () => _trail.license.create(ReqLicense.from(request)));
        break;
      case "license.all":
        await _rsp.handle(
            requestId,
            () =>
                Future.value(_trail.license.all(ReqLicenseAll.from(request))));
        break;
      case "license.get":
        await _rsp.handle(
            requestId,
            () =>
                Future.value(_trail.license.get(ReqLicenseGet.from(request))));
        break;
      case "payable.create":
        await _rsp.handle(
            requestId, () => _trail.payable.create(ReqPayable.from(request)));
        break;
      case "payable.all":
        await _rsp.handle(
            requestId,
            () =>
                Future.value(_trail.payable.all(ReqPayableAll.from(request))));
        break;
      case "payable.get":
        await _rsp.handle(
            requestId,
            () =>
                Future.value(_trail.payable.get(ReqPayableGet.from(request))));
        break;
      case "receipt.create":
        await _rsp.handle(
            requestId, () => _trail.receipt.create(ReqReceipt.from(request)));
        break;
      case "receipt.all":
        await _rsp.handle(
            requestId,
            () =>
                Future.value(_trail.receipt.all(ReqReceiptAll.from(request))));
        break;
      case "receipt.get":
        await _rsp.handle(
            requestId,
            () =>
                Future.value(_trail.receipt.get(ReqReceiptGet.from(request))));
        break;
      default:
        await _rsp.error(RspError(
            requestId: requestId,
            message: 'no method handler for method ${call.method}',
            stackTrace: StackTrace.current));
    }
  }
}
