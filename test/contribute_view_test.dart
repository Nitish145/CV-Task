import 'package:cv_projects_task/ui/components/contribute_card_donate.dart';
import 'package:cv_projects_task/ui/components/contribute_card_social.dart';
import 'package:cv_projects_task/ui/components/contribute_card_support.dart';
import 'package:cv_projects_task/ui/views/contributors_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpContributorsView(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ContributorsView(),
      ),
    );
  }

  testWidgets("Contributors View Widgets", (WidgetTester tester) async {
    await pumpContributorsView(tester);

    expect(find.text("CONTRIBUTE"), findsOneWidget);
    expect(find.byType(ContributeCardSocial), findsNWidgets(3));
    expect(find.text("How to Support ?"), findsOneWidget);
    expect(find.byType(ContributeCardSupport), findsNWidgets(3));
    expect(find.byType(ContributeCardDonate), findsNWidgets(2));
  });
}
