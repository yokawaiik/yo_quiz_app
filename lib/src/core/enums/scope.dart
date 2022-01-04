
enum Scope {
  public,
  private,
}

const String _keyValuePublic = "public";
const String _keyValuePrivate = "private";

extension Scopes on Scope {
  static Scope fromString(String string) {
    switch (string) {
      case _keyValuePublic:
        return Scope.public;
      case _keyValuePrivate:
        return Scope.private;
    }
    throw Exception("unsupported type");
  }

  String get asString {
    switch (this) {
      case Scope.public:
        return _keyValuePublic;
      case Scope.private:
        return _keyValuePrivate;
    }
  }
}