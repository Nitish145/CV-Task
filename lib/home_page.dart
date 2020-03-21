import 'package:cv_projects_task/components/feature_card.dart';
import 'package:cv_projects_task/contributors_page.dart';
import 'package:cv_projects_task/teachers_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget getAppBar() {
    return AppBar(
      title: Text("CircuitVerse"),
      backgroundColor: Colors.grey[300],
      centerTitle: true,
    );
  }

  Widget getHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        "Dive into the world of Logic Circuits for free!",
        style: Theme.of(context)
            .textTheme
            .display2
            .copyWith(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget getSubhead() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "From Simple gates to complex sequential circuits, plot timimg diagrams, automatic circuit generation, explore standard ICs, and much more",
        style: Theme.of(context).textTheme.subhead,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget getHomePageSketch() {
    return Image.asset("assets/images/homepage/new-homepage-sketch.png");
  }

  Widget getFeaturesHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Features",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .display1
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Design circuits quickly and easily with a modern and intuitive user interface with drag-and-drop, copy/paste, zoom and more.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subhead,
            ),
          )
        ],
      ),
    );
  }

  Widget getTeachersAndContributorButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: OutlineButton(
            child: Text("For Teachers"),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColorDark,
              width: 2,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TeachersPage()));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: OutlineButton(
            child: Text("For Contributors"),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColorDark,
              width: 2,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ContributorsPage()));
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                getHeader(),
                getSubhead(),
                getHomePageSketch(),
                getTeachersAndContributorButtons(),
                getFeaturesHeader(),
                FeatureCard(
                  assetPath: "assets/images/homepage/export-hd.png",
                  cardHeading: "Explore High Resolution Images",
                  cardDescription:
                      "CircuitVerse can export high resolution images in multiple formats including SVG.",
                ),
                FeatureCard(
                  assetPath:
                      "assets/images/homepage/combinational-analysis.png",
                  cardHeading: "Combinational Analysis",
                  cardDescription:
                      "Automatically generate circuit based on truth table data. This is great to create complex logic circuits and can be easily be made into a subcircuit.",
                ),
                FeatureCard(
                  assetPath: "assets/images/homepage/embed.png",
                  cardHeading: "Embed in Blogs",
                  cardDescription:
                      "Since CircuitVerse is built in HTML5, an iFrame can be generated for each project allowing the user to embed it almost anywhere.",
                ),
                FeatureCard(
                  assetPath: "assets/images/homepage/sub-circuit.png",
                  cardHeading: "Use Sub circuits",
                  cardDescription:
                      "Create subcircuits once and use them repeatedly. This allows easier and more structured design.",
                ),
                FeatureCard(
                  assetPath: "assets/images/homepage/multi-bit-bus.png",
                  cardHeading: "Multi Bit Buses and components",
                  cardDescription:
                      "CircuitVerse supports multi bit wires, this means circuit design is easier, faster and uncluttered.",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
