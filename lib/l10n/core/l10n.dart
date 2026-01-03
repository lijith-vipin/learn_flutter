import 'package:flutter/widgets.dart';

import 'package:learn_flutter/l10n/generated/app_localizations.dart';

extension L10n on BuildContext {
  S get l10n => S.of(this)!;
}