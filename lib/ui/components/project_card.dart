import 'package:cv_projects_task/globals.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ProjectCard extends StatelessWidget {
  final int id;
  final String name;
  final projectAccessType;
  final createdAt;
  final updatedAt;
  final String imageUrl;

  const ProjectCard(
      {Key key,
      this.id,
      this.name,
      this.projectAccessType,
      this.createdAt,
      this.updatedAt,
      this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget getCardHeader() {
      return Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
        child: Center(
          child: Text(
            name,
            style: Theme.of(context).textTheme.headline,
          ),
        ),
      );
    }

    Widget getPreviewImage() {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        child: FadeInImage.memoryNetwork(
          height: 200,
          width: MediaQuery.of(context).size.width,
          placeholder: kTransparentImage,
          image: "${url + imageUrl}",
        ),
      );
    }

    Widget getCardFooter() {
      return Container(
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(4),
            bottomRight: Radius.circular(4),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "project_details", arguments: id);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              getCardHeader(),
              getPreviewImage(),
              getCardFooter()
            ],
          ),
        ),
      ),
    );
  }
}
