/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

abstract class Rsp {
  String? requestId;

  Rsp(this.requestId);

  Map<String, dynamic> toMap();

  String toJson() => jsonEncode(toMap());
}
