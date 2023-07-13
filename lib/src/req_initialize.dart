/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/services.dart';

import 'req.dart';

class ReqInitialize extends Req {
  String? publishingId;
  String? origin;
  String? id;
  String? dir;

  ReqInitialize(
      {this.publishingId, this.origin, this.id, this.dir, String? requestId})
      : super(requestId);

  ReqInitialize.from(MethodCall call) : super(call.arguments["requestId"]) {
    publishingId = call.arguments['publishingId'];
    origin = call.arguments['origin'];
    id = call.arguments['id'];
    dir = call.arguments['dir'];
  }
}
