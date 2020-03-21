import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContributeCardDonate extends StatelessWidget {
  final String logoPath;
  final String header;
  final String url;

  const ContributeCardDonate({
    Key key,
    this.logoPath,
    this.header,
    this.url,
  }) : super(key: key);

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 8),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              header,
              style: Theme.of(context).textTheme.headline,
            ),
          ),
          GestureDetector(
            onTap: () async {
              await _launchURL(url);
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0,
                      offset:
                          Offset(2.0, 2.0), // shadow direction: bottom right
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  child: Image.asset(
                    logoPath,
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
