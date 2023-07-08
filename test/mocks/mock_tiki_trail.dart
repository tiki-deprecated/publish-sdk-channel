/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:mockito/mockito.dart';
import 'package:tiki_trail/tiki_trail.dart';

import 'mock_tiki_trail_license.dart';
import 'mock_tiki_trail_payable.dart';
import 'mock_tiki_trail_receipt.dart';
import 'mock_tiki_trail_title.dart';

class MockTikiTrail extends Mock implements TikiTrail {
  @override
  final MockTikiTrailTitle title = MockTikiTrailTitle();

  @override
  final MockTikiTrailLicense license = MockTikiTrailLicense();

  @override
  final MockTikiTrailPayable payable = MockTikiTrailPayable();

  @override
  final MockTikiTrailReceipt receipt = MockTikiTrailReceipt();

  @override
  String get address =>
      super.noSuchMethod(Invocation.getter(#address), returnValue: "mockme");

  @override
  String get id =>
      super.noSuchMethod(Invocation.getter(#id), returnValue: "mockme");

  @override
  bool guard(String ptr, List<LicenseUsecase>? usecases,
          {String? origin,
          List<String>? destinations,
          Function()? onPass,
          Function(String)? onFail}) =>
      super.noSuchMethod(
          Invocation.method(#guard, [
            ptr,
            usecases
          ], {
            const Symbol("origin"): origin,
            const Symbol("destinations"): destinations,
            const Symbol("onPass"): onPass,
            const Symbol("onFail"): onFail
          }),
          returnValue: true);
}
