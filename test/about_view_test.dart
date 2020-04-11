import 'package:cv_projects_task/ui/components/contribute_card_social.dart';
import 'package:cv_projects_task/ui/components/team_card.dart';
import 'package:cv_projects_task/ui/views/about_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpAboutView(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AboutView(),
      ),
    );
  }

  testWidgets("About View Widgets", (WidgetTester tester) async {
    await pumpAboutView(tester);

    expect(find.text("ABOUT"), findsOneWidget);
    expect(find.byType(RaisedButton), findsNWidgets(2));
    expect(find.byType(ContributeCardSocial), findsNWidgets(2));
    expect(find.text("OUR TEAM"), findsOneWidget);
    expect(find.byType(TeamCard), findsNWidgets(3));
  });
}
