import 'package:cv_projects_task/ui/components/teachers_card.dart';
import 'package:cv_projects_task/ui/views/teachers_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpTeachersPage(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TeachersView(),
      ),
    );
  }

  testWidgets("Teachers Page Widgets", (WidgetTester tester) async {
    await pumpTeachersPage(tester);

    expect(find.text("TEACHERS"), findsOneWidget);
    expect(find.text("Benefits"), findsOneWidget);
    expect(find.byType(TeachersCard), findsNWidgets(4));
  });
}
