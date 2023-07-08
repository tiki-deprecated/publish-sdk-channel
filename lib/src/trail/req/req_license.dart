/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:tiki_trail/cache/license/license_use.dart';

import '../../req.dart';

class ReqLicense extends Req {
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
      this.description,
      String? requestId})
      : super(requestId);

  ReqLicense.from(Map<String, dynamic>? map)
      : uses = const [],
        super(map?["requestId"]) {
    titleId = map?["titleId"];
    terms = map?["terms"];
    description = map?["description"];
    if (map?["expiry"] != null) {
      expiry = DateTime.fromMillisecondsSinceEpoch(map!["expiry"]);
    }
    if (map?["uses"] != null) {
      uses = (map!["uses"] as List)
          .map((use) => LicenseUse.fromMap(Map<String, dynamic>.from(use)))
          .toList();
    }
  }
}
