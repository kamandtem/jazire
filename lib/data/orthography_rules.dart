class OrthographyRules {
  static const shortVowels = {'َ': 'a', 'ِ': 'e', 'ُ': 'o'};
  static const longVowels = {'آ': 'â', 'ا': 'â', 'و': 'u', 'ی': 'i'};
  static const shadda = 'ّ';
  static const zeroWidthJoiner = '\u200c';
  static String normalize(String text) => text.replaceAll('ي', 'ی').replaceAll('ك', 'ک').replaceAll(RegExp(r'\s+'), ' ').trim();
  static String addMiPrefix(String verb) => 'می$zeroWidthJoiner$verb';
  static String addShadda(String letter) => '$letter$shadda';
  static bool hasHalfSpace(String text) => text.contains(zeroWidthJoiner);
}
