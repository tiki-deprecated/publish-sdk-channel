/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

class ReqPayableGet {
  String? id;

  ReqPayableGet({this.id});

  ReqPayableGet.from(String? json) {
    if (json != null) {
      Map map = jsonDecode(json);
      id = map["id"];
    }
  }
}
