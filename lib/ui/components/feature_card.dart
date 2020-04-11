import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final String assetPath;
  final String cardHeading;
  final String cardDescription;

  const FeatureCard({
    Key key,
    this.assetPath,
    this.cardDescription,
    this.cardHeading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Column(
          children: <Widget>[
            Image.asset(
              assetPath,
              width: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                cardHeading,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
