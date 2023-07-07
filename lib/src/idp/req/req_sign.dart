/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';
import 'dart:typed_data';

import '../../req.dart';

class ReqSign extends Req {
  String? keyId;
  Uint8List? message;

  ReqSign({this.keyId, this.message, String? requestId}) : super(requestId);

  ReqSign.from(Map<String, dynamic>? map) : super(map?["requestId"]) {
    keyId = map?["keyId"];
    if (map?["message"] != null) message = base64.decode(map?["message"]);
  }
}
