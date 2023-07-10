/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'dart:io';

import 'package:sqlite3/common.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:tiki_idp/tiki_idp.dart';
import 'package:tiki_trail/key.dart';
import 'package:tiki_trail/tiki_trail.dart';

import 'license_wrapper.dart';
import 'payable_wrapper.dart';
import 'receipt_wrapper.dart';
import 'req/req_guard.dart';
import 'rsp/rsp_address.dart';
import 'rsp/rsp_guard.dart';
import 'rsp/rsp_id.dart';
import 'rsp/rsp_initialized.dart';
import 'rsp/rsp_is_initialized.dart';
import 'title_wrapper.dart';

class TrailWrapper {
  late final TikiTrail? _trail;
  late final TitleWrapper title;
  late final LicenseWrapper license;
  late final PayableWrapper payable;
  late final ReceiptWrapper receipt;

  TrailWrapper({TikiTrail? trail}) : _trail = trail {
    if (_trail != null) {
      license = LicenseWrapper(_trail!);
      title = TitleWrapper(_trail!);
      payable = PayableWrapper(_trail!);
      receipt = ReceiptWrapper(_trail!);
    }
  }

  Future<RspInitialized> initialize(String id, String publishingId,
      String origin, String dir, TikiIdp idp) async {
    Key key = await TikiTrail.withId(id, idp);
    Directory directory = Directory(dir);
    if (!await directory.exists()) await directory.create(recursive: true);
    String dbFile = "$dir/${key.address}.db";
    CommonDatabase database = sqlite3.open(dbFile);
    _trail = await TikiTrail.init(publishingId, origin, idp, key, database);
    license = LicenseWrapper(_trail!);
    title = TitleWrapper(_trail!);
    payable = PayableWrapper(_trail!);
    receipt = ReceiptWrapper(_trail!);

    return RspInitialized(key.id, key.address);
  }

  RspAddress get address => RspAddress(_trail!.address);

  RspId get id => RspId(_trail!.id);

  RspIsInitialized get isInitialized =>
      RspIsInitialized(isInitialized: _trail != null);

  RspGuard guard(ReqGuard req) {
    RspGuard rsp = RspGuard(success: false);
    _trail!.guard(req.ptr!, req.usecases,
        destinations: req.destinations,
        origin: req.origin,
        onPass: () => rsp = RspGuard(success: true),
        onFail: (error) => rsp = RspGuard(success: false, reason: error));
    return rsp;
  }
}
