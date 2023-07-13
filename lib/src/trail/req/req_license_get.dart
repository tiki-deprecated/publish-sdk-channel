/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/services.dart';

import '../../req.dart';

class ReqLicenseGet extends Req {
  String? id;

  ReqLicenseGet({this.id, String? requestId}) : super(requestId);

  ReqLicenseGet.from(MethodCall call) : super(call.arguments["requestId"]) {
    id = call.arguments["id"];
  }
}
