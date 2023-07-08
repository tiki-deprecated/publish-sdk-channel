/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:tiki_trail/tiki_trail.dart';

import 'req/req_receipt.dart';
import 'req/req_receipt_all.dart';
import 'req/req_receipt_get.dart';
import 'rsp/rsp_receipt.dart';
import 'rsp/rsp_receipts.dart';

class ReceiptWrapper {
  final TikiTrail _trail;

  ReceiptWrapper(this._trail);

  Future<RspReceipt> create(ReqReceipt req) async {
    PayableRecord? payable = _trail.payable.get(req.payableId!);
    if (payable == null) {
      throw ArgumentError("Cannot create receipt. Missing payable record.");
    }
    ReceiptRecord? receipt = await _trail.receipt.create(payable, req.amount!,
        description: req.description, reference: req.reference);
    return RspReceipt.from(receipt);
  }

  RspReceipts all(ReqReceiptAll req) {
    PayableRecord? payable = _trail.payable.get(req.payableId!);
    if (payable == null) return RspReceipts();
    List<ReceiptRecord> receipts = _trail.receipt.all(payable);
    return RspReceipts.from(receipts);
  }

  RspReceipt get(ReqReceiptGet req) {
    ReceiptRecord? receipt = _trail.receipt.get(req.id!);
    return RspReceipt.from(receipt);
  }
}
