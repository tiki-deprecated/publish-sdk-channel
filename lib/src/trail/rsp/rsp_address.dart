/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import '../../rsp.dart';

class RspAddress extends Rsp {
  final String address;

  RspAddress(this.address, {String? requestId}) : super(requestId);

  @override
  Map<String, dynamic> toMap() => {"address": address, "requestId": requestId};
}
