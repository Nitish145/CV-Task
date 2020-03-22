import 'package:cv_projects_task/Services/projects.dart';
import 'package:cv_projects_task/globals.dart';
import 'package:cv_projects_task/models/project_model_response.dart'
    as ProjectModel;
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
          style: Theme.of(context).textTheme.headline,
          children: <TextSpan>[
            TextSpan(
              text: "$heading : ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: content,
              style: Theme.of(context).textTheme.headline,
            )
          ],
        ),
      ),
    );
  }

  Widget getTagsRow(List<ProjectModel.Tag> tags) {
    List<Widget> tagsList = tags
        .map((tag) => Padding(
              padding: const EdgeInsets.all(4),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color.fromRGBO(230, 255, 230, 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(tag.name),
                ),
              ),
            ))
        .toList();
    tagsList.insert(
      0,
      Padding(
        padding: const EdgeInsets.all(4),
        child: Text(
          "Tags : ",
          style: Theme.of(context)
              .textTheme
              .headline
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Wrap(
        children: tagsList,
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
        future: getPublicProjectDetails(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              ProjectModel.ProjectModelResponse projectModelResponse =
                  snapshot.data;
              ProjectModel.Data data = projectModelResponse.data;
              ProjectModel.DataAttributes dataAttributes = data.attributes;
              ProjectModel.IncludedAttributes includedAttributes =
                  projectModelResponse.included[0].attributes;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      child: FadeInImage.memoryNetwork(
                        width: MediaQuery.of(context).size.width,
                        placeholder: kTransparentImage,
                        image: "${url + dataAttributes.imagePreview.url}",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 8),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          dataAttributes.name,
                          style: Theme.of(context).textTheme.display1.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                    getTextRow(
                      "Author",
                      includedAttributes.name,
                    ),
                    getTextRow(
                      "Views",
                      dataAttributes.view.toString(),
                    ),
                    getTextRow(
                      "Stars",
                      dataAttributes.starsCount.toString(),
                    ),
                    getTagsRow(dataAttributes.tags),
                    getTextRow(
                      "Project Access Type",
                      dataAttributes.projectAccessType,
                    ),
                    getTextRow(
                      "Description",
                      _parseHtmlString(dataAttributes.description ?? ""),
                    ),
                    getTextRow(
                      "Created At",
                      format.format(dataAttributes.createdAt),
                    ),
                    getTextRow(
                      "Last Updated",
                      timeago.format(dataAttributes.updatedAt),
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
