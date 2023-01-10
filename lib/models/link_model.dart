List<LinkModel> linkFromJson(dynamic str) =>
    List<LinkModel>.from((str).map((x) => LinkModel.fromJson(x)));

class LinkModel {
  late String? linkId;
  late String? linkTitle;
  late String? linkUrl;

  LinkModel({
    this.linkId,
    this.linkTitle,
    this.linkUrl
  });

  LinkModel.fromJson(Map<String, dynamic> json) {
    linkId = json["_id"];
    linkTitle = json["link_title"];
    linkUrl = json["link_url"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data["_id"] = linkId;
    data["link_title"] = linkTitle;
    data["link_url"] = linkUrl;

    return data;
  }
}