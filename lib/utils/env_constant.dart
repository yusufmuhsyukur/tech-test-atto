import 'package:global_configuration/global_configuration.dart';

class EnvConstant {
  static final GlobalConfiguration _config = GlobalConfiguration();

  static const String _baseUrl = 'baseUrl';

  static String get baseUrl {
    return _config.get(_baseUrl) as String;
  }
}
