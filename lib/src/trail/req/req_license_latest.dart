/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/services.dart';

import '../../req.dart';

class ReqLicenseLatest extends Req {
  String? ptr;
  String? origin;

  ReqLicenseLatest({this.ptr, this.origin, String? requestId})
      : super(requestId);

  ReqLicenseLatest.fromJson(MethodCall call)
      : super(call.arguments["requestId"]) {
    ptr = call.arguments["ptr"];
    origin = call.arguments["origin"];
  }
}
