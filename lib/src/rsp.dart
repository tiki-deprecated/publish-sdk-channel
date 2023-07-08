/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

abstract class Rsp {
  String? requestId;

  Rsp(this.requestId);

  Map<String, dynamic> toMap();

  @override
  String toString() => jsonEncode(toMap());
}
