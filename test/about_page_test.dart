import 'package:cv_projects_task/about_page.dart';
import 'package:cv_projects_task/components/contribute_card_social.dart';
import 'package:cv_projects_task/components/team_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpAboutPage(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AboutPage(),
      ),
    );
  }

  testWidgets("About Page Widgets", (WidgetTester tester) async {
    await pumpAboutPage(tester);

    expect(find.text("ABOUT"), findsOneWidget);
    expect(find.byType(RaisedButton), findsNWidgets(2));
    expect(find.byType(ContributeCardSocial), findsNWidgets(2));
    expect(find.text("OUR TEAM"), findsOneWidget);
    expect(find.byType(TeamCard), findsNWidgets(3));
  });
}
