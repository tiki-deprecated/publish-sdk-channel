/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/services.dart';

import '../../req.dart';

class ReqImport extends Req {
  String? keyId;
  String? key;
  bool? public;

  ReqImport({this.keyId, this.key, this.public = false, String? requestId})
      : super(requestId);

  ReqImport.from(MethodCall call) : super(call.arguments["requestId"]) {
    key = call.arguments["key"];
    keyId = call.arguments["keyId"];
    public = call.arguments["public"];
  }
}
