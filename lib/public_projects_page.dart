import 'package:cv_projects_task/Services/projects.dart';
import 'package:cv_projects_task/components/project_card.dart';
import 'package:cv_projects_task/models/project_details.dart';
import 'package:flutter/material.dart';

class PublicProjectsPage extends StatefulWidget {
  @override
  _PublicProjectsPageState createState() => _PublicProjectsPageState();
}

class _PublicProjectsPageState extends State<PublicProjectsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Public Projects"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getPublicProjects(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  ProjectDetails projectDetails = snapshot.data[index];
                  return ProjectCard(
                    id: projectDetails.id,
                    name: projectDetails.name,
                    projectAccessType: projectDetails.projectAccessType,
                    createdAt: projectDetails.createdAt,
                    updatedAt: projectDetails.updatedAt,
                    imageUrl: projectDetails.imagePreview.url,
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
