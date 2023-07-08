/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:tiki_trail/license_record.dart';

import '../../rsp.dart';
import 'rsp_license.dart';

class RspLicenses extends Rsp {
  final List<RspLicense> licenses;

  RspLicenses({this.licenses = const [], String? requestId}) : super(requestId);

  RspLicenses.from(List<LicenseRecord> licenses, {String? requestId})
      : licenses = licenses.map((license) => RspLicense.from(license)).toList(),
        super(requestId);

  @override
  Map<String, dynamic> toMap() => {
        "licenses": licenses.map((license) => license.toMap()).toList(),
        "requestId": requestId
      };
}
