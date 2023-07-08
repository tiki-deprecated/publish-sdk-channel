/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import '../../rsp.dart';

class RspExport extends Rsp {
  String key;

  RspExport(this.key, {String? requestId}) : super(requestId);

  @override
  Map<String, dynamic> toMap() => {"key": key, "requestId": requestId};
}
