/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import '../../req.dart';

class ReqPayableGet extends Req {
  String? id;

  ReqPayableGet({this.id, String? requestId}) : super(requestId);

  ReqPayableGet.from(Map<String, dynamic>? map) : super(map?["requestId"]) {
    id = map?["id"];
  }
}
