/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:tiki_trail/tiki_trail.dart';

import 'req/req_license.dart';
import 'req/req_license_all.dart';
import 'req/req_license_get.dart';
import 'rsp/rsp_license.dart';
import 'rsp/rsp_licenses.dart';

class LicenseWrapper {
  final TikiTrail _trail;

  LicenseWrapper(this._trail);

  Future<RspLicense> create(ReqLicense req) async {
    TitleRecord? title = _trail.title.id(req.titleId!);
    if (title == null) {
      throw ArgumentError("Cannot create license. Title required.");
    }
    LicenseRecord? license = await _trail.license.create(
        title, req.uses, req.terms!,
        description: req.description, expiry: req.expiry);
    return RspLicense.from(license);
  }

  RspLicenses all(ReqLicenseAll req) {
    TitleRecord? title = _trail.title.id(req.titleId!);
    if (title == null) return RspLicenses();
    List<LicenseRecord> licenses = _trail.license.all(title);
    return RspLicenses.from(licenses);
  }

  RspLicense get(ReqLicenseGet req) {
    LicenseRecord? license = _trail.license.get(req.id!);
    return RspLicense.from(license);
  }
}
