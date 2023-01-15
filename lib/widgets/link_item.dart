import 'package:flutter/material.dart';
import 'package:trainee_links_apk/models/link_model.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkItemWidget extends StatelessWidget {
  const LinkItemWidget({Key? key, this.model, this.onDelete}) : super(key: key);

  final LinkModel? model;
  final Function? onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(50)),
        child: linkWidget(context),
      ),
    );
  }

  Widget linkWidget(context) {
    return ListTile(
      title: Text(
        "Title: ${model!.linkTitle}",
        style: const TextStyle(color: Colors.black),
      ),
      subtitle: InkWell(
        child: Text(
          "${model!.linkUrl}",
          style: const TextStyle(
              color: Colors.blue, decoration: TextDecoration.underline),
        ),
        onTap: () => launchUrl(Uri.parse(model!.linkUrl.toString())),
      ),
      trailing: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              child: const Icon(Icons.edit_outlined),
              onTap: () {
                Navigator.of(context).pushNamed(
                  '/edit-link',
                  arguments: {'model': model},
                );
              },
            ),
            GestureDetector(
              child:
                  const Icon(Icons.delete_outline_outlined, color: Colors.red),
              onTap: () {
                onDelete!(model);
              },
            )
          ]),
    );
  }
}
