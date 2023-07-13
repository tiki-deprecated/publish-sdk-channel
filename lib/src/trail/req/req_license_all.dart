/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/services.dart';

import '../../req.dart';

class ReqLicenseAll extends Req {
  String? titleId;

  ReqLicenseAll({this.titleId, String? requestId}) : super(requestId);

  ReqLicenseAll.from(MethodCall call) : super(call.arguments["requestId"]) {
    titleId = call.arguments["titleId"];
  }
}
