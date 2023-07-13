/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/services.dart';
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

  ReqLicense.from(MethodCall call)
      : uses = const [],
        super(call.arguments["requestId"]) {
    titleId = call.arguments["titleId"];
    terms = call.arguments["terms"];
    description = call.arguments["description"];
    if (call.arguments["expiry"] != null) {
      expiry = DateTime.fromMillisecondsSinceEpoch(call.arguments["expiry"]);
    }
    if (call.arguments["uses"] != null) {
      uses = (call.arguments["uses"] as List)
          .map((use) => LicenseUse.fromMap(Map<String, dynamic>.from(use)))
          .toList();
    }
  }
}
