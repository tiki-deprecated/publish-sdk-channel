/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import '../../rsp.dart';

class RspInitialized extends Rsp {
  final String? id;
  final String? address;

  RspInitialized({this.id, this.address, String? requestId}) : super(requestId);

  @override
  Map<String, dynamic> toMap() =>
      {"id": id, "address": address, "request_id": requestId};
}
