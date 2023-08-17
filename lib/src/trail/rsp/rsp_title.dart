/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:tiki_trail/tiki_trail.dart';
import 'package:tiki_trail/title_record.dart';

import '../../rsp.dart';

class RspTitle extends Rsp {
  final String? id;
  final String? hashedPtr;
  final String? origin;
  final List<String>? tags;
  final String? description;
  final int? timestamp;

  RspTitle(
      {this.id,
      this.hashedPtr,
      this.tags,
      this.origin,
      this.description,
      this.timestamp,
      String? requestId})
      : super(requestId);

  RspTitle.from(TitleRecord? title, {String? requestId})
      : id = title?.id,
        hashedPtr = title?.hashedPtr,
        origin = title?.origin,
        tags = title?.tags.map((tag) => tag.value).toList(),
        description = title?.description,
        timestamp = title?.timestamp?.millisecondsSinceEpoch,
        super(requestId);

  @override
  Map<String, dynamic> toMap() => {
        "id": id,
        "hashedPtr": hashedPtr,
        "origin": origin,
        "tags": tags,
        "description": description,
        "timestamp": timestamp,
        "requestId": requestId
      };
}
