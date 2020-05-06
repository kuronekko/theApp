class AnimeResponseGraphqlModel {
  DataGraphqlModel data;

  AnimeResponseGraphqlModel({this.data});

  AnimeResponseGraphqlModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DataGraphqlModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class DataGraphqlModel {
  PageGraphqlModel page;

  DataGraphqlModel({this.page});

  DataGraphqlModel.fromJson(Map<String, dynamic> json) {
    page = json['Page'] != null ? new PageGraphqlModel.fromJson(json['Page']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.page != null) {
      data['Page'] = this.page.toJson();
    }
    return data;
  }
}

class PageGraphqlModel {
  PageInfoGraphqlModel pageInfo;
  List<AnimeGraphqlModel> media;

  PageGraphqlModel({this.pageInfo, this.media});

  PageGraphqlModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['pageInfo'] != null
        ? new PageInfoGraphqlModel.fromJson(json['pageInfo'])
        : null;
    if (json['media'] != null) {
      media = new List<AnimeGraphqlModel>();
      json['media'].forEach((v) {
        media.add(new AnimeGraphqlModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pageInfo != null) {
      data['pageInfo'] = this.pageInfo.toJson();
    }
    if (this.media != null) {
      data['media'] = this.media.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PageInfoGraphqlModel {
  int total;
  int currentPage;
  int lastPage;
  bool hasNextPage;
  int perPage;

  PageInfoGraphqlModel(
      {this.total,
        this.currentPage,
        this.lastPage,
        this.hasNextPage,
        this.perPage});

  PageInfoGraphqlModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    currentPage = json['currentPage'];
    lastPage = json['lastPage'];
    hasNextPage = json['hasNextPage'];
    perPage = json['perPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['currentPage'] = this.currentPage;
    data['lastPage'] = this.lastPage;
    data['hasNextPage'] = this.hasNextPage;
    data['perPage'] = this.perPage;
    return data;
  }
}

class AnimeGraphqlModel {
  int id;
  TitleGraphqlModel title;
  String description;
  String type;
  int episodes;
  List<String> genres;
  String format;
  String bannerImage;

  AnimeGraphqlModel(
      {this.id,
        this.title,
        this.description,
        this.type,
        this.episodes,
        this.genres,
        this.format,
        this.bannerImage});

  AnimeGraphqlModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] != null ? new TitleGraphqlModel.fromJson(json['title']) : null;
    description = json['description'];
    type = json['type'];
    episodes = json['episodes'];
    genres = json['genres'].cast<String>();
    format = json['format'];
    bannerImage = json['bannerImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.title != null) {
      data['title'] = this.title.toJson();
    }
    data['description'] = this.description;
    data['type'] = this.type;
    data['episodes'] = this.episodes;
    data['genres'] = this.genres;
    data['format'] = this.format;
    data['bannerImage'] = this.bannerImage;
    return data;
  }
}

class TitleGraphqlModel {
  String romaji;
  String english;
  String native;

  TitleGraphqlModel({this.romaji, this.english, this.native});

  TitleGraphqlModel.fromJson(Map<String, dynamic> json) {
    romaji = json['romaji'];
    english = json['english'];
    native = json['native'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['romaji'] = this.romaji;
    data['english'] = this.english;
    data['native'] = this.native;
    return data;
  }
}