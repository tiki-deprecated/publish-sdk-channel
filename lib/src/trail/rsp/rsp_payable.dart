/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:tiki_trail/tiki_trail.dart';

import '../../rsp.dart';
import 'rsp_license.dart';

class RspPayable extends Rsp {
  final String? id;
  final RspLicense? license;
  final String? amount;
  final String? type;
  final String? description;
  final int? expiry;
  final String? reference;
  final int? timestamp;

  RspPayable(
      {this.id,
      this.license,
      this.amount,
      this.type,
      this.description,
      this.expiry,
      this.reference,
      this.timestamp,
      String? requestId})
      : super(requestId);

  RspPayable.from(PayableRecord? payable, {String? requestId})
      : id = payable?.id,
        license = RspLicense.from(payable?.license),
        description = payable?.description,
        expiry = payable?.expiry?.millisecondsSinceEpoch,
        amount = payable?.amount,
        type = payable?.type,
        reference = payable?.reference,
        timestamp = payable?.timestamp?.millisecondsSinceEpoch,
        super(requestId);

  @override
  Map<String, dynamic> toMap() => {
        "id": id,
        "license": license?.toMap(),
        "description": description,
        "expiry": expiry,
        "amount": amount,
        "type": type,
        "reference": reference,
        "timestamp": timestamp,
        "requestId": requestId
      };
}
