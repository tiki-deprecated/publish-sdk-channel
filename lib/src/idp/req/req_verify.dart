/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';
import 'dart:typed_data';

class ReqVerify {
  String? keyId;
  Uint8List? message;
  Uint8List? signature;

  ReqVerify({this.keyId, this.message, this.signature});

  ReqVerify.from(String? json) {
    if (json != null) {
      Map<String, dynamic> map = jsonDecode(json);
      keyId = map["keyId"];
      if (map["message"] != null) message = base64.decode(map["message"]);
      if (map["signature"] != null) signature = base64.decode(map["signature"]);
    }
  }
}
