/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

class ReqKey {
  String? keyId;
  bool? overwrite;

  ReqKey({this.keyId, this.overwrite = false});

  ReqKey.from(String? json) {
    if (json != null) {
      Map<String, dynamic> map = jsonDecode(json);
      keyId = map["keyId"];
      overwrite = map["overwrite"];
    }
  }
}
