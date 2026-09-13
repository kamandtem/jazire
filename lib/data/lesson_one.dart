import '../models/content_models.dart';

const lessonOne = LessonContent(
  id: 1,
  title: 'درس ۱: آ، ا، بـ، ب',
  signs: ['آ', 'ا', 'بـ', 'ب'],
  words: [
    WordItem(id: 'l01-w01', text: 'آب', firstLesson: 1, segments: ['آ', 'ب']),
    WordItem(id: 'l01-w02', text: 'بابا', firstLesson: 1, segments: ['بـ', 'ا', 'بـ', 'ا']),
    WordItem(id: 'l01-w03', text: 'با', firstLesson: 1, segments: ['بـ', 'ا']),
  ],
  exercises: [
    ExerciseItem(id: 'l01-e01', type: ExerciseType.trace, prompt: 'نشانهٔ آ را با انگشت دنبال کن.', lesson: 1, target: 'آ'),
    ExerciseItem(id: 'l01-e02', type: ExerciseType.trace, prompt: 'نشانهٔ ا را با انگشت دنبال کن.', lesson: 1, target: 'ا'),
    ExerciseItem(id: 'l01-e03', type: ExerciseType.trace, prompt: 'نشانهٔ بـ را با انگشت دنبال کن.', lesson: 1, target: 'بـ'),
    ExerciseItem(id: 'l01-e04', type: ExerciseType.trace, prompt: 'نشانهٔ ب را با انگشت دنبال کن.', lesson: 1, target: 'ب'),
    ExerciseItem(id: 'l01-e05', type: ExerciseType.findLetter, prompt: 'همهٔ «آ»ها را پیدا کن.', lesson: 1, target: 'آ', options: ['ب', 'آ', 'ا', 'آ', 'بـ', 'آ']),
    ExerciseItem(id: 'l01-e06', type: ExerciseType.findLetter, prompt: 'همهٔ «ب»ها را پیدا کن.', lesson: 1, target: 'ب', options: ['ب', 'ا', 'آ', 'ب', 'بـ', 'ا']),
    ExerciseItem(id: 'l01-e07', type: ExerciseType.buildWord, prompt: 'واژهٔ «آب» را بساز.', lesson: 1, target: 'آب', options: ['ب', 'آ', 'ا']),
    ExerciseItem(id: 'l01-e08', type: ExerciseType.buildWord, prompt: 'واژهٔ «بابا» را بساز.', lesson: 1, target: 'بابا', options: ['ا', 'بـ', 'آ', 'بـ', 'ا']),
  ],
);