/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/services.dart';
import 'package:tiki_trail/cache/title/title_tag.dart';

import '../../req.dart';

class ReqTitle extends Req {
  String? ptr;
  List<TitleTag> tags;
  String? description;
  String? origin;

  ReqTitle(
      {this.ptr,
      this.tags = const [],
      this.description,
      this.origin,
      String? requestId})
      : super(requestId);

  ReqTitle.from(MethodCall call)
      : tags = const [],
        super(call.arguments["requestId"]) {
    ptr = call.arguments["ptr"];
    origin = call.arguments["origin"];
    description = call.arguments["description"];
    if (call.arguments["tags"] != null) {
      tags = (call.arguments["tags"] as List)
          .map((tag) => TitleTag.from(tag))
          .toList();
    }
  }
}
