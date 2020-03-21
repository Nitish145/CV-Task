import 'package:cv_projects_task/components/contribute_card_social.dart';
import 'package:cv_projects_task/components/team_card.dart';
import 'package:cv_projects_task/globals.dart';
import 'package:cv_projects_task/models/team_member_model.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  Widget getHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              "ABOUT",
              style: Theme.of(context).textTheme.display2.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColorDark,
                  ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
              child: Text(
                "CircuitVerse is a product developed by students at IIIT-Bangalore. It aims to provide a platform where circuits can be designed and simulated using a graphical user interface. While users can design complete CPU implementations within the simulator, the software is designed primarily for educational use. CircuitVerse is an opensource project with an active community. Checkout the contribute page for more detail.",
                style: Theme.of(context).textTheme.subhead,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTosAndPrivacyButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text(
                "Terms Of Service",
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                launchURL("https://circuitverse.org/tos");
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text(
                "Privacy Policy",
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                launchURL("https://circuitverse.org/privacy");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getTeamsHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 54),
      child: Text(
        "OUR TEAM",
        style: Theme.of(context)
            .textTheme
            .headline
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Who Are We ?"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            getHeader(),
            getTosAndPrivacyButtons(),
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
            getTeamsHeader(),
            TeamCard(
              teamHeading: "Core Team",
              teamMembersList: [
                TeamMemberModel("Satvik Ramprasad", "Product Manager"),
                TeamMemberModel("Biswesh Mohapatra", "Lead Developer"),
                TeamMemberModel(
                    "Aditya Hegde", "SEO and Infrastructure Manager"),
              ],
            ),
            TeamCard(
              teamHeading: "Extended Team",
              teamMembersList: [
                TeamMemberModel("Vibhav Aggarwal", "Module developer"),
                TeamMemberModel(
                    "Abhishek Krishna", "UI designer and consultant"),
                TeamMemberModel(
                    "Aniruddha Mysore", "UI Designer and consultant"),
                TeamMemberModel("Shreyas Gupta", "Logo Designer"),
              ],
            ),
            TeamCard(
              teamHeading: "Mentors",
              teamMembersList: [
                TeamMemberModel("Prof. Subhajit Sen", "Domain Expert"),
                TeamMemberModel("Ramesh Sundararaman", "Brand Advisor"),
                TeamMemberModel("Vikas Yadav", "Technical Advisor"),
                TeamMemberModel("Gaurav Koley", "Technical Advisor"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
