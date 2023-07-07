/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'rsp.dart';

class RspOk extends Rsp {
  final bool ok = true;

  RspOk({String? requestId}) : super(requestId);

  @override
  Map<String, dynamic> toMap() => {"ok": ok, "request_id": requestId};
}
