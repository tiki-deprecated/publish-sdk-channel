/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import '../../rsp.dart';

class RspGuard extends Rsp {
  final bool success;
  final String? reason;

  RspGuard({this.success = false, this.reason, String? requestId})
      : super(requestId);

  @override
  Map<String, dynamic> toMap() =>
      {"success": success, "reason": reason, "request_id": requestId};
}
