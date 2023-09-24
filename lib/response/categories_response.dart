// To parse this JSON data, do
//
//     final categoriesResponse = categoriesResponseFromJson(jsonString);

import 'dart:convert';

List<CategoriesResponse> categoriesResponseFromJson(String str) => List<CategoriesResponse>.from(json.decode(str).map((x) => CategoriesResponse.fromJson(x)));

String categoriesResponseToJson(List<CategoriesResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoriesResponse {
    CategoriesResponse({
    required this.id,
     this.count,
     this.description,
     this.link,
    required this.name,
    required this.slug,
     this.taxonomy,
     this.parent,
     this.meta,
     this.links,
     this.subcategories,
  });

  int id;
  int? count;
  String? description;
  String? link;
  String name;
  String slug;
  Taxonomy? taxonomy;
  int? parent;
  List<dynamic>? meta;
  List<dynamic>? subcategories;
  Links? links;

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) => CategoriesResponse(
    id: json["id"],
    count: json["count"],
    description: json["description"],
    link: json["link"],
    name: json["name"],
    slug: json["slug"],
    taxonomy: taxonomyValues.map[json["taxonomy"]]!,
    parent: json["parent"],
    meta: List<dynamic>.from(json["meta"].map((x) => x)),
    links: Links.fromJson(json["_links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "count": count,
    "description": description,
    "link": link,
    "name": name,
    "slug": slug,
    "taxonomy": taxonomyValues.reverse[taxonomy],
    "parent": parent,
    "meta": List<dynamic>.from(meta!.map((x) => x)),
    "_links": links!.toJson(),
  };
}

class Links {
  Links({
    required this.self,
    required this.collection,
    required this.about,
    this.up,
    required this.wpPostType,
    required this.curies,
  });

  List<About> self;
  List<About> collection;
  List<About> about;
  List<Up>? up;
  List<About> wpPostType;
  List<Cury> curies;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: List<About>.from(json["self"].map((x) => About.fromJson(x))),
    collection: List<About>.from(json["collection"].map((x) => About.fromJson(x))),
    about: List<About>.from(json["about"].map((x) => About.fromJson(x))),
    up: json["up"] == null ? [] : List<Up>.from(json["up"]!.map((x) => Up.fromJson(x))),
    wpPostType: List<About>.from(json["wp:post_type"].map((x) => About.fromJson(x))),
    curies: List<Cury>.from(json["curies"].map((x) => Cury.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "self": List<dynamic>.from(self.map((x) => x.toJson())),
    "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
    "about": List<dynamic>.from(about.map((x) => x.toJson())),
    "up": up == null ? [] : List<dynamic>.from(up!.map((x) => x.toJson())),
    "wp:post_type": List<dynamic>.from(wpPostType.map((x) => x.toJson())),
    "curies": List<dynamic>.from(curies.map((x) => x.toJson())),
  };
}

class About {
  About({
    required this.href,
  });

  String href;

  factory About.fromJson(Map<String, dynamic> json) => About(
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
  };
}

class Cury {
  Cury({
    required this.name,
    required this.href,
    required this.templated,
  });

  Name name;
  Href href;
  bool templated;

  factory Cury.fromJson(Map<String, dynamic> json) => Cury(
    name: nameValues.map[json["name"]]!,
    href: hrefValues.map[json["href"]]!,
    templated: json["templated"],
  );

  Map<String, dynamic> toJson() => {
    "name": nameValues.reverse[name],
    "href": hrefValues.reverse[href],
    "templated": templated,
  };
}

enum Href { HTTPS_API_W_ORG_REL }

final hrefValues = EnumValues({
  "https://api.w.org/{rel}": Href.HTTPS_API_W_ORG_REL
});

enum Name { WP }

final nameValues = EnumValues({
  "wp": Name.WP
});

class Up {
  Up({
    required this.embeddable,
    required this.href,
  });

  bool embeddable;
  String href;

  factory Up.fromJson(Map<String, dynamic> json) => Up(
    embeddable: json["embeddable"],
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "embeddable": embeddable,
    "href": href,
  };
}

enum Taxonomy { CATEGORY }

final taxonomyValues = EnumValues({
  "category": Taxonomy.CATEGORY
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}



class Category {
  final int id;
  final String name;
  final String slug;
  final List<Subcategory> subcategories;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.subcategories,
  });
}

class Subcategory {
  final int id;
  final String name;
  final String slug;

  Subcategory({
    required this.id,
    required this.name,
    required this.slug,
  });
}
