/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:tiki_trail/receipt_record.dart';

import '../../rsp.dart';
import 'rsp_receipt.dart';

class RspReceipts extends Rsp {
  final List<RspReceipt> receipts;

  RspReceipts({this.receipts = const [], String? requestId}) : super(requestId);

  RspReceipts.from(List<ReceiptRecord> receipts, {String? requestId})
      : receipts = receipts.map((receipt) => RspReceipt.from(receipt)).toList(),
        super(requestId);

  @override
  Map<String, dynamic> toMap() => {
        "receipts": receipts.map((receipt) => receipt.toMap()).toList(),
        "request_id": requestId
      };
}
