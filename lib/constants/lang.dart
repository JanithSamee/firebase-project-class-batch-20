import 'package:get/get.dart';

class Language extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {'greeting': 'Good Morning', 'lang': "සිං"},
    'si_LK': {'greeting': 'සුබ උදෑසනක් වේවා!', 'lang': "EN"},
  };
}
