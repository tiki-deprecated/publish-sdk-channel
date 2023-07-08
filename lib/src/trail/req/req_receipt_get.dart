/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import '../../req.dart';

class ReqReceiptGet extends Req {
  String? id;

  ReqReceiptGet({this.id, String? requestId}) : super(requestId);

  ReqReceiptGet.from(Map<String, dynamic>? map) : super(map?["requestId"]) {
    id = map?["id"];
  }
}
