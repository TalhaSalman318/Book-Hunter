class EditionModel {
  Links? links;
  int? size;
  List<Entries>? entries;

  EditionModel(
    List<Map<String, dynamic>> response, {
    this.links,
    this.size,
    this.entries,
  });

  EditionModel.fromJson(Map<String, dynamic> json) {
    links = json["links"] == null ? null : Links.fromJson(json["links"]);
    size = json["size"];
    entries = json["entries"] == null
        ? null
        : (json["entries"] as List).map((e) => Entries.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (links != null) {
      _data["links"] = links?.toJson();
    }
    _data["size"] = size;
    if (entries != null) {
      _data["entries"] = entries?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Entries {
  Type? type;
  List<Authors>? authors;
  List<String>? isbn13;
  List<Languages>? languages;
  String? pagination;
  String? publishDate;
  List<String>? publishers;
  List<String>? sourceRecords;
  List<String>? subjects;
  String? title;
  String? weight;
  String? fullTitle;
  List<Works>? works;
  String? key;
  List<int>? covers;
  int? numberOfPages;
  int? latestRevision;
  int? revision;
  Created? created;
  LastModified? lastModified;

  Entries({
    this.type,
    this.authors,
    this.isbn13,
    this.languages,
    this.pagination,
    this.publishDate,
    this.publishers,
    this.sourceRecords,
    this.subjects,
    this.title,
    this.weight,
    this.fullTitle,
    this.works,
    this.key,
    this.covers,
    this.numberOfPages,
    this.latestRevision,
    this.revision,
    this.created,
    this.lastModified,
  });

  Entries.fromJson(Map<String, dynamic> json) {
    type = json["type"] == null ? null : Type.fromJson(json["type"]);
    authors = json["authors"] == null
        ? null
        : (json["authors"] as List).map((e) => Authors.fromJson(e)).toList();
    isbn13 = json["isbn_13"] == null
        ? null
        : List<String>.from(json["isbn_13"]);
    languages = json["languages"] == null
        ? null
        : (json["languages"] as List)
              .map((e) => Languages.fromJson(e))
              .toList();
    pagination = json["pagination"];
    publishDate = json["publish_date"];
    publishers = json["publishers"] == null
        ? null
        : List<String>.from(json["publishers"]);
    sourceRecords = json["source_records"] == null
        ? null
        : List<String>.from(json["source_records"]);
    subjects = json["subjects"] == null
        ? null
        : List<String>.from(json["subjects"]);
    title = json["title"];
    weight = json["weight"];
    fullTitle = json["full_title"];
    works = json["works"] == null
        ? null
        : (json["works"] as List).map((e) => Works.fromJson(e)).toList();
    key = json["key"];
    covers = json["covers"] == null ? null : List<int>.from(json["covers"]);
    numberOfPages = json["number_of_pages"];
    latestRevision = json["latest_revision"];
    revision = json["revision"];
    created = json["created"] == null
        ? null
        : Created.fromJson(json["created"]);
    lastModified = json["last_modified"] == null
        ? null
        : LastModified.fromJson(json["last_modified"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (type != null) {
      _data["type"] = type?.toJson();
    }
    if (authors != null) {
      _data["authors"] = authors?.map((e) => e.toJson()).toList();
    }
    if (isbn13 != null) {
      _data["isbn_13"] = isbn13;
    }
    if (languages != null) {
      _data["languages"] = languages?.map((e) => e.toJson()).toList();
    }
    _data["pagination"] = pagination;
    _data["publish_date"] = publishDate;
    if (publishers != null) {
      _data["publishers"] = publishers;
    }
    if (sourceRecords != null) {
      _data["source_records"] = sourceRecords;
    }
    if (subjects != null) {
      _data["subjects"] = subjects;
    }
    _data["title"] = title;
    _data["weight"] = weight;
    _data["full_title"] = fullTitle;
    if (works != null) {
      _data["works"] = works?.map((e) => e.toJson()).toList();
    }
    _data["key"] = key;
    if (covers != null) {
      _data["covers"] = covers;
    }
    _data["number_of_pages"] = numberOfPages;
    _data["latest_revision"] = latestRevision;
    _data["revision"] = revision;
    if (created != null) {
      _data["created"] = created?.toJson();
    }
    if (lastModified != null) {
      _data["last_modified"] = lastModified?.toJson();
    }
    return _data;
  }
}

class LastModified {
  String? type;
  String? value;

  LastModified({this.type, this.value});

  LastModified.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    value = json["value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["type"] = type;
    _data["value"] = value;
    return _data;
  }
}

class Created {
  String? type;
  String? value;

  Created({this.type, this.value});

  Created.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    value = json["value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["type"] = type;
    _data["value"] = value;
    return _data;
  }
}

class Works {
  String? key;

  Works({this.key});

  Works.fromJson(Map<String, dynamic> json) {
    key = json["key"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["key"] = key;
    return _data;
  }
}

class Languages {
  String? key;

  Languages({this.key});

  Languages.fromJson(Map<String, dynamic> json) {
    key = json["key"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["key"] = key;
    return _data;
  }
}

class Authors {
  String? key;

  Authors({this.key});

  Authors.fromJson(Map<String, dynamic> json) {
    key = json["key"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["key"] = key;
    return _data;
  }
}

class Type {
  String? key;

  Type({this.key});

  Type.fromJson(Map<String, dynamic> json) {
    key = json["key"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["key"] = key;
    return _data;
  }
}

class Links {
  String? self;
  String? work;
  String? next;

  Links({this.self, this.work, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    self = json["self"];
    work = json["work"];
    next = json["next"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["self"] = self;
    _data["work"] = work;
    _data["next"] = next;
    return _data;
  }
}
