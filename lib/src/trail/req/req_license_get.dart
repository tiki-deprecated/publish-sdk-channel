/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

class ReqLicenseGet {
  String? id;

  ReqLicenseGet({this.id});

  ReqLicenseGet.from(String? json) {
    if (json != null) {
      Map map = jsonDecode(json);
      id = map["id"];
    }
  }
}
