/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

class ReqReceiptAll {
  String? payableId;

  ReqReceiptAll({this.payableId});

  ReqReceiptAll.from(String? json) {
    if (json != null) {
      Map map = jsonDecode(json);
      payableId = map["payableId"];
    }
  }
}
