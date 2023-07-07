/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';
import 'dart:typed_data';

import '../../rsp.dart';

class RspSign extends Rsp {
  final Uint8List signature;

  RspSign(this.signature, {String? requestId}) : super(requestId);

  @override
  Map<String, dynamic> toMap() =>
      {"signature": base64.encode(signature), "request_id": requestId};
}
