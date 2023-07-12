/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/services.dart';

import '../../req.dart';

class ReqKey extends Req {
  String? keyId;
  bool? overwrite;

  ReqKey({this.keyId, this.overwrite = false, String? requestId})
      : super(requestId);

  ReqKey.from(MethodCall call) : super(call.arguments["requestId"]) {
    keyId = call.arguments["keyId"];
    overwrite = call.arguments["overwrite"];
  }
}
