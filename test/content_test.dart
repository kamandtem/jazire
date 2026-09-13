import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jazireh_alefba/data/lesson_one.dart';
import 'package:jazireh_alefba/services/persian_joiner.dart';
import 'package:jazireh_alefba/services/handwriting_analyzer.dart';

void main(){
  test('lesson one content ids are unique',(){final ids={...lessonOne.words.map((x)=>x.id),...lessonOne.exercises.map((x)=>x.id)};expect(ids.length,lessonOne.words.length+lessonOne.exercises.length);});
  test('lesson one words unlock in lesson one',(){expect(lessonOne.words.every((x)=>x.firstLesson==1),isTrue);});
  test('lesson one has eight exercises',(){expect(lessonOne.exercises.length,8);});
  test('joiner handles normalized Persian text',(){expect(defaultPersianJoiner.normalizeLearningText('ك ي'),'ک ی');});
  test('handwriting analyzer rejects empty input',(){final result=const HandwritingAnalyzer().analyze(strokes:const [],target:const Rect.fromLTWH(0,0,100,100));expect(result.accepted,isFalse);});
}
