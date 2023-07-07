/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:tiki_trail/cache/license/license_usecase.dart';

class ReqGuard {
  String? ptr;
  List<LicenseUsecase> usecases;
  List<String>? destinations;
  String? origin;

  ReqGuard(
      {this.ptr, this.usecases = const [], this.destinations, this.origin});

  ReqGuard.from(String? json) : usecases = const [] {
    if (json != null) {
      Map map = jsonDecode(json);
      ptr = map["ptr"];
      if (map["destinations"] != null) {
        destinations = map["destinations"]
            .map<String>((destination) => destination.toString())
            .toList();
      }
      if (map["destinations"] != null) {
        usecases = map["usecases"]
            .map<LicenseUsecase>(
                (usecase) => LicenseUsecase.from(usecase.toString()))
            .toList();
      }
      origin = map["origin"];
    }
  }
}
