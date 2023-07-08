/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:tiki_trail/tiki_trail.dart';

import 'req/req_payable.dart';
import 'req/req_payable_all.dart';
import 'req/req_payable_get.dart';
import 'rsp/rsp_payable.dart';
import 'rsp/rsp_payables.dart';

class PayableWrapper {
  final TikiTrail _trail;

  PayableWrapper(this._trail);

  Future<RspPayable> create(ReqPayable req) async {
    LicenseRecord? license = _trail.license.get(req.licenseId!);
    if (license == null) {
      throw ArgumentError("Cannot create payable. Missing license record.");
    }
    PayableRecord? payable = await _trail.payable.create(
        license, req.amount!, req.type!,
        expiry: req.expiry,
        description: req.description,
        reference: req.reference);
    return RspPayable.from(payable);
  }

  RspPayables all(ReqPayableAll req) {
    LicenseRecord? license = _trail.license.get(req.licenseId!);
    if (license == null) return RspPayables();
    List<PayableRecord> payables = _trail.payable.all(license);
    return RspPayables.from(payables);
  }

  RspPayable get(ReqPayableGet req) {
    PayableRecord? payable = _trail.payable.get(req.id!);
    return RspPayable.from(payable);
  }
}
