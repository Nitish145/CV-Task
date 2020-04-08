import 'package:cv_projects_task/enums/view_state.dart';
import 'package:cv_projects_task/models/user_response.dart' as User;
import 'package:cv_projects_task/ui/components/error_widget.dart';
import 'package:cv_projects_task/ui/components/loading_indicator.dart';
import 'package:cv_projects_task/ui/views/base_view.dart';
import 'package:cv_projects_task/viewmodels/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:timeago/timeago.dart' as timeago;

class ProfileView extends StatefulWidget {
  final Client client;

  const ProfileView({Key key, this.client}) : super(key: key);
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Widget getProfileImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: CircleAvatar(
        radius: 75,
        backgroundColor: Colors.white,
        child: Icon(
          Icons.account_circle,
          size: 150,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget getProfileRow(String heading, String description) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: RichText(
          text: TextSpan(
              style: Theme.of(context).textTheme.headline,
              children: <TextSpan>[
                TextSpan(
                    text: heading,
                    style: Theme.of(context)
                        .textTheme
                        .headline
                        .copyWith(fontWeight: FontWeight.bold)),
                TextSpan(text: description)
              ]),
        ),
      ),
    );
  }

  Widget getUserNameAndEmailWidget(String name, String email) {
    return Column(
      children: <Widget>[
        Text(
          name,
          style: Theme.of(context)
              .textTheme
              .display1
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Text(email, style: Theme.of(context).textTheme.subhead),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileModel>(
      onModelReady: (model) => model.getUserProfile(client: widget.client),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            "Your Profile",
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.edit),
          tooltip: "Edit Profile",
          onPressed: () {},
        ),
        body: model.state == ViewState.Busy
            ? LoadingIndicator()
            : model.state == ViewState.Error
                ? CVErrorWidget(errorMessage: model.errorMessage)
                : Builder(
                    builder: (context) {
                      User.Attributes attributes =
                          model.userProfile.data.attributes;
                      return SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            getProfileImage(),
                            getUserNameAndEmailWidget(
                                attributes.name ?? "", attributes.email ?? ""),
                            SizedBox(
                              height: 20,
                            ),
                            getProfileRow("Joined : ",
                                timeago.format(attributes.createdAt)),
                            getProfileRow("Country : ",
                                attributes.country ?? "".toString()),
                            getProfileRow(
                                "Educational Institute : ",
                                attributes.educationalInstitute ??
                                    "".toString()),
                            getProfileRow("Subscribed to mails : ",
                                attributes.subscribed.toString()),
                          ],
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
