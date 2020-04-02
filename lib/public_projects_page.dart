import 'package:cv_projects_task/Services/projects.dart';
import 'package:cv_projects_task/components/project_card.dart';
import 'package:cv_projects_task/models/projects_response.dart' as Projects;
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class PublicProjectsPage extends StatefulWidget {
  final Client client;

  const PublicProjectsPage({Key key, this.client}) : super(key: key);
  @override
  _PublicProjectsPageState createState() => _PublicProjectsPageState();
}

class _PublicProjectsPageState extends State<PublicProjectsPage> {
  ScrollController _scrollController = new ScrollController();
  List<Projects.Datum> dataList = new List();
  bool isInitialLoading = true;
  bool isNextPageLoading = false;
  bool isError = false;
  Projects.Meta meta;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (meta.nextPage != null) {
          setState(() {
            isNextPageLoading = true;
          });
          getPublicProjects(meta.nextPage, httpClient: widget.client)
              .then((projectsResponse) {
            projectsResponse.data.forEach((data) {
              dataList.add(data);
            });
            setState(() {
              meta = projectsResponse.meta;
              isNextPageLoading = false;
            });
          }).catchError((e) {
            setState(() {
              isError = true;
              isNextPageLoading = false;
            });
          });
        }
      }
    });
    getPublicProjects(1, httpClient: widget.client).then((projectsResponse) {
      projectsResponse.data.forEach((data) {
        dataList.add(data);
      });
      setState(() {
        isInitialLoading = false;
        meta = projectsResponse.meta;
      });
    }).catchError((e) {
      setState(() {
        isError = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Public Projects"),
      ),
      body: !isError
          ? isInitialLoading
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    Projects.Datum datum = dataList[index];
                    Projects.DatumAttributes datumAttributes = datum.attributes;
                    return ProjectCard(
                      id: int.parse(datum.id),
                      name: datumAttributes.name,
                      projectAccessType: datumAttributes.projectAccessType,
                      createdAt: datumAttributes.createdAt,
                      updatedAt: datumAttributes.updatedAt,
                      imageUrl: datumAttributes.imagePreview.url,
                    );
                  },
                )
          : Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    "Something Went Wrong! Please try again later",
                    style: Theme.of(context).textTheme.subhead,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
    );
  }
}
