import 'package:flutter/material.dart';

class TeachersCard extends StatelessWidget {
  final String assetPath;
  final String cardHeading;
  final String cardDescription;
  final bool isOdd;

  const TeachersCard({
    Key key,
    this.assetPath,
    this.cardDescription,
    this.cardHeading,
    this.isOdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        color: isOdd ? Color.fromRGBO(245, 255, 252, 1) : Colors.white,
        elevation: 5,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                assetPath,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                cardHeading,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                cardDescription,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
