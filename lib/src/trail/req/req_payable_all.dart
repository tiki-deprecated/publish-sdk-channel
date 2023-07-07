/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

class ReqPayableAll {
  String? licenseId;

  ReqPayableAll({this.licenseId});

  ReqPayableAll.from(String? json) {
    if (json != null) {
      Map map = jsonDecode(json);
      licenseId = map["licenseId"];
    }
  }
}
