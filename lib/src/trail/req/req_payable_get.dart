/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/services.dart';

import '../../req.dart';

class ReqPayableGet extends Req {
  String? id;

  ReqPayableGet({this.id, String? requestId}) : super(requestId);

  ReqPayableGet.from(MethodCall call) : super(call.arguments["requestId"]) {
    id = call.arguments["id"];
  }
}
