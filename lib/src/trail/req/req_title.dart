/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:tiki_trail/cache/title/title_tag.dart';

class ReqTitle {
  String? ptr;
  List<TitleTag> tags;
  String? description;
  String? origin;

  ReqTitle({this.ptr, this.tags = const [], this.description, this.origin});

  ReqTitle.from(String? json) : tags = const [] {
    if (json != null) {
      Map<String, dynamic> map = jsonDecode(json);
      ptr = map["ptr"];
      origin = map["origin"];
      description = map["description"];
      if (map["tags"] != null) {
        tags = (map["tags"] as List).map((tag) => TitleTag.from(tag)).toList();
      }
    }
  }
}
