/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:mockito/mockito.dart';
import 'package:tiki_trail/tiki_trail.dart';

import 'mock_tiki_trail_license.dart';

class MockTikiTrailPayable extends Mock implements Payable {
  static final PayableRecord dummy =
      PayableRecord("", MockTikiTrailLicense.dummy, "", "");

  @override
  Future<PayableRecord> create(
          LicenseRecord? license, String? amount, String? type,
          {String? description, DateTime? expiry, String? reference}) =>
      super.noSuchMethod(
          Invocation.method(#create, [
            license,
            amount,
            type
          ], {
            const Symbol("description"): description,
            const Symbol("expiry"): expiry,
            const Symbol("reference"): reference,
          }),
          returnValue: Future.value(dummy));

  @override
  List<PayableRecord> all(LicenseRecord? license) =>
      super.noSuchMethod(Invocation.method(#create, [license]),
          returnValue: [dummy]);
}
