/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

class ReqPayable {
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
      this.reference});

  ReqPayable.from(String? json) {
    if (json != null) {
      Map<String, dynamic> map = jsonDecode(json);
      licenseId = map["licenseId"];
      amount = map["amount"];
      type = map["type"];
      description = map["description"];
      reference = map["reference"];
      if (map["expiry"] != null) {
        expiry = DateTime.fromMillisecondsSinceEpoch(map["expiry"]);
      }
    }
  }
}
