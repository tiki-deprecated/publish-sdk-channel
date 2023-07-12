/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/services.dart';

import '../../req.dart';

class ReqPayableAll extends Req {
  String? licenseId;

  ReqPayableAll({this.licenseId, String? requestId}) : super(requestId);

  ReqPayableAll.from(MethodCall call) : super(call.arguments["requestId"]) {
    licenseId = call.arguments["licenseId"];
  }
}
