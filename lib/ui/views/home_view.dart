import 'package:cv_projects_task/globals.dart';
import 'package:cv_projects_task/keys.dart';
import 'package:cv_projects_task/ui/components/feature_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((_prefs) {
      setState(() {
        prefs = _prefs;
      });
    });
  }

  Widget getAppBar() {
    return AppBar(
      title: Text("CircuitVerse"),
      backgroundColor: Theme.of(context).primaryColor,
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
              Navigator.pushNamed(context, "teachers");
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
              Navigator.pushNamed(context, "contribute");
            },
          ),
        ),
      ],
    );
  }

  Widget drawerTile(String title, IconData iconData) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline,
      ),
    );
  }

  Widget _drawer(context) => Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Image.asset("assets/images/CircuitVerse.png"),
            ),
            InkWell(
              key: Key(Keys.aboutDrawerTile),
              child: drawerTile("About", FontAwesome5.address_card),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "about");
              },
            ),
            InkWell(
              key: Key(Keys.contributeDrawerTile),
              child: drawerTile("Contribute", Icons.add),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "contribute");
              },
            ),
            InkWell(
              key: Key(Keys.teachersDrawerTile),
              child: drawerTile("Teachers", Icons.account_balance),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "teachers");
              },
            ),
            InkWell(
              key: Key(Keys.publicProjectsDrawerTile),
              child: drawerTile("Public Projects", Ionicons.md_paper),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "public_projects");
              },
            ),
            prefs != null
                ? prefs.getBool("isLoggedIn") == true
                    ? ExpansionTile(
                        title: Text(
                          prefs.getString("currentUserName") ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .headline
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        children: <Widget>[
                          InkWell(
                            key: Key(Keys.profileDrawerTile),
                            child: drawerTile("Profile", FontAwesome5.user),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, "profile");
                            },
                          ),
                          InkWell(
                            key: Key(Keys.myProjectsDrawerTile),
                            child: drawerTile(
                                "My Projects", FontAwesome5.address_book),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, "my_projects");
                            },
                          ),
                          InkWell(
                            key: Key(Keys.logoutDrawerTile),
                            child: drawerTile("Log Out", Ionicons.ios_log_out),
                            onTap: () {
                              Navigator.pop(context);
                              prefs.clear();
                              setState(() {});
                              Fluttertoast.showToast(
                                  msg: "Logged Out Successfully");
                            },
                          ),
                        ],
                      )
                    : InkWell(
                        key: Key(Keys.loginDrawerTile),
                        child: drawerTile("Login", Ionicons.ios_log_in),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, "login");
                        },
                      )
                : Container()
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homePageScaffoldKey,
      appBar: getAppBar(),
      drawer: _drawer(context),
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
