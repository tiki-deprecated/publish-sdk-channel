/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'req.dart';

class ReqDefault extends Req {
  ReqDefault({String? requestId}) : super(requestId);

  ReqDefault.from(Map<String, dynamic>? map) : super(map?["requestId"]);
}
