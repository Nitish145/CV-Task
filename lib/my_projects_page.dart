import 'package:cv_projects_task/Services/projects.dart';
import 'package:cv_projects_task/components/project_card.dart';
import 'package:cv_projects_task/models/projects_response.dart' as Projects;
import 'package:flutter/material.dart';

class MyProjectsPage extends StatefulWidget {
  @override
  _MyProjectsPageState createState() => _MyProjectsPageState();
}

class _MyProjectsPageState extends State<MyProjectsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Projects"),
      ),
      body: FutureBuilder(
        future: getMyProjects(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Projects.ProjectsResponse projectsResponse = snapshot.data;
              return ListView.builder(
                itemCount: projectsResponse.data.length,
                itemBuilder: (context, index) {
                  Projects.Datum datum = projectsResponse.data[index];
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
