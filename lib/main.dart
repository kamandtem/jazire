import 'package:flutter/material.dart';
import 'data/full_content.dart';
import 'models/content_models.dart';
import 'services/handwriting_analyzer.dart';
import 'services/persian_joiner.dart';
import 'services/progress_store.dart';

void main()=>runApp(const AlefbaApp());
class AlefbaApp extends StatelessWidget{const AlefbaApp({super.key});@override Widget build(BuildContext c)=>MaterialApp(debugShowCheckedModeBanner:false,title:'جزیره الفبا',theme:ThemeData(useMaterial3:true,fontFamily:'Vazir',colorScheme:ColorScheme.fromSeed(seedColor:const Color(0xff8b4a68)),scaffoldBackgroundColor:const Color(0xfffffbf4)),home:const HomePage());}
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override Widget build(BuildContext c) {
    return Directionality(textDirection:TextDirection.rtl,child:Scaffold(
      appBar:AppBar(title:const Text('جزیرهٔ الفبا')),
      body:ListView(padding:const EdgeInsets.all(20),children:[
        const Text('هستهٔ آموزشی آماده است',style:TextStyle(fontSize:26,fontWeight:FontWeight.w800)),
        const SizedBox(height:8),
        const Text('ارزیابی دست‌خط، اتصال فارسی و قواعد نوشتاری اکنون ماژولار هستند.'),
        const SizedBox(height:24),
        ListTile(tileColor:const Color(0xffffedd9),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(18)),leading:const CircleAvatar(child:Text('۱')),title:Text(allLessons.first.title),subtitle:Text('${allLessons.first.words.length} واژه، ${allLessons.first.exercises.length} تمرین'),trailing:const Icon(Icons.play_arrow_rounded),onTap:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>LessonPage(lesson:allLessons.first)))),
        const SizedBox(height:18),
        FilledButton.icon(onPressed:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>const MechanicsPage())),icon:const Icon(Icons.tune_rounded),label:const Text('آزمایش موتور نوشتار')),
      ]),
    ));
  }
}
class LessonPage extends StatelessWidget {
  const LessonPage({super.key,required this.lesson});
  final LessonPack lesson;
  @override Widget build(BuildContext c){
    return Directionality(textDirection:TextDirection.rtl,child:Scaffold(
      appBar:AppBar(title:Text(lesson.title)),
      body:ListView.separated(
        padding:const EdgeInsets.all(20),
        itemCount:lesson.exercises.length,
        separatorBuilder:(_,__)=>const SizedBox(height:10),
        itemBuilder:(_,i){
          final e=lesson.exercises[i];
          return ListTile(tileColor:const Color(0xfffff0d8),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(18)),leading:CircleAvatar(child:Text('${i+1}')),title:Text(e.prompt),trailing:const Icon(Icons.arrow_back_rounded),onTap:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>TraceExercise(exercise:e))));
        },
      ),
    ));
  }
}
class TraceExercise extends StatefulWidget {
  const TraceExercise({super.key,required this.exercise});
  final ExerciseItem exercise;
  @override State<TraceExercise> createState()=>_TraceState();
}
class _TraceState extends State<TraceExercise> {
  final strokes=<StrokeSample>[]; final current=<Offset>[]; final analyzer=const HandwritingAnalyzer(); HandwritingResult? result;
  @override Widget build(BuildContext c){
    return Directionality(textDirection:TextDirection.rtl,child:Scaffold(
      appBar:AppBar(title:const Text('ارزیابی دست‌خط')),
      body:Padding(padding:const EdgeInsets.all(20),child:Column(children:[
        Text(widget.exercise.prompt,style:const TextStyle(fontSize:22,fontWeight:FontWeight.bold)),
        const SizedBox(height:12),
        Expanded(child:LayoutBuilder(builder:(_,box)=>GestureDetector(
          onPanStart:(d)=>setState(()=>current.add(d.localPosition)),
          onPanUpdate:(d)=>setState(()=>current.add(d.localPosition)),
          onPanEnd:(_){strokes.add(StrokeSample(List.of(current)));current.clear();setState((){});},
          child:CustomPaint(painter:TracePainter(widget.exercise.target??'آ',strokes,current),size:Size(box.maxWidth,box.maxHeight)),
        ))),
        const SizedBox(height:12),
        if(result!=null)Text(result!.message,style:TextStyle(color:result!.accepted?Colors.green:Colors.red,fontWeight:FontWeight.bold)),
        const SizedBox(height:8),
        Row(children:[Expanded(child:OutlinedButton(onPressed:()=>setState(()=>strokes.clear()),child:const Text('پاک کردن'))),const SizedBox(width:10),Expanded(child:FilledButton(onPressed:()=>setState(()=>result=analyzer.analyze(strokes:strokes,target:Rect.fromLTWH(20,20,MediaQuery.sizeOf(c).width-40,MediaQuery.sizeOf(c).height*.7))),child:const Text('تحلیل نوشته')))]),
      ])),
    ));
  }
}
class TracePainter extends CustomPainter {
  TracePainter(this.glyph,this.strokes,this.current); final String glyph; final List<StrokeSample> strokes; final List<Offset> current;
  @override void paint(Canvas c,Size s){final t=TextPainter(text:TextSpan(text:glyph,style:const TextStyle(fontFamily:'WmTahriri',fontSize:220,color:Color(0xffd8d5cf))),textDirection:TextDirection.rtl)..layout();t.paint(c,Offset((s.width-t.width)/2,(s.height-t.height)/2));final p=Paint()..color=const Color(0xffd65f4a)..strokeWidth=8..strokeCap=StrokeCap.round;for(final st in [...strokes,StrokeSample(current)]){for(var i=1;i<st.points.length;i++){c.drawLine(st.points[i-1],st.points[i],p);}}}
  @override bool shouldRepaint(covariant TracePainter o)=>true;
}
class MechanicsPage extends StatefulWidget {
  const MechanicsPage({super.key});
  @override State<MechanicsPage> createState()=>_MechanicsState();
}
class _MechanicsState extends State<MechanicsPage> {
  String text='مادر می رود';
  late final TextEditingController controller;
  @override void initState(){super.initState();controller=TextEditingController(text:text);}
  @override void dispose(){controller.dispose();super.dispose();}
  @override Widget build(BuildContext c){
    final join=defaultPersianJoiner.render(text);
    return Directionality(textDirection:TextDirection.rtl,child:Scaffold(
      appBar:AppBar(title:const Text('موتور نوشتار')),
      body:ListView(padding:const EdgeInsets.all(20),children:[
        const Text('اتصال حروف، حرکات، تشدید، نیم‌فاصله و «می»',style:TextStyle(fontSize:22,fontWeight:FontWeight.w800)),
        const SizedBox(height:18),
        TextField(controller:controller,onChanged:(v)=>setState(()=>text=v),textDirection:TextDirection.rtl,decoration:const InputDecoration(labelText:'متن آزمایشی',border:OutlineInputBorder())),
        const SizedBox(height:20),
        Text('فرم‌های آموزشی: $join',style:const TextStyle(fontFamily:'WmTahriri',fontSize:34)),
        const SizedBox(height:16),
        Text('نمونهٔ می: ${_mi(text)}',style:const TextStyle(fontFamily:'WmTahriri',fontSize:28)),
        Text('تشدید: بّ',style:const TextStyle(fontFamily:'WmTahriri',fontSize:28)),
        Text('نیم‌فاصله: می‌رود',style:const TextStyle(fontSize:18)),
      ]),
    ));
  }
  String _mi(String s)=>s.startsWith('می')?'می‌${s.substring(2).trim()}':s;
}
