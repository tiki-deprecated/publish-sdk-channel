/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:tiki_trail/tiki_trail.dart';

import '../../rsp.dart';
import 'rsp_payable.dart';

class RspReceipt extends Rsp {
  final String? id;
  final RspPayable? payable;
  final String? amount;
  final String? description;
  final String? reference;
  final int? timestamp;

  RspReceipt(
      {this.id,
      this.payable,
      this.amount,
      this.description,
      this.reference,
      this.timestamp,
      String? requestId})
      : super(requestId);

  RspReceipt.from(ReceiptRecord? receipt, {String? requestId})
      : id = receipt?.id,
        payable = RspPayable.from(receipt?.payable),
        description = receipt?.description,
        amount = receipt?.amount,
        reference = receipt?.reference,
        timestamp = receipt?.timestamp?.millisecondsSinceEpoch,
        super(requestId);

  @override
  Map<String, dynamic> toMap() => {
        "id": id,
        "payable": payable?.toMap(),
        "description": description,
        "amount": amount,
        "reference": reference,
        "timestamp": timestamp,
        "requestId": requestId
      };
}
