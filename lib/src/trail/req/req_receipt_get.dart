/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/services.dart';

import '../../req.dart';

class ReqReceiptGet extends Req {
  String? id;

  ReqReceiptGet({this.id, String? requestId}) : super(requestId);

  ReqReceiptGet.from(MethodCall call) : super(call.arguments["requestId"]) {
    id = call.arguments["id"];
  }
}
