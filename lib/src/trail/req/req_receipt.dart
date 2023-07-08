/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import '../../req.dart';

class ReqReceipt extends Req {
  String? payableId;
  String? amount;
  String? description;
  String? reference;

  ReqReceipt(
      {this.payableId,
      this.amount,
      this.description,
      this.reference,
      String? requestId})
      : super(requestId);

  ReqReceipt.from(Map<String, dynamic>? map) : super(map?["requestId"]) {
    payableId = map?["payableId"];
    amount = map?["amount"];
    description = map?["description"];
    reference = map?["reference"];
  }
}
