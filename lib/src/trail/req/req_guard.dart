/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/services.dart';
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

  ReqGuard.from(MethodCall call)
      : usecases = const [],
        super(call.arguments["requestId"]) {
    ptr = call.arguments["ptr"];
    if (call.arguments["destinations"] != null) {
      destinations = call.arguments["destinations"]
          .map<String>((destination) => destination.toString())
          .toList();
    }
    if (call.arguments["destinations"] != null) {
      usecases = call.arguments["usecases"]
          .map<LicenseUsecase>(
              (usecase) => LicenseUsecase.from(usecase.toString()))
          .toList();
    }
    origin = call.arguments["origin"];
  }
}
