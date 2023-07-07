/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

class ReqTitleId {
  String? id;

  ReqTitleId({this.id});

  ReqTitleId.from(String? json) {
    if (json != null) {
      Map map = jsonDecode(json);
      id = map["id"];
    }
  }
}
