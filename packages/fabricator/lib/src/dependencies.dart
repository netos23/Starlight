/// Register dependency as Singleton.
/// [name] - Register as named instance
class Singleton {
  const Singleton({
    this.name,
  });

  final String? name;
}

// Register dependency as Singleton in global scopes
// with default params
const singleton = Singleton();

/// Register dependency as LazySingleton.
/// [name] - Register as named instance
class LazySingleton {
  const LazySingleton({
    this.name,
  });

  final String? name;
}

// Register dependency as LazySingleton in global scopes
// with default params
const lazySingleton = LazySingleton();

/// Register dependency as Factory.
class Factory {
  const Factory();
}

// Register dependency as Factory in global scopes
// with default params
const factory = Factory();
