/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import '../../req.dart';

class ReqLicenseAll extends Req {
  String? titleId;

  ReqLicenseAll({this.titleId, String? requestId}) : super(requestId);

  ReqLicenseAll.from(Map<String, dynamic>? map) : super(map?["requestId"]) {
    titleId = map?["titleId"];
  }
}
