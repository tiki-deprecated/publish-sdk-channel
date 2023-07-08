/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

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

  ReqTitle.from(Map<String, dynamic>? map)
      : tags = const [],
        super(map?["requestId"]) {
    ptr = map?["ptr"];
    origin = map?["origin"];
    description = map?["description"];
    if (map?["tags"] != null) {
      tags = (map!["tags"] as List).map((tag) => TitleTag.from(tag)).toList();
    }
  }
}
