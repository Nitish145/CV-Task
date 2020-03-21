import 'package:cv_projects_task/components/teachers_card.dart';
import 'package:flutter/material.dart';

class TeachersPage extends StatefulWidget {
  @override
  _TeachersPageState createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> {
  Widget getHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              "TEACHERS",
              style: Theme.of(context).textTheme.display2.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColorDark,
                  ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
              child: Text(
                "CircuitVerse has been designed to be very easy to use in class. The platform has features to assist teachers in class and assignments.",
                style: Theme.of(context).textTheme.subhead,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget benefitsHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        "Benefits",
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
      appBar: AppBar(
        title: Text("Teachers In Mind ?"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            getHeader(),
            benefitsHeader(),
            TeachersCard(
              assetPath: "assets/images/teachers/groups.png",
              cardHeading: "Create Groups and add your students",
              cardDescription:
                  "You can create groups and add your students to them! If students are already registered with CircuitVerse they will be added automatically. If they are not registered with CircuitVerse yet, an invitation will be sent to register. Once they register, they will be added automatically.",
              isOdd: true,
            ),
            TeachersCard(
              assetPath: "assets/images/teachers/assignment.png",
              cardHeading: "Post Assignments",
              cardDescription:
                  "To create an assignment, simply click an add new assignment button. Give the details of the assignment and the deadline. The assignment will automatically close at deadline. Students cannot continue their assignment unless the teacher reopens the assignment again.",
              isOdd: false,
            ),
            TeachersCard(
              assetPath: "assets/images/teachers/grading.png",
              cardHeading: "Grading assignments",
              cardDescription:
                  "Grade assignments very easily with the in build preview. Simply select the student, to his/her assignment work.",
              isOdd: true,
            ),
            TeachersCard(
              assetPath: "assets/images/teachers/embed.png",
              cardHeading:
                  "Use Interactive Circuits in your Blogs, Study Materials or PowerPoint presentations",
              cardDescription:
                  "Make sure the project is public. Click on embed, to get the embed HTML5 code, then simply embed the circuit. You may need to use a PowerPoint plugin like Live Slides to embed the live Circuit.",
              isOdd: false,
            ),
          ],
        ),
      ),
    );
  }
}
