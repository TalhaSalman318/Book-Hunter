class SubjectModel {
  String? key;
  String? name;
  String? subjectType;
  String? solrQuery;
  int? workCount;
  List<Works>? works;
  int? ebookCount;
  List<Subjects>? subjects;
  List<Places>? places;
  List<People>? people;
  List<Times>? times;
  List<Authors1>? authors;
  List<Publishers>? publishers;
  List<Languages>? languages;
  List<List<int>>? publishingHistory;

  SubjectModel({
    this.key,
    this.name,
    this.subjectType,
    this.solrQuery,
    this.workCount,
    this.works,
    this.ebookCount,
    this.subjects,
    this.places,
    this.people,
    this.times,
    this.authors,
    this.publishers,
    this.languages,
    this.publishingHistory,
  });

  SubjectModel.fromJson(Map<String, dynamic> json) {
    key = json["key"];
    name = json["name"];
    subjectType = json["subject_type"];
    solrQuery = json["solr_query"];
    workCount = json["work_count"];
    works = json["works"] == null
        ? null
        : (json["works"] as List).map((e) => Works.fromJson(e)).toList();
    ebookCount = json["ebook_count"];
    subjects = json["subjects"] == null
        ? null
        : (json["subjects"] as List).map((e) => Subjects.fromJson(e)).toList();
    places = json["places"] == null
        ? null
        : (json["places"] as List).map((e) => Places.fromJson(e)).toList();
    people = json["people"] == null
        ? null
        : (json["people"] as List).map((e) => People.fromJson(e)).toList();
    times = json["times"] == null
        ? null
        : (json["times"] as List).map((e) => Times.fromJson(e)).toList();
    authors = json["authors"] == null
        ? null
        : (json["authors"] as List).map((e) => Authors1.fromJson(e)).toList();
    publishers = json["publishers"] == null
        ? null
        : (json["publishers"] as List)
              .map((e) => Publishers.fromJson(e))
              .toList();
    languages = json["languages"] == null
        ? null
        : (json["languages"] as List)
              .map((e) => Languages.fromJson(e))
              .toList();
    publishingHistory = json["publishing_history"] == null
        ? null
        : List<List<int>>.from(json["publishing_history"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["key"] = key;
    _data["name"] = name;
    _data["subject_type"] = subjectType;
    _data["solr_query"] = solrQuery;
    _data["work_count"] = workCount;
    if (works != null) {
      _data["works"] = works?.map((e) => e.toJson()).toList();
    }
    _data["ebook_count"] = ebookCount;
    if (subjects != null) {
      _data["subjects"] = subjects?.map((e) => e.toJson()).toList();
    }
    if (places != null) {
      _data["places"] = places?.map((e) => e.toJson()).toList();
    }
    if (people != null) {
      _data["people"] = people?.map((e) => e.toJson()).toList();
    }
    if (times != null) {
      _data["times"] = times?.map((e) => e.toJson()).toList();
    }
    if (authors != null) {
      _data["authors"] = authors?.map((e) => e.toJson()).toList();
    }
    if (publishers != null) {
      _data["publishers"] = publishers?.map((e) => e.toJson()).toList();
    }
    if (languages != null) {
      _data["languages"] = languages?.map((e) => e.toJson()).toList();
    }
    if (publishingHistory != null) {
      _data["publishing_history"] = publishingHistory;
    }
    return _data;
  }
}

class Languages {
  String? name;
  int? count;

  Languages({this.name, this.count});

  Languages.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    count = json["count"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    _data["count"] = count;
    return _data;
  }
}

class Publishers {
  String? name;
  int? count;
  String? key;

  Publishers({this.name, this.count, this.key});

  Publishers.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    count = json["count"];
    key = json["key"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    _data["count"] = count;
    _data["key"] = key;
    return _data;
  }
}

class Authors1 {
  String? name;
  String? key;
  int? count;

  Authors1({this.name, this.key, this.count});

  Authors1.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    key = json["key"];
    count = json["count"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    _data["key"] = key;
    _data["count"] = count;
    return _data;
  }
}

class Times {
  String? key;
  String? name;
  int? count;

  Times({this.key, this.name, this.count});

  Times.fromJson(Map<String, dynamic> json) {
    key = json["key"];
    name = json["name"];
    count = json["count"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["key"] = key;
    _data["name"] = name;
    _data["count"] = count;
    return _data;
  }
}

class People {
  String? key;
  String? name;
  int? count;

  People({this.key, this.name, this.count});

  People.fromJson(Map<String, dynamic> json) {
    key = json["key"];
    name = json["name"];
    count = json["count"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["key"] = key;
    _data["name"] = name;
    _data["count"] = count;
    return _data;
  }
}

class Places {
  String? key;
  String? name;
  int? count;

  Places({this.key, this.name, this.count});

  Places.fromJson(Map<String, dynamic> json) {
    key = json["key"];
    name = json["name"];
    count = json["count"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["key"] = key;
    _data["name"] = name;
    _data["count"] = count;
    return _data;
  }
}

class Subjects {
  String? key;
  String? name;
  int? count;

  Subjects({this.key, this.name, this.count});

  Subjects.fromJson(Map<String, dynamic> json) {
    key = json["key"];
    name = json["name"];
    count = json["count"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["key"] = key;
    _data["name"] = name;
    _data["count"] = count;
    return _data;
  }
}

class Works {
  String? key;
  String? title;
  int? editionCount;
  int? coverId;
  String? coverEditionKey;
  List<String>? subject;
  List<String>? iaCollection;
  bool? printdisabled;
  String? lendingEdition;
  String? lendingIdentifier;
  List<Authors>? authors;
  int? firstPublishYear;
  String? ia;
  bool? publicScan;
  bool? hasFulltext;
  Availability? availability;

  Works({
    this.key,
    this.title,
    this.editionCount,
    this.coverId,
    this.coverEditionKey,
    this.subject,
    this.iaCollection,
    this.printdisabled,
    this.lendingEdition,
    this.lendingIdentifier,
    this.authors,
    this.firstPublishYear,
    this.ia,
    this.publicScan,
    this.hasFulltext,
    this.availability,
  });

  Works.fromJson(Map<String, dynamic> json) {
    key = json["key"];
    title = json["title"];
    editionCount = json["edition_count"];
    coverId = json["cover_id"];
    coverEditionKey = json["cover_edition_key"];
    subject = json["subject"] == null
        ? null
        : List<String>.from(json["subject"]);
    iaCollection = json["ia_collection"] == null
        ? null
        : List<String>.from(json["ia_collection"]);
    printdisabled = json["printdisabled"];
    lendingEdition = json["lending_edition"];
    lendingIdentifier = json["lending_identifier"];
    authors = json["authors"] == null
        ? null
        : (json["authors"] as List).map((e) => Authors.fromJson(e)).toList();
    firstPublishYear = json["first_publish_year"];
    ia = json["ia"];
    publicScan = json["public_scan"];
    hasFulltext = json["has_fulltext"];
    availability = json["availability"] == null
        ? null
        : Availability.fromJson(json["availability"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["key"] = key;
    _data["title"] = title;
    _data["edition_count"] = editionCount;
    _data["cover_id"] = coverId;
    _data["cover_edition_key"] = coverEditionKey;
    if (subject != null) {
      _data["subject"] = subject;
    }
    if (iaCollection != null) {
      _data["ia_collection"] = iaCollection;
    }
    _data["printdisabled"] = printdisabled;
    _data["lending_edition"] = lendingEdition;
    _data["lending_identifier"] = lendingIdentifier;
    if (authors != null) {
      _data["authors"] = authors?.map((e) => e.toJson()).toList();
    }
    _data["first_publish_year"] = firstPublishYear;
    _data["ia"] = ia;
    _data["public_scan"] = publicScan;
    _data["has_fulltext"] = hasFulltext;
    if (availability != null) {
      _data["availability"] = availability?.toJson();
    }
    return _data;
  }
}

class Availability {
  String? status;
  bool? availableToBrowse;
  bool? availableToBorrow;
  bool? availableToWaitlist;
  bool? isPrintdisabled;
  bool? isReadable;
  bool? isLendable;
  bool? isPreviewable;
  String? identifier;
  String? isbn;
  dynamic oclc;
  String? openlibraryWork;
  String? openlibraryEdition;
  dynamic lastLoanDate;
  dynamic numWaitlist;
  dynamic lastWaitlistDate;
  bool? isRestricted;
  bool? isBrowseable;
  String? src;

  Availability({
    this.status,
    this.availableToBrowse,
    this.availableToBorrow,
    this.availableToWaitlist,
    this.isPrintdisabled,
    this.isReadable,
    this.isLendable,
    this.isPreviewable,
    this.identifier,
    this.isbn,
    this.oclc,
    this.openlibraryWork,
    this.openlibraryEdition,
    this.lastLoanDate,
    this.numWaitlist,
    this.lastWaitlistDate,
    this.isRestricted,
    this.isBrowseable,
    this.src,
  });

  Availability.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    availableToBrowse = json["available_to_browse"];
    availableToBorrow = json["available_to_borrow"];
    availableToWaitlist = json["available_to_waitlist"];
    isPrintdisabled = json["is_printdisabled"];
    isReadable = json["is_readable"];
    isLendable = json["is_lendable"];
    isPreviewable = json["is_previewable"];
    identifier = json["identifier"];
    isbn = json["isbn"];
    oclc = json["oclc"];
    openlibraryWork = json["openlibrary_work"];
    openlibraryEdition = json["openlibrary_edition"];
    lastLoanDate = json["last_loan_date"];
    numWaitlist = json["num_waitlist"];
    lastWaitlistDate = json["last_waitlist_date"];
    isRestricted = json["is_restricted"];
    isBrowseable = json["is_browseable"];
    src = json["__src__"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["available_to_browse"] = availableToBrowse;
    _data["available_to_borrow"] = availableToBorrow;
    _data["available_to_waitlist"] = availableToWaitlist;
    _data["is_printdisabled"] = isPrintdisabled;
    _data["is_readable"] = isReadable;
    _data["is_lendable"] = isLendable;
    _data["is_previewable"] = isPreviewable;
    _data["identifier"] = identifier;
    _data["isbn"] = isbn;
    _data["oclc"] = oclc;
    _data["openlibrary_work"] = openlibraryWork;
    _data["openlibrary_edition"] = openlibraryEdition;
    _data["last_loan_date"] = lastLoanDate;
    _data["num_waitlist"] = numWaitlist;
    _data["last_waitlist_date"] = lastWaitlistDate;
    _data["is_restricted"] = isRestricted;
    _data["is_browseable"] = isBrowseable;
    _data["__src__"] = src;
    return _data;
  }
}

class Authors {
  String? key;
  String? name;

  Authors({this.key, this.name});

  Authors.fromJson(Map<String, dynamic> json) {
    key = json["key"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["key"] = key;
    _data["name"] = name;
    return _data;
  }
}
