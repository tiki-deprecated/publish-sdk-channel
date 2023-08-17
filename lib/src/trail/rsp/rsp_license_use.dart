/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:tiki_trail/cache/license/license_use.dart';

import '../../rsp.dart';

class RspLicenseUse extends Rsp {
  final List<String>? usecases;
  final List<String>? destinations;

  RspLicenseUse(this.usecases, {this.destinations, String? requestId})
      : super(requestId);

  RspLicenseUse.from(LicenseUse? use, {String? requestId})
      : usecases = use?.usecases.map((usecase) => usecase.value).toList(),
        destinations = use?.destinations,
        super(requestId);

  @override
  Map<String, dynamic> toMap() => {
        "usecases": usecases,
        "destinations": destinations,
        "requestId": requestId
      };
}
