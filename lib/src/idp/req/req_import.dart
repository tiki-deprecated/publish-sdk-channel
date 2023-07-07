/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

class ReqImport {
  String? keyId;
  String? key;
  bool? public;

  ReqImport({this.keyId, this.key, this.public = false});

  ReqImport.from(String? json) {
    if (json != null) {
      Map<String, dynamic> map = jsonDecode(json);
      key = map["key"];
      keyId = map["keyId"];
      public = map["public"];
    }
  }
}
