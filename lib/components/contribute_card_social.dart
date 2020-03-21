import 'package:cv_projects_task/globals.dart';
import 'package:flutter/material.dart';

class ContributeCardSocial extends StatelessWidget {
  final String imagePath;
  final String cardHead;
  final String cardDescription;
  final String url;

  const ContributeCardSocial({
    Key key,
    this.imagePath,
    this.cardHead,
    this.cardDescription,
    this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await launchURL(url);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    imagePath,
                    scale: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        cardHead,
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        cardDescription,
                        style: Theme.of(context).textTheme.subhead,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
