import 'package:cv_projects_task/enums/view_state.dart';
import 'package:cv_projects_task/globals.dart';
import 'package:cv_projects_task/models/projects_response.dart' as Projects;
import 'package:cv_projects_task/ui/components/error_widget.dart';
import 'package:cv_projects_task/ui/components/loading_indicator.dart';
import 'package:cv_projects_task/ui/components/project_card.dart';
import 'package:cv_projects_task/ui/views/base_view.dart';
import 'package:cv_projects_task/viewmodels/public_projects_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class PublicProjectsView extends StatefulWidget {
  final Client client;

  const PublicProjectsView({Key key, this.client}) : super(key: key);
  @override
  _PublicProjectsViewState createState() => _PublicProjectsViewState();
}

class _PublicProjectsViewState extends State<PublicProjectsView> {
  ScrollController _scrollController = new ScrollController();
  List<Projects.Datum> dataList = new List();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<PublicProjectsModel>(
      onModelReady: (model) {
        model
            .getPublicProjects(1, client: widget.client)
            .then((publicProjects) {
          if (publicProjects != null)
            publicProjects.data.forEach((data) {
              dataList.add(data);
            });
          if (model.state == ViewState.Error)
            showSnackBar(publicProjectsViewScaffoldKey, model.errorMessage);
        });
        _scrollController.addListener(() {
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
            if (model.publicProjects.meta.nextPage != null) {
              model
                  .getPublicProjects(model.publicProjects.meta.nextPage,
                      client: widget.client)
                  .then((publicProjects) {
                if (publicProjects != null)
                  publicProjects.data.forEach((data) {
                    dataList.add(data);
                  });
                if (model.state == ViewState.Error)
                  showSnackBar(
                      publicProjectsViewScaffoldKey, model.errorMessage);
              });
            }
          }
        });
      },
      builder: (context, model, child) => Scaffold(
        key: publicProjectsViewScaffoldKey,
        appBar: AppBar(
          title: Text("Public Projects"),
        ),
        body: (model.state == ViewState.Error) && dataList.isEmpty
            ? CVErrorWidget(
                errorMessage: model.errorMessage,
              )
            : model.state == ViewState.Busy && dataList.isEmpty
                ? LoadingIndicator()
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: model.publicProjects.meta.nextPage != null &&
                            model.state != ViewState.Error
                        ? dataList.length + 1
                        : dataList.length,
                    itemBuilder: (context, index) {
                      if (index == dataList.length &&
                          model.state != ViewState.Error) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else {
                        Projects.Datum datum = dataList[index];
                        Projects.DatumAttributes datumAttributes =
                            datum.attributes;
                        return ProjectCard(
                          id: int.parse(datum.id),
                          name: datumAttributes.name,
                          projectAccessType: datumAttributes.projectAccessType,
                          createdAt: datumAttributes.createdAt,
                          updatedAt: datumAttributes.updatedAt,
                          imageUrl: datumAttributes.imagePreview.url,
                        );
                      }
                    },
                  ),
      ),
    );
  }
}
