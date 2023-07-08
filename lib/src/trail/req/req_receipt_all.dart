/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import '../../req.dart';

class ReqReceiptAll extends Req {
  String? payableId;

  ReqReceiptAll({this.payableId, String? requestId}) : super(requestId);

  ReqReceiptAll.from(Map<String, dynamic>? map) : super(map?["requestId"]) {
    payableId = map?["payableId"];
  }
}
