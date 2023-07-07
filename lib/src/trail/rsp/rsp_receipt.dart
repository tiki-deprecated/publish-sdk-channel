/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:tiki_trail/tiki_trail.dart';

import '../../rsp.dart';
import 'rsp_payable.dart';

class RspReceipt extends Rsp {
  String? id;
  RspPayable? payable;
  String? amount;
  String? description;
  String? reference;

  RspReceipt(
      {this.id,
      this.payable,
      this.amount,
      this.description,
      this.reference,
      String? requestId})
      : super(requestId);

  RspReceipt.from(ReceiptRecord? receipt, {String? requestId})
      : id = receipt?.id,
        payable = RspPayable.from(receipt?.payable),
        description = receipt?.description,
        amount = receipt?.amount,
        reference = receipt?.reference,
        super(requestId);

  @override
  Map<String, dynamic> toMap() => {
        "id": id,
        "payable": payable?.toMap(),
        "description": description,
        "amount": amount,
        "reference": reference,
        "request_id": requestId
      };
}
