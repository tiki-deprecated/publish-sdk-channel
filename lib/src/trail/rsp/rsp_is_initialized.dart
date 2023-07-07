/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import '../../rsp.dart';

class RspIsInitialized extends Rsp {
  final bool isInitialized;

  RspIsInitialized({this.isInitialized = false, String? requestId})
      : super(requestId);

  @override
  Map<String, dynamic> toMap() =>
      {"isInitialized": isInitialized, "request_id": requestId};
}
