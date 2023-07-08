/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import '../../req.dart';

class ReqLicenseLatest extends Req {
  String? ptr;
  String? origin;

  ReqLicenseLatest({this.ptr, this.origin, String? requestId})
      : super(requestId);

  ReqLicenseLatest.fromJson(Map<String, dynamic>? map)
      : super(map?["requestId"]) {
    ptr = map?["ptr"];
    origin = map?["origin"];
  }
}
