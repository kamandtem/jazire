import 'package:flutter_test/flutter_test.dart';
import 'package:jazireh_alefba/main.dart';

void main() {
  testWidgets('app opens on the alphabet island', (tester) async {
    await tester.pumpWidget(const AlefbaApp());
    expect(find.text('جزیرهٔ الفبا'), findsOneWidget);
    expect(find.text('آزمایش موتور نوشتار'), findsOneWidget);
  });
}
