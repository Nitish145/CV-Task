import 'package:cv_projects_task/Services/projects.dart';
import 'package:cv_projects_task/globals.dart';
import 'package:cv_projects_task/models/project_details.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:transparent_image/transparent_image.dart';

class ProjectDetailPage extends StatefulWidget {
  final int id;

  const ProjectDetailPage({Key key, this.id}) : super(key: key);

  @override
  _ProjectDetailPageState createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  DateFormat format = new DateFormat.yMMMMd("en_US");

  Widget getTextRow(String heading, String content) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.display1,
          children: <TextSpan>[
            TextSpan(
              text: "$heading : ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: content,
              style: Theme.of(context).textTheme.display2,
            )
          ],
        ),
      ),
    );
  }

  String _parseHtmlString(String htmlString) {
    var document = parse(htmlString);
    String parsedString = parse(document.body.text).documentElement.text;
    return parsedString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Project Details Page",
        ),
      ),
      body: FutureBuilder(
        future: getProjectDetails(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              ProjectDetails projectDetails = snapshot.data;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      child: FadeInImage.memoryNetwork(
                        width: MediaQuery.of(context).size.width,
                        placeholder: kTransparentImage,
                        image: "${url + projectDetails.imagePreview.url}",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 8),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          projectDetails.name,
                          style: Theme.of(context).textTheme.headline.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                    getTextRow(
                      "Author",
                      projectDetails.author.name,
                    ),
                    getTextRow(
                      "Views",
                      projectDetails.view.toString(),
                    ),
                    getTextRow(
                      "Project Access Type",
                      projectDetails.projectAccessType,
                    ),
                    getTextRow(
                      "Description",
                      _parseHtmlString(projectDetails.description),
                    ),
                    getTextRow(
                      "Created At",
                      format.format(projectDetails.createdAt),
                    ),
                    getTextRow(
                      "Last Updated",
                      timeago.format(projectDetails.updatedAt),
                    )
                  ],
                ),
              );
            } else {
              if (snapshot.hasError)
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child:
                          Text("Something Went Wrong! Please try again later"),
                    ),
                  ),
                );
              else
                return Container();
            }
          } else {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
