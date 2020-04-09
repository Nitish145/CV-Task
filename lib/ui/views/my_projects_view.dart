import 'package:cv_projects_task/enums/view_state.dart';
import 'package:cv_projects_task/globals.dart';
import 'package:cv_projects_task/models/projects_response.dart' as Projects;
import 'package:cv_projects_task/ui/components/error_widget.dart';
import 'package:cv_projects_task/ui/components/loading_indicator.dart';
import 'package:cv_projects_task/ui/components/project_card.dart';
import 'package:cv_projects_task/ui/views/base_view.dart';
import 'package:cv_projects_task/viewmodels/my_projects_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class MyProjectsView extends StatefulWidget {
  final Client client;

  const MyProjectsView({Key key, this.client}) : super(key: key);
  @override
  _MyProjectsViewState createState() => _MyProjectsViewState();
}

class _MyProjectsViewState extends State<MyProjectsView> {
  ScrollController _scrollController = new ScrollController();
  List<Projects.Datum> dataList = new List();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<MyProjectsModel>(
      onModelReady: (model) {
        _scrollController.addListener(() {
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
            if (model.myProjects.meta.nextPage != null &&
                !model.isNextPageLoading) {
              model
                  .getMyProjects(model.myProjects.meta.nextPage,
                      client: widget.client)
                  .then((_) {
                model.myProjects.data.forEach((data) {
                  dataList.add(data);
                });
              }).catchError((e) {
                showSnackBar(myProjectsViewScaffoldKey, model.errorMessage);
              });
            }
          }
        });
        model.getMyProjects(1, client: widget.client).then((_) {
          model.myProjects.data.forEach((data) {
            dataList.add(data);
          });
        }).catchError((e) {
          showSnackBar(myProjectsViewScaffoldKey, model.errorMessage);
        });
      },
      builder: (context, model, child) => Scaffold(
        key: myProjectsViewScaffoldKey,
        appBar: AppBar(
          title: Text("My Projects"),
        ),
        body: !(model.state == ViewState.Error)
            ? model.state == ViewState.Busy && !model.isNextPageLoading
                ? LoadingIndicator()
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
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
                    },
                  )
            : CVErrorWidget(
                errorMessage: model.errorMessage,
              ),
      ),
    );
  }
}
