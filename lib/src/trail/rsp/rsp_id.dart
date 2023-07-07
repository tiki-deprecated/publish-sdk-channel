/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import '../../rsp.dart';

class RspId extends Rsp {
  final String id;

  RspId(this.id, {String? requestId}) : super(requestId);

  @override
  Map<String, dynamic> toMap() => {"id": id, "requestId": requestId};
}
