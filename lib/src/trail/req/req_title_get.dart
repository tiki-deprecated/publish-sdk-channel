/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

class ReqTitleGet {
  String? ptr;
  String? origin;

  ReqTitleGet({this.ptr, this.origin});

  ReqTitleGet.from(String? json) {
    if (json != null) {
      Map map = jsonDecode(json);
      ptr = map["ptr"];
      origin = map["origin"];
    }
  }
}
