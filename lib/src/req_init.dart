/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

class ReqInit {
  late final String publishingId;
  late final String origin;
  late final String id;

  ReqInit.fromJson(String jsonString) {
    Map map = jsonDecode(jsonString);
    publishingId = map['publishingId']!;
    origin = map['origin']!;
    id = map['id'];
  }
}
