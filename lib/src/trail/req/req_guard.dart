/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:tiki_trail/cache/license/license_usecase.dart';

import '../../req.dart';

class ReqGuard extends Req {
  String? ptr;
  List<LicenseUsecase> usecases;
  List<String>? destinations;
  String? origin;

  ReqGuard(
      {this.ptr,
      this.usecases = const [],
      this.destinations,
      this.origin,
      String? requestId})
      : super(requestId);

  ReqGuard.from(Map<String, dynamic>? map)
      : usecases = const [],
        super(map?["requestId"]) {
    ptr = map?["ptr"];
    if (map?["destinations"] != null) {
      destinations = map?["destinations"]
          .map<String>((destination) => destination.toString())
          .toList();
    }
    if (map?["destinations"] != null) {
      usecases = map!["usecases"]
          .map<LicenseUsecase>(
              (usecase) => LicenseUsecase.from(usecase.toString()))
          .toList();
    }
    origin = map?["origin"];
  }
}
