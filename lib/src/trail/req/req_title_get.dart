/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/services.dart';

import '../../req.dart';

class ReqTitleGet extends Req {
  String? ptr;
  String? origin;

  ReqTitleGet({this.ptr, this.origin, String? requestId}) : super(requestId);

  ReqTitleGet.from(MethodCall call) : super(call.arguments["requestId"]) {
    ptr = call.arguments["ptr"];
    origin = call.arguments["origin"];
  }
}
