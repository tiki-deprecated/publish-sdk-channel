/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:mockito/mockito.dart';
import 'package:tiki_trail/tiki_trail.dart';

import 'mock_tiki_trail_title.dart';

class MockTikiTrailLicense extends Mock implements License {
  static final LicenseRecord dummy =
      LicenseRecord("", MockTikiTrailTitle.dummy, [], "");

  @override
  Future<LicenseRecord> create(
          TitleRecord? title, List<LicenseUse>? uses, String? terms,
          {String? description, DateTime? expiry}) =>
      super.noSuchMethod(
          Invocation.method(#create, [
            title,
            uses,
            terms
          ], {
            const Symbol("description"): description,
            const Symbol("expiry"): expiry
          }),
          returnValue: Future.value(dummy));

  @override
  List<LicenseRecord> all(TitleRecord? title) => super
      .noSuchMethod(Invocation.method(#create, [title]), returnValue: [dummy]);
}
