/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/services.dart';

import 'req.dart';

class ReqDefault extends Req {
  ReqDefault({String? requestId}) : super(requestId);

  ReqDefault.from(MethodCall call) : super(call.arguments["requestId"]);
}
