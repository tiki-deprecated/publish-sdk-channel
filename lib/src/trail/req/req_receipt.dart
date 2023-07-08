/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

class ReqReceipt {
  String? payableId;
  String? amount;
  String? description;
  String? reference;

  ReqReceipt({this.payableId, this.amount, this.description, this.reference});

  ReqReceipt.from(String? json) {
    if (json != null) {
      Map<String, dynamic> map = jsonDecode(json);
      payableId = map["payableId"];
      amount = map["amount"];
      description = map["description"];
      reference = map["reference"];
    }
  }
}
