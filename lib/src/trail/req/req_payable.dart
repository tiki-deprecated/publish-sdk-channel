/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/services.dart';

import '../../req.dart';

class ReqPayable extends Req {
  String? licenseId;
  String? amount;
  String? type;
  DateTime? expiry;
  String? description;
  String? reference;

  ReqPayable(
      {this.licenseId,
      this.amount,
      this.type,
      this.expiry,
      this.description,
      this.reference,
      String? requestId})
      : super(requestId);

  ReqPayable.from(MethodCall call) : super(call.arguments["requestId"]) {
    licenseId = call.arguments["licenseId"];
    amount = call.arguments["amount"];
    type = call.arguments["type"];
    description = call.arguments["description"];
    reference = call.arguments["reference"];
    if (call.arguments["expiry"] != null) {
      expiry = DateTime.fromMillisecondsSinceEpoch(call.arguments["expiry"]);
    }
  }
}
