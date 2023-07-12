/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/services.dart';

import '../../req.dart';

class ReqReceiptAll extends Req {
  String? payableId;

  ReqReceiptAll({this.payableId, String? requestId}) : super(requestId);

  ReqReceiptAll.from(MethodCall call) : super(call.arguments["requestId"]) {
    payableId = call.arguments["payableId"];
  }
}
