/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'rsp.dart';

class RspDefault extends Rsp {
  RspDefault({String? requestId}) : super(requestId);

  @override
  Map<String, dynamic> toMap() => {"request_id": requestId};
}
