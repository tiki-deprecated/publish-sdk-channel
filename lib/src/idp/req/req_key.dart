/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import '../../req.dart';

class ReqKey extends Req {
  String? keyId;
  bool? overwrite;

  ReqKey({this.keyId, this.overwrite = false, String? requestId})
      : super(requestId);

  ReqKey.from(Map<String, dynamic>? map) : super(map?["requestId"]) {
    keyId = map?["keyId"];
    overwrite = map?["overwrite"];
  }
}
