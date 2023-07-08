/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import '../../req.dart';

class ReqTitleGet extends Req {
  String? ptr;
  String? origin;

  ReqTitleGet({this.ptr, this.origin, String? requestId}) : super(requestId);

  ReqTitleGet.from(Map<String, dynamic>? map) : super(map?["requestId"]) {
    ptr = map?["ptr"];
    origin = map?["origin"];
  }
}
