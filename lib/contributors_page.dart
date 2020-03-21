import 'package:cv_projects_task/components/contribute_card_donate.dart';
import 'package:cv_projects_task/components/contribute_card_social.dart';
import 'package:cv_projects_task/components/contribute_card_support.dart';
import 'package:flutter/material.dart';

class ContributorsPage extends StatefulWidget {
  @override
  _ContributorsPageState createState() => _ContributorsPageState();
}

class _ContributorsPageState extends State<ContributorsPage> {
  Widget getHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              "CONTRIBUTE",
              style: Theme.of(context).textTheme.display2.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColorDark,
                  ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
              child: Text(
                "CircuitVerse aims to be free forever and we promise that we won't run any ads! The project is open source and to ensure its continued development and maintenance we need your support.",
                style: Theme.of(context).textTheme.subhead,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getSupportHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 32),
      child: Text(
        "How to Support ?",
        style: Theme.of(context)
            .textTheme
            .display1
            .copyWith(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            getHeader(),
            ContributeCardSocial(
              imagePath: "assets/images/contribute/email.png",
              cardHead: "Email us at",
              cardDescription: "support@circuitverse.org",
              url: "mailto:support@circuitverse.org",
            ),
            ContributeCardSocial(
              imagePath: "assets/images/contribute/slack.png",
              cardHead: "Join and chat with us at",
              cardDescription: "Slack channel",
              url:
                  "https://join.slack.com/t/circuitverse-team/shared_invite/enQtNjc4MzcyNDE5OTA3LTdjYTM5NjFiZWZlZGI2MmU1MmYzYzczNmZlZDg5MjYxYmQ4ODRjMjQxM2UyMWI5ODUzODQzMDU2ZDEzNjI4NmE",
            ),
            ContributeCardSocial(
              imagePath: "assets/images/contribute/github.png",
              cardHead: "Contribute to open source",
              cardDescription: "Github",
              url: "https://github.com/CircuitVerse",
            ),
            getSupportHeader(),
            ContributeCardSupport(
              imagePath: "assets/images/contribute/person.png",
              cardHead: "I am a Student",
              cardDescriptionList: [
                "Create amazing circuits and share on the platform",
                "Find and report bugs. Become a bug hunter",
                "Introduce the platform to your buddie"
              ],
            ),
            ContributeCardSupport(
              imagePath: "assets/images/contribute/professor.png",
              cardHead: "I am a Teacher",
              cardDescriptionList: [
                "Introduce the platform to your students",
                "Promote the platform within your circles",
                "Create exciting educational content using CircuitVerse"
              ],
            ),
            ContributeCardSupport(
              imagePath: "assets/images/contribute/person.png",
              cardHead: "I am a Developer",
              cardDescriptionList: [
                "Contribute to the OpenSource projects",
                "Add and propose new features to the projects",
                "Find and fix bugs in the CircuitVerse projects"
              ],
            ),
            ContributeCardDonate(
              logoPath: "assets/images/contribute/patreon-logo.png",
              header: "Become a Patreon",
              url: "https://www.patreon.com/CircuitVerse",
            ),
            ContributeCardDonate(
              logoPath: "assets/images/contribute/paypal-logo.jpg",
              header: "Donate through PayPal",
              url: "https://www.paypal.me/satviksr",
            )
          ],
        ),
      ),
    );
  }
}
