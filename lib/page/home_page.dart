import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:trainee_links_apk/models/link_model.dart';
import 'package:trainee_links_apk/widgets/link_item.dart';
import 'package:trainee_links_apk/api_sevice.dart';

import '../widgets/search_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<LinkModel> links = List<LinkModel>.empty(growable: true);
  bool isAPICallProcess = false;
  @override
  void initState() {
    super.initState();

    /*links.add(
      LinkModel(
          linkId: "1",
          linkTitle: "Titlo1",
          linkUrl: "https://www.youtube.com/watch?v=Euq_-_Xmi9U&t=1699s"),
    );
    links.add(
      LinkModel(
          linkId: "2",
          linkTitle: "Titlo2",
          linkUrl:
              "https://stackoverflow.com/questions/54548853/placing-two-trailing-icons-in-listtile"),
    );
    links.add(
      LinkModel(
          linkId: "2",
          linkTitle: "Titlo2",
          linkUrl: "kajflasjfçasldfjadlsçfçashfçaskhgçashgçash"),
    );
    links.add(
      LinkModel(
          linkId: "2",
          linkTitle: "Titlo2",
          linkUrl: "kajflasjfçasldfjadlsçfçashfçaskhgçashgçash"),
    );
    links.add(
      LinkModel(
          linkId: "2",
          linkTitle: "Titlo2",
          linkUrl: "kajflasjfçasldfjadlsgçash"),
    );
    links.add(
      LinkModel(
          linkId: "2",
          linkTitle: "Titlo2",
          linkUrl: "kajflasjfçasldfjadkhgçashgçash"),
    );
    links.add(
      LinkModel(
          linkId: "2",
          linkTitle: "Titlo2",
          linkUrl: "kajflasjfçasldfjadlsçfçashfçaskhgçashgçash"),
    );
    links.add(
      LinkModel(
          linkId: "2",
          linkTitle: "Titlo2",
          linkUrl: "kajflasjfçasldfjadlsçfçashfçaskhgçashgçash"),
    );*/
  }

  Widget linksList(links) {
    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: links.length,
              itemBuilder: ((context, index) {
                return LinkItemWidget(
                  model: links[index],
                  onDelete: (LinkModel model) {
                    setState(() {
                      isAPICallProcess = true;
                    });
                    APIService.deleteLinks(model.linkId).then((response) {
                      setState(() {
                        isAPICallProcess = false;
                      });
                    });
                  },
                );
              }),
            )
          ],
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Trainee Links '),
          elevation: 0,
        ),
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "What link are you looking?",
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: SearchBar(),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ProgressHUD(
                  inAsyncCall: isAPICallProcess,
                  opacity: .3,
                  key: UniqueKey(),
                  child: loadLinks(),
                ),
              ),
            ),
          ],
        ),
        extendBody: true,
        bottomNavigationBar: CircleNavBar(
          activeIcons: const [
            Icon(Icons.add_outlined, color: Colors.white),
          ],
          inactiveIcons: const [
            Text("Add"),
          ],
          color: const Color.fromARGB(255, 59, 155, 234),
          height: 60,
          circleWidth: 60,
          activeIndex: 0,
          onTap: (index) {
            Navigator.pushNamed(context, "/add-link");
          },
        ));
  }

  Widget loadLinks() {
    return FutureBuilder(
      future: APIService.getLinks(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<LinkModel>?> model,
      ) {
        if (model.hasData) {
          return linksList(model.data);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
