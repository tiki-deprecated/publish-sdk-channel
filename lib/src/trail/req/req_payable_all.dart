/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import '../../req.dart';

class ReqPayableAll extends Req {
  String? licenseId;

  ReqPayableAll({this.licenseId, String? requestId}) : super(requestId);

  ReqPayableAll.from(Map<String, dynamic>? map) : super(map?["requestId"]) {
    licenseId = map?["licenseId"];
  }
}
