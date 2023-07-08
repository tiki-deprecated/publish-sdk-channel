/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import '../../req.dart';

class ReqLicenseGet extends Req {
  String? id;

  ReqLicenseGet({this.id, String? requestId}) : super(requestId);

  ReqLicenseGet.from(Map<String, dynamic>? map) : super(map?["requestId"]) {
    id = map?["id"];
  }
}
