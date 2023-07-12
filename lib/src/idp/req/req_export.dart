/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/services.dart';

import '../../req.dart';

class ReqExport extends Req {
  String? keyId;
  bool? public;

  ReqExport({this.keyId, this.public = false, String? requestId})
      : super(requestId);

  ReqExport.from(MethodCall call) : super(call.arguments["requestId"]) {
    keyId = call.arguments["keyId"];
    public = call.arguments["public"];
  }
}
