/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:flutter/services.dart';

import '../../req.dart';

class ReqSign extends Req {
  String? keyId;
  Uint8List? message;

  ReqSign({this.keyId, this.message, String? requestId}) : super(requestId);

  ReqSign.from(MethodCall call) : super(call.arguments["requestId"]) {
    keyId = call.arguments["keyId"];
    if (call.arguments["message"] != null) {
      message = base64.decode(call.arguments["message"]);
    }
  }
}
