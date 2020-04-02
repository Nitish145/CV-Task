import 'package:cv_projects_task/Services/user.dart';
import 'package:cv_projects_task/models/user_response.dart' as User;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:timeago/timeago.dart' as timeago;

class ProfilePage extends StatefulWidget {
  final Client client;

  const ProfilePage({Key key, this.client}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    return Scaffold(
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
      body: FutureBuilder(
        future: userMeGet(httpClient: widget.client),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              User.UserResponse userResponse = snapshot.data;
              User.Attributes attributes = userResponse.data.attributes;
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    getProfileImage(),
                    getUserNameAndEmailWidget(
                        attributes.name ?? "", attributes.email ?? ""),
                    SizedBox(
                      height: 20,
                    ),
                    getProfileRow(
                        "Joined : ", timeago.format(attributes.createdAt)),
                    getProfileRow(
                        "Country : ", attributes.country ?? "".toString()),
                    getProfileRow("Educational Institute : ",
                        attributes.educationalInstitute ?? "".toString()),
                    getProfileRow("Subscribed to mails : ",
                        attributes.subscribed.toString()),
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
