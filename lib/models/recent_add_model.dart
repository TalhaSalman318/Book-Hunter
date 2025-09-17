class RecentAddModel {
  String? id;
  String? kind;
  String? timestamp;
  String? comment;
  List<Changes>? changes;
  Author? author;
  String? ip;
  Data? data;

  RecentAddModel({
    this.id,
    this.kind,
    this.timestamp,
    this.comment,
    this.changes,
    this.author,
    this.ip,
    this.data,
  });

  RecentAddModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kind = json['kind'];
    timestamp = json['timestamp'];
    comment = json['comment'];
    if (json['changes'] != null) {
      changes = [];
      json['changes'].forEach((v) {
        changes!.add(Changes.fromJson(v));
      });
    }
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    ip = json['ip'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['id'] = id;
    result['kind'] = kind;
    result['timestamp'] = timestamp;
    result['comment'] = comment;
    if (changes != null) {
      result['changes'] = changes!.map((v) => v.toJson()).toList();
    }
    if (author != null) {
      result['author'] = author!.toJson();
    }
    result['ip'] = ip;
    if (data != null) {
      result['data'] = data!.toJson();
    }
    return result;
  }
}

class Changes {
  String? key;
  int? revision;

  Changes({this.key, this.revision});

  Changes.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    revision = json['revision'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['key'] = key;
    result['revision'] = revision;
    return result;
  }
}

class Author {
  String? key;

  Author({this.key});

  Author.fromJson(Map<String, dynamic> json) {
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['key'] = key;
    return result;
  }
}

class Data {
  Data();

  Data.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    return result;
  }
}
