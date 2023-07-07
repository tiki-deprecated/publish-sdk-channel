/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

class ReqReceiptGet {
  String? id;

  ReqReceiptGet({this.id});

  ReqReceiptGet.from(String? json) {
    if (json != null) {
      Map map = jsonDecode(json);
      id = map["id"];
    }
  }
}
