import 'package:cv_projects_task/constants.dart';
import 'package:flutter/material.dart';

class CVErrorWidget extends StatelessWidget {
  final String errorMessage;

  const CVErrorWidget({Key key, this.errorMessage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            errorMessage ?? Constants.GENERIC_FAILURE,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
