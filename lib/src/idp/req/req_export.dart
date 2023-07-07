/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

class ReqExport {
  String? keyId;
  bool? public;

  ReqExport({this.keyId, this.public = false});

  ReqExport.from(String? json) {
    if (json != null) {
      Map<String, dynamic> map = jsonDecode(json);
      keyId = map["keyId"];
      public = map["public"];
    }
  }
}
