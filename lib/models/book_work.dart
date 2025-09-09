class BookWorkModel {
  String? title;
  String? key;
  List<Authors>? authors;
  Type1? type;
  String? description;
  List<int>? covers;
  List<String>? subjectPlaces;
  List<String>? subjects;
  List<String>? subjectPeople;
  List<String>? subjectTimes;
  String? location;
  int? latestRevision;
  int? revision;
  Created? created;
  LastModified? lastModified;

  BookWorkModel({
    this.title,
    this.key,
    this.authors,
    this.type,
    this.description,
    this.covers,
    this.subjectPlaces,
    this.subjects,
    this.subjectPeople,
    this.subjectTimes,
    this.location,
    this.latestRevision,
    this.revision,
    this.created,
    this.lastModified,
  });

  BookWorkModel.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    key = json["key"];
    authors = json["authors"] == null
        ? null
        : (json["authors"] as List).map((e) => Authors.fromJson(e)).toList();
    type = json["type"] == null ? null : Type1.fromJson(json["type"]);
    description = json["description"];
    covers = json["covers"] == null ? null : List<int>.from(json["covers"]);
    subjectPlaces = json["subject_places"] == null
        ? null
        : List<String>.from(json["subject_places"]);
    subjects = json["subjects"] == null
        ? null
        : List<String>.from(json["subjects"]);
    subjectPeople = json["subject_people"] == null
        ? null
        : List<String>.from(json["subject_people"]);
    subjectTimes = json["subject_times"] == null
        ? null
        : List<String>.from(json["subject_times"]);
    location = json["location"];
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
    _data["title"] = title;
    _data["key"] = key;
    if (authors != null) {
      _data["authors"] = authors?.map((e) => e.toJson()).toList();
    }
    if (type != null) {
      _data["type"] = type?.toJson();
    }
    _data["description"] = description;
    if (covers != null) {
      _data["covers"] = covers;
    }
    if (subjectPlaces != null) {
      _data["subject_places"] = subjectPlaces;
    }
    if (subjects != null) {
      _data["subjects"] = subjects;
    }
    if (subjectPeople != null) {
      _data["subject_people"] = subjectPeople;
    }
    if (subjectTimes != null) {
      _data["subject_times"] = subjectTimes;
    }
    _data["location"] = location;
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

class Type1 {
  String? key;

  Type1({this.key});

  Type1.fromJson(Map<String, dynamic> json) {
    key = json["key"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["key"] = key;
    return _data;
  }
}

class Authors {
  Author? author;
  Type? type;

  Authors({this.author, this.type});

  Authors.fromJson(Map<String, dynamic> json) {
    author = json["author"] == null ? null : Author.fromJson(json["author"]);
    type = json["type"] == null ? null : Type.fromJson(json["type"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (author != null) {
      _data["author"] = author?.toJson();
    }
    if (type != null) {
      _data["type"] = type?.toJson();
    }
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

class Author {
  String? key;

  Author({this.key});

  Author.fromJson(Map<String, dynamic> json) {
    key = json["key"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["key"] = key;
    return _data;
  }
}
