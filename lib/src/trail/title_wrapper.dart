/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:tiki_trail/tiki_trail.dart';

import 'req/req_title.dart';
import 'req/req_title_get.dart';
import 'req/req_title_id.dart';
import 'rsp/rsp_title.dart';

class TitleWrapper {
  final TikiTrail _trail;

  TitleWrapper(this._trail);

  Future<RspTitle> create(ReqTitle req) async {
    TitleRecord title = await _trail.title.create(req.ptr!,
        origin: req.origin, tags: req.tags, description: req.description);
    return RspTitle.from(title);
  }

  RspTitle get(ReqTitleGet req) {
    TitleRecord? title = _trail.title.get(req.ptr!, origin: req.origin);
    return RspTitle.from(title);
  }

  RspTitle id(ReqTitleId req) {
    TitleRecord? title = _trail.title.id(req.id!);
    return RspTitle.from(title);
  }
}
