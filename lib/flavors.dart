enum Flavor {
  trivia1,
  trivia2,
  trivia3,
}

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.trivia1:
        return 'Trivia App V1';
      case Flavor.trivia2:
        return 'Trivia App V2';
      case Flavor.trivia3:
        return 'Trivia App V3';
    }
  }

}
