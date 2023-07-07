/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

class ReqLicenseAll {
  String? titleId;

  ReqLicenseAll({this.titleId});

  ReqLicenseAll.from(String? json) {
    if (json != null) {
      Map map = jsonDecode(json);
      titleId = map["titleId"];
    }
  }
}
