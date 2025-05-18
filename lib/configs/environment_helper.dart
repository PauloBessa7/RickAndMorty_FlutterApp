abstract interface class IEnvironmentHelper {
  String get urlCharacter;
}

final class EnvironmentHelper implements IEnvironmentHelper {
  const EnvironmentHelper();

  static const String _urlBase = 'https://rickandmortyapi.com/api';

  @override
  String get urlCharacter => '$_urlBase/character/';
}
