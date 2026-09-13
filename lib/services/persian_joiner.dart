import 'package:characters/characters.dart';

enum GlyphPosition { isolated, initial, medial, finalForm }
class GlyphShape { const GlyphShape({required this.isolated, required this.initial, required this.medial, required this.finalShape, this.canJoinNext = true, this.canJoinPrevious = true}); final String isolated, initial, medial, finalShape; final bool canJoinNext, canJoinPrevious; }

class PersianJoiner {
  const PersianJoiner(this.glyphs);
  final Map<String, GlyphShape> glyphs;
  List<String> splitGraphemes(String text) => text.characters.toList();
  String render(String text) {
    final chars = splitGraphemes(text);
    final out = <String>[];
    for (var i = 0; i < chars.length; i++) {
      final shape = glyphs[chars[i]];
      if (shape == null || chars[i] == '\u200c') { out.add(chars[i]); continue; }
      final previous = i > 0 ? glyphs[chars[i - 1]] : null;
      final next = i + 1 < chars.length ? glyphs[chars[i + 1]] : null;
      final joinsPrevious = previous != null && previous.canJoinNext && shape.canJoinPrevious;
      final joinsNext = next != null && shape.canJoinNext && next.canJoinPrevious;
      out.add(joinsPrevious && joinsNext ? shape.medial : joinsPrevious ? shape.finalShape : joinsNext ? shape.initial : shape.isolated);
    }
    return out.join();
  }
  String normalizeLearningText(String text) => text.replaceAll('ي', 'ی').replaceAll('ك', 'ک').replaceAll(RegExp(r'\s+'), ' ').trim();
}

const defaultPersianJoiner = PersianJoiner({
  'آ': GlyphShape(isolated: 'آ', initial: 'آ', medial: 'آ', finalShape: 'آ', canJoinNext: false, canJoinPrevious: false),
  'ا': GlyphShape(isolated: 'ا', initial: 'ا', medial: 'ـا', finalShape: 'ـا', canJoinNext: false),
  'ب': GlyphShape(isolated: 'ب', initial: 'بـ', medial: 'ـبـ', finalShape: 'ـب'),
  'پ': GlyphShape(isolated: 'پ', initial: 'پـ', medial: 'ـپـ', finalShape: 'ـپ'),
  'ت': GlyphShape(isolated: 'ت', initial: 'تـ', medial: 'ـتـ', finalShape: 'ـت'),
  'م': GlyphShape(isolated: 'م', initial: 'مـ', medial: 'ـمـ', finalShape: 'ـم'),
  'س': GlyphShape(isolated: 'س', initial: 'سـ', medial: 'ـسـ', finalShape: 'ـس'),
  'ن': GlyphShape(isolated: 'ن', initial: 'نـ', medial: 'ـنـ', finalShape: 'ـن'),
  'د': GlyphShape(isolated: 'د', initial: 'د', medial: 'د', finalShape: 'د', canJoinNext: false),
  'ر': GlyphShape(isolated: 'ر', initial: 'ر', medial: 'ر', finalShape: 'ر', canJoinNext: false),
});
