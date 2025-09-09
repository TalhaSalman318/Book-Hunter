class AuthorModel {
  String? name;
  Bio? bio;
  RemoteIds? remoteIds;
  List<int>? photos;
  List<String>? alternateNames;
  List<Links>? links;
  List<String>? sourceRecords;
  String? entityType;
  String? birthDate;
  String? fullerName;
  String? title;
  Type1? type;
  String? personalName;
  String? key;
  int? latestRevision;
  int? revision;
  Created? created;
  LastModified? lastModified;

  AuthorModel({
    this.name,
    this.bio,
    this.remoteIds,
    this.photos,
    this.alternateNames,
    this.links,
    this.sourceRecords,
    this.entityType,
    this.birthDate,
    this.fullerName,
    this.title,
    this.type,
    this.personalName,
    this.key,
    this.latestRevision,
    this.revision,
    this.created,
    this.lastModified,
  });

  AuthorModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    bio = json["bio"] == null ? null : Bio.fromJson(json["bio"]);
    remoteIds = json["remote_ids"] == null
        ? null
        : RemoteIds.fromJson(json["remote_ids"]);
    photos = json["photos"] == null ? null : List<int>.from(json["photos"]);
    alternateNames = json["alternate_names"] == null
        ? null
        : List<String>.from(json["alternate_names"]);
    links = json["links"] == null
        ? null
        : (json["links"] as List).map((e) => Links.fromJson(e)).toList();
    sourceRecords = json["source_records"] == null
        ? null
        : List<String>.from(json["source_records"]);
    entityType = json["entity_type"];
    birthDate = json["birth_date"];
    fullerName = json["fuller_name"];
    title = json["title"];
    type = json["type"] == null ? null : Type1.fromJson(json["type"]);
    personalName = json["personal_name"];
    key = json["key"];
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
    _data["name"] = name;
    if (bio != null) {
      _data["bio"] = bio?.toJson();
    }
    if (remoteIds != null) {
      _data["remote_ids"] = remoteIds?.toJson();
    }
    if (photos != null) {
      _data["photos"] = photos;
    }
    if (alternateNames != null) {
      _data["alternate_names"] = alternateNames;
    }
    if (links != null) {
      _data["links"] = links?.map((e) => e.toJson()).toList();
    }
    if (sourceRecords != null) {
      _data["source_records"] = sourceRecords;
    }
    _data["entity_type"] = entityType;
    _data["birth_date"] = birthDate;
    _data["fuller_name"] = fullerName;
    _data["title"] = title;
    if (type != null) {
      _data["type"] = type?.toJson();
    }
    _data["personal_name"] = personalName;
    _data["key"] = key;
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

class Links {
  String? title;
  String? url;
  Type? type;

  Links({this.title, this.url, this.type});

  Links.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    url = json["url"];
    type = json["type"] == null ? null : Type.fromJson(json["type"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["title"] = title;
    _data["url"] = url;
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

class RemoteIds {
  String? viaf;
  String? goodreads;
  String? storygraph;
  String? isni;
  String? librarything;
  String? amazon;
  String? wikidata;
  String? imdb;
  String? musicbrainz;
  String? lcNaf;
  String? opacSbn;

  RemoteIds({
    this.viaf,
    this.goodreads,
    this.storygraph,
    this.isni,
    this.librarything,
    this.amazon,
    this.wikidata,
    this.imdb,
    this.musicbrainz,
    this.lcNaf,
    this.opacSbn,
  });

  RemoteIds.fromJson(Map<String, dynamic> json) {
    viaf = json["viaf"];
    goodreads = json["goodreads"];
    storygraph = json["storygraph"];
    isni = json["isni"];
    librarything = json["librarything"];
    amazon = json["amazon"];
    wikidata = json["wikidata"];
    imdb = json["imdb"];
    musicbrainz = json["musicbrainz"];
    lcNaf = json["lc_naf"];
    opacSbn = json["opac_sbn"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["viaf"] = viaf;
    _data["goodreads"] = goodreads;
    _data["storygraph"] = storygraph;
    _data["isni"] = isni;
    _data["librarything"] = librarything;
    _data["amazon"] = amazon;
    _data["wikidata"] = wikidata;
    _data["imdb"] = imdb;
    _data["musicbrainz"] = musicbrainz;
    _data["lc_naf"] = lcNaf;
    _data["opac_sbn"] = opacSbn;
    return _data;
  }
}

class Bio {
  String? type;
  String? value;

  Bio({this.type, this.value});

  Bio.fromJson(Map<String, dynamic> json) {
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
