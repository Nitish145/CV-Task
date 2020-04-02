import 'package:cv_projects_task/components/contribute_card_donate.dart';
import 'package:cv_projects_task/components/contribute_card_social.dart';
import 'package:cv_projects_task/components/contribute_card_support.dart';
import 'package:cv_projects_task/contributors_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpContributorsPage(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ContributorsPage(),
      ),
    );
  }

  testWidgets("Contributors Page Widgets", (WidgetTester tester) async {
    await pumpContributorsPage(tester);

    expect(find.text("CONTRIBUTE"), findsOneWidget);
    expect(find.byType(ContributeCardSocial), findsNWidgets(3));
    expect(find.text("How to Support ?"), findsOneWidget);
    expect(find.byType(ContributeCardSupport), findsNWidgets(3));
    expect(find.byType(ContributeCardDonate), findsNWidgets(2));
  });
}
