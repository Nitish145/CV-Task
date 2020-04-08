import 'package:cv_projects_task/models/team_member_model.dart';
import 'package:flutter/material.dart';

class TeamCard extends StatelessWidget {
  final String teamHeading;
  final List<TeamMemberModel> teamMembersList;

  const TeamCard({Key key, this.teamHeading, this.teamMembersList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(4),
                  topLeft: Radius.circular(4),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Text(
                  teamHeading,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
            Column(
              children: teamMembersList.map((teamMember) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          teamMember.memberName,
                          style: Theme.of(context).textTheme.headline,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "(${teamMember.memberDesignation})",
                          style: Theme.of(context).textTheme.subhead,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
