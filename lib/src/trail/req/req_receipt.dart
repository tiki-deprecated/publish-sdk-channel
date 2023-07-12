/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/services.dart';

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

  ReqReceipt.from(MethodCall call) : super(call.arguments["requestId"]) {
    payableId = call.arguments["payableId"];
    amount = call.arguments["amount"];
    description = call.arguments["description"];
    reference = call.arguments["reference"];
  }
}
