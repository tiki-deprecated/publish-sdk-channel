/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:tiki_trail/cache/license/license_use.dart';

class ReqLicense {
  String? titleId;
  List<LicenseUse> uses;
  String? terms;
  DateTime? expiry;
  String? description;

  ReqLicense(
      {this.titleId,
      this.uses = const [],
      this.terms,
      this.expiry,
      this.description});

  ReqLicense.from(String? json) : uses = const [] {
    if (json != null) {
      Map<String, dynamic> map = jsonDecode(json);
      titleId = map["titleId"];
      terms = map["terms"];
      description = map["description"];
      if (map["expiry"] != null) {
        expiry = DateTime.fromMillisecondsSinceEpoch(map["expiry"]);
      }
      if (map["uses"] != null) {
        uses = (map["uses"] as List)
            .map((use) => LicenseUse.fromMap(use))
            .toList();
      }
    }
  }
}
