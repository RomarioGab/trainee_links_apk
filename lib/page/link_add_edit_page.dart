import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:trainee_links_apk/models/link_model.dart';

class LinkAddEditPage extends StatefulWidget {
  const LinkAddEditPage({super.key});

  @override
  State<LinkAddEditPage> createState() => _LinkAddEditPageState();
}

class _LinkAddEditPageState extends State<LinkAddEditPage> {
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isAPICallProcess = false;
  LinkModel? linkModel;
  bool isEditMode = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Trainee Link"),
          elevation: 0,
        ),
        backgroundColor: Colors.grey[200],
        body: ProgressHUD(
          inAsyncCall: isAPICallProcess,
          opacity: .3,
          key: UniqueKey(),
          child: Form(
            key: globalKey,
            child: linkForm(),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    linkModel = LinkModel();

    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;

        linkModel = arguments["model"];
        isEditMode = true;
        setState(() {});
      }
    });
  }

  Widget linkForm() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: FormHelper.inputFieldWidget(
              context,
              "linkTitle",
              "Link title",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Link tile can`t be empty!';
                }

                return null;
              },
              (onSavedVal) {
                linkModel!.linkTitle = onSavedVal;
              },
              initialValue: linkModel!.linkTitle == null
                  ? ""
                  : linkModel!.linkTitle.toString(),
              borderColor: Colors.black,
              borderFocusColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(.7),
              borderRadius: 10,
              showPrefixIcon: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: FormHelper.inputFieldWidget(
              context,
              "linkUrl",
              "Link URL",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Link url can`t be empty!';
                }

                return null;
              },
              (onSavedVal) {
                linkModel!.linkUrl = onSavedVal;
              },
              initialValue: linkModel!.linkUrl == null
                  ? ""
                  : linkModel!.linkUrl.toString(),
              borderColor: Colors.black,
              borderFocusColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(.7),
              borderRadius: 10,
              showPrefixIcon: false,
              suffixIcon: const Icon(Icons.add_link_outlined),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: FormHelper.submitButton(
              "Save Link",
              () {
                if (validateAndSave()) {
                  //API Service
                }
              },
              btnColor: const Color.fromARGB(255, 59, 155, 234),
              borderColor: Colors.white,
              borderRadius: 10,
            ),
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
