/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:tiki_trail/payable_record.dart';

import '../../rsp.dart';
import 'rsp_payable.dart';

class RspPayables extends Rsp {
  final List<RspPayable> payables;

  RspPayables({this.payables = const [], String? requestId}) : super(requestId);

  RspPayables.from(List<PayableRecord> payables, {String? requestId})
      : payables = payables.map((payable) => RspPayable.from(payable)).toList(),
        super(requestId);

  @override
  Map<String, dynamic> toMap() => {
        "payables": payables.map((payable) => payable.toMap()).toList(),
        "request_id": requestId
      };
}
