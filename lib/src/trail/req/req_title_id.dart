/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/services.dart';

import '../../req.dart';

class ReqTitleId extends Req {
  String? id;

  ReqTitleId({this.id, String? requestId}) : super(requestId);

  ReqTitleId.from(MethodCall call) : super(call.arguments["requestId"]) {
    id = call.arguments["id"];
  }
}
