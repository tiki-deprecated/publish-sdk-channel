/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';
import 'dart:typed_data';

class ReqSign {
  String? keyId;
  Uint8List? message;

  ReqSign({this.keyId, this.message});

  ReqSign.from(String? json) {
    if (json != null) {
      Map<String, dynamic> map = jsonDecode(json);
      keyId = map["keyId"];
      if (map["message"] != null) message = base64.decode(map["message"]);
    }
  }
}
