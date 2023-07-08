/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import '../../req.dart';

class ReqExport extends Req {
  String? keyId;
  bool? public;

  ReqExport({this.keyId, this.public = false, String? requestId})
      : super(requestId);

  ReqExport.from(Map<String, dynamic>? map) : super(map?["requestId"]) {
    keyId = map?["keyId"];
    public = map?["public"];
  }
}
