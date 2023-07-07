/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import '../../rsp.dart';

/// The response for the `build` method call in the Platform Channel.
///
/// It returns the [address] of the built node.
class RspInitialized extends Rsp {
  final String? id;
  final String? address;

  RspInitialized({this.id, this.address, String? requestId}) : super(requestId);

  @override
  Map<String, dynamic> toMap() =>
      {"id": id, "address": address, "request_id": requestId};
}
