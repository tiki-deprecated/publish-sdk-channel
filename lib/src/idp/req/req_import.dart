/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import '../../req.dart';

class ReqImport extends Req {
  String? keyId;
  String? key;
  bool? public;

  ReqImport({this.keyId, this.key, this.public = false, String? requestId})
      : super(requestId);

  ReqImport.from(Map<String, dynamic>? map) : super(map?["requestId"]) {
    key = map?["key"];
    keyId = map?["keyId"];
    public = map?["public"];
  }
}
