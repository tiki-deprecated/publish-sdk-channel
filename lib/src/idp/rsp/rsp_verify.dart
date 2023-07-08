/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import '../../rsp.dart';

class RspVerify extends Rsp {
  final bool isVerified;

  RspVerify({this.isVerified = false, String? requestId}) : super(requestId);

  @override
  Map<String, dynamic> toMap() =>
      {"isVerified": isVerified, "requestId": requestId};
}
