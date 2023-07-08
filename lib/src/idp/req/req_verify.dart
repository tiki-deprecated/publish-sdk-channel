/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';
import 'dart:typed_data';

import '../../req.dart';

class ReqVerify extends Req {
  String? keyId;
  Uint8List? message;
  Uint8List? signature;

  ReqVerify({this.keyId, this.message, this.signature, String? requestId})
      : super(requestId);

  ReqVerify.from(Map<String, dynamic>? map) : super(map?["requestId"]) {
    keyId = map?["keyId"];
    if (map?["message"] != null) message = base64.decode(map?["message"]);
    if (map?["signature"] != null) signature = base64.decode(map?["signature"]);
  }
}
