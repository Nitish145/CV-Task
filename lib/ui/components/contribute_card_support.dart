import 'package:flutter/material.dart';

class ContributeCardSupport extends StatelessWidget {
  final String imagePath;
  final String cardHead;
  final List<String> cardDescriptionList;

  const ContributeCardSupport({
    Key key,
    this.imagePath,
    this.cardHead,
    this.cardDescriptionList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
                child: Text(
                  cardHead,
                  style: Theme.of(context)
                      .textTheme
                      .headline
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  cardDescriptionList
                      .map((x) => "\u2022 $x\n")
                      .reduce((x, y) => "$x$y"),
                  style: Theme.of(context).textTheme.subhead,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
