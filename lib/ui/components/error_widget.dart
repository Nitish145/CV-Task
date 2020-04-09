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
            errorMessage ?? "Something Went Wrong! Please try again later",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
