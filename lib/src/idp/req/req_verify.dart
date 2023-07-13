/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:flutter/services.dart';

import '../../req.dart';

class ReqVerify extends Req {
  String? keyId;
  Uint8List? message;
  Uint8List? signature;

  ReqVerify({this.keyId, this.message, this.signature, String? requestId})
      : super(requestId);

  ReqVerify.from(MethodCall call) : super(call.arguments["requestId"]) {
    keyId = call.arguments["keyId"];
    if (call.arguments["message"] != null) {
      message = base64.decode(call.arguments["message"]);
    }
    if (call.arguments["signature"] != null) {
      signature = base64.decode(call.arguments["signature"]);
    }
  }
}
