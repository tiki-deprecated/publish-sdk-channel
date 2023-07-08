/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import '../../req.dart';

class ReqTitleId extends Req {
  String? id;

  ReqTitleId({this.id, String? requestId}) : super(requestId);

  ReqTitleId.from(Map<String, dynamic>? map) : super(map?["requestId"]) {
    id = map?["id"];
  }
}
