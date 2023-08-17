/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:tiki_trail/tiki_trail.dart';

import '../../rsp.dart';
import 'rsp_license_use.dart';
import 'rsp_title.dart';

class RspLicense extends Rsp {
  final String? id;
  final RspTitle? title;
  final List<RspLicenseUse>? uses;
  final String? terms;
  final String? description;
  final int? expiry;
  final int? timestamp;

  RspLicense(
      {this.id,
      this.title,
      this.uses,
      this.terms,
      this.description,
      this.expiry,
      this.timestamp,
      String? requestId})
      : super(requestId);

  RspLicense.from(LicenseRecord? license, {String? requestId})
      : id = license?.id,
        terms = license?.terms,
        description = license?.description,
        expiry = license?.expiry?.millisecondsSinceEpoch,
        title = RspTitle.from(license?.title),
        uses = license?.uses.map((use) => RspLicenseUse.from(use)).toList(),
        timestamp = license?.timestamp?.millisecondsSinceEpoch,
        super(requestId);

  @override
  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title?.toMap(),
        "uses": uses?.map((use) => use.toMap()).toList(),
        "terms": terms,
        "description": description,
        "expiry": expiry,
        "timestmap": timestamp,
        "requestId": requestId
      };
}
