enum ExerciseType { trace, findLetter, buildWord }

class WordItem { const WordItem({required this.id,required this.text,required this.firstLesson,required this.segments}); final String id,text; final int firstLesson; final List<String> segments; }
class ExerciseItem { const ExerciseItem({required this.id,required this.type,required this.prompt,required this.lesson,this.target,this.options=const []}); final String id,prompt; final ExerciseType type; final int lesson; final String? target; final List<String> options; }

class LessonContent {
  const LessonContent({required this.id, required this.title, required this.signs, required this.words, required this.exercises});
  final int id;
  final String title;
  final List<String> signs;
  final List<WordItem> words;
  final List<ExerciseItem> exercises;
}
