/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

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

  ReqPayable.from(Map<String, dynamic>? map) : super(map?["requestId"]) {
    licenseId = map?["licenseId"];
    amount = map?["amount"];
    type = map?["type"];
    description = map?["description"];
    reference = map?["reference"];
    if (map?["expiry"] != null) {
      expiry = DateTime.fromMillisecondsSinceEpoch(map!["expiry"]);
    }
  }
}
