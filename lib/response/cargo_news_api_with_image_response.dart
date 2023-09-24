// To parse this JSON data, do
//
//     final cargoNewWireNewsResponse = cargoNewWireNewsResponseFromJson(jsonString);

import 'dart:convert';

List<CargoNewWireNewsResponse> cargoNewWireNewsResponseFromJson(String str) => List<CargoNewWireNewsResponse>.from(json.decode(str).map((x) => CargoNewWireNewsResponse.fromJson(x)));

String cargoNewWireNewsResponseToJson(List<CargoNewWireNewsResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CargoNewWireNewsResponse {
  CargoNewWireNewsResponse({
    required this.id,
    required this.date,
    required this.dateGmt,
    required this.guid,
    required this.modified,
    required this.modifiedGmt,
    DateTime? bookmarkSavedDataDate,
    required this.slug,
    required this.status,
    required this.type,
    required this.link,
    required this.title,
    required this.content,
    required this.excerpt,
    required this.author,
    required this.featuredMedia,
    required this.commentStatus,
    required this.pingStatus,
    required this.sticky,
    required this.template,
    required this.format,
    required this.meta,
    required this.categories,
    required this.tags,
    required this.blogPostLayoutFeaturedMediaUrls,
    required this.categoriesNames,
    required this.tagsNames,
    required this.commentsNumber,
    required this.links,
    required this.embedded,
  }): bookmarkSavedDataDate = bookmarkSavedDataDate ?? DateTime.now();

  int id;
  DateTime date;
  DateTime dateGmt;
  Guid guid;
  DateTime modified;
  DateTime modifiedGmt;
  DateTime bookmarkSavedDataDate;
  String slug;
  StatusEnum status;
  CargoNewWireNewsResponseType type;
  String link;
  Guid title;
  Content content;
  Content excerpt;
  int author;
  int featuredMedia;
  Status commentStatus;
  Status pingStatus;
  bool sticky;
  String template;
  Format format;
  Meta meta;
  List<int> categories;
  List<int> tags;
  BlogPostLayoutFeaturedMediaUrls blogPostLayoutFeaturedMediaUrls;
  Map<String, SName> categoriesNames;
  dynamic tagsNames;
  String commentsNumber;
  CargoNewWireNewsResponseLinks links;
  Embedded embedded;

  factory CargoNewWireNewsResponse.fromJson(Map<String, dynamic> json) => CargoNewWireNewsResponse(
    id: json["id"],
    date: DateTime.parse(json["date"]),
    dateGmt: DateTime.parse(json["date_gmt"]),
    guid: Guid.fromJson(json["guid"]),
    modified: DateTime.parse(json["modified"]),
    modifiedGmt: DateTime.parse(json["modified_gmt"]),
    slug: json["slug"],
    status: statusEnumValues.map[json["status"]]!,
    type: cargoNewWireNewsResponseTypeValues.map[json["type"]]!,
    link: json["link"],
    title: Guid.fromJson(json["title"]),
    content: Content.fromJson(json["content"]),
    excerpt: Content.fromJson(json["excerpt"]),
    author: json["author"],
    featuredMedia: json["featured_media"],
    commentStatus: statusValues.map[json["comment_status"]]!,
    pingStatus: statusValues.map[json["ping_status"]]!,
    sticky: json["sticky"],
    template: json["template"],
    format: formatValues.map[json["format"]]!,
    meta: Meta.fromJson(json["meta"]),
    categories: List<int>.from(json["categories"].map((x) => x)),
    tags: List<int>.from(json["tags"].map((x) => x)),
    blogPostLayoutFeaturedMediaUrls: BlogPostLayoutFeaturedMediaUrls.fromJson(json["blog_post_layout_featured_media_urls"]),
    categoriesNames: Map.from(json["categories_names"]).map((k, v) => MapEntry<String, SName>(k, SName.fromJson(v))),
    tagsNames: json["tags_names"],
    commentsNumber: json["comments_number"],
    links: CargoNewWireNewsResponseLinks.fromJson(json["_links"]),
    embedded: Embedded.fromJson(json["_embedded"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date.toIso8601String(),
    "date_gmt": dateGmt.toIso8601String(),
    "guid": guid.toJson(),
    "modified": modified.toIso8601String(),
    "modified_gmt": modifiedGmt.toIso8601String(),
    "slug": slug,
    "status": statusEnumValues.reverse[status],
    "type": cargoNewWireNewsResponseTypeValues.reverse[type],
    "link": link,
    "title": title.toJson(),
    "content": content.toJson(),
    "excerpt": excerpt.toJson(),
    "author": author,
    "featured_media": featuredMedia,
    "comment_status": statusValues.reverse[commentStatus],
    "ping_status": statusValues.reverse[pingStatus],
    "sticky": sticky,
    "template": template,
    "format": formatValues.reverse[format],
    "meta": meta.toJson(),
    "categories": List<dynamic>.from(categories.map((x) => x)),
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "blog_post_layout_featured_media_urls": blogPostLayoutFeaturedMediaUrls.toJson(),
    "categories_names": Map.from(categoriesNames).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "tags_names": tagsNames,
    "comments_number": commentsNumber,
    "_links": links.toJson(),
    "_embedded": embedded.toJson(),
  };
}

class BlogPostLayoutFeaturedMediaUrls {
  BlogPostLayoutFeaturedMediaUrls({
    required this.thumbnail,
    required this.full,
  });

  List<dynamic> thumbnail;
  List<dynamic> full;

  factory BlogPostLayoutFeaturedMediaUrls.fromJson(Map<String, dynamic> json) => BlogPostLayoutFeaturedMediaUrls(
    thumbnail: List<dynamic>.from(json["thumbnail"].map((x) => x)),
    full: List<dynamic>.from(json["full"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "thumbnail": List<dynamic>.from(thumbnail.map((x) => x)),
    "full": List<dynamic>.from(full.map((x) => x)),
  };
}

class SName {
  SName({
    required this.name,
    required this.link,
  });

  String name;
  String link;

  factory SName.fromJson(Map<String, dynamic> json) => SName(
    name: json["name"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "link": link,
  };
}

enum Status { OPEN }

final statusValues = EnumValues({
  "open": Status.OPEN
});

class Content {
  Content({
    required this.rendered,
    required this.protected,
  });

  String rendered;
  bool protected;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    rendered: json["rendered"],
    protected: json["protected"],
  );

  Map<String, dynamic> toJson() => {
    "rendered": rendered,
    "protected": protected,
  };
}

class Embedded {
  Embedded({
    required this.author,
    required this.wpFeaturedmedia,
    required this.wpTerm,
  });

  List<EmbeddedAuthor> author;
  List<WpFeaturedmedia> wpFeaturedmedia;
  List<List<EmbeddedWpTerm>> wpTerm;

  factory Embedded.fromJson(Map<String, dynamic> json) => Embedded(
    author: List<EmbeddedAuthor>.from(json["author"].map((x) => EmbeddedAuthor.fromJson(x))),
    wpFeaturedmedia: List<WpFeaturedmedia>.from(json["wp:featuredmedia"].map((x) => WpFeaturedmedia.fromJson(x))),
    wpTerm: List<List<EmbeddedWpTerm>>.from(json["wp:term"].map((x) => List<EmbeddedWpTerm>.from(x.map((x) => EmbeddedWpTerm.fromJson(x))))),
  );

  Map<String, dynamic> toJson() => {
    "author": List<dynamic>.from(author.map((x) => x.toJson())),
    "wp:featuredmedia": List<dynamic>.from(wpFeaturedmedia.map((x) => x.toJson())),
    "wp:term": List<dynamic>.from(wpTerm.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
  };
}

class EmbeddedAuthor {
  EmbeddedAuthor({
    required this.code,
    required this.message,
    required this.data,
  });

  Code code;
  Message message;
  Data data;

  factory EmbeddedAuthor.fromJson(Map<String, dynamic> json) => EmbeddedAuthor(
    code: codeValues.map[json["code"]]!,
    message: messageValues.map[json["message"]]!,
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": codeValues.reverse[code],
    "message": messageValues.reverse[message],
    "data": data.toJson(),
  };
}

enum Code { REST_USER_INVALID_ID }

final codeValues = EnumValues({
  "rest_user_invalid_id": Code.REST_USER_INVALID_ID
});

class Data {
  Data({
    required this.status,
  });

  int status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
  };
}

enum Message { INVALID_USER_ID }

final messageValues = EnumValues({
  "Invalid user ID.": Message.INVALID_USER_ID
});

class WpFeaturedmedia {
  WpFeaturedmedia({
    required this.id,
    required this.date,
    required this.slug,
    required this.type,
    required this.link,
    required this.title,
    required this.author,
    required this.smush,
    this.blogPostLayoutFeaturedMediaUrls,
    this.categoriesNames,
    required this.commentsNumber,
    required this.caption,
    required this.altText,
    required this.mediaType,
    required this.mimeType,
    required this.mediaDetails,
    required this.sourceUrl,
    required this.links,
  });

  int id;
  DateTime date;
  String slug;
  WpFeaturedmediaType type;
  String link;
  Guid title;
  int author;
  Smush smush;
  dynamic blogPostLayoutFeaturedMediaUrls;
  dynamic categoriesNames;
  String commentsNumber;
  Guid caption;
  String altText;
  MediaType mediaType;
  MimeType mimeType;
  MediaDetails mediaDetails;
  String sourceUrl;
  WpFeaturedmediaLinks links;

  factory WpFeaturedmedia.fromJson(Map<String, dynamic> json) => WpFeaturedmedia(
    id: json["id"],
    date: DateTime.parse(json["date"]),
    slug: json["slug"],
    type: wpFeaturedmediaTypeValues.map[json["type"]]!,
    link: json["link"],
    title: Guid.fromJson(json["title"]),
    author: json["author"],
    smush: Smush.fromJson(json["smush"]),
    blogPostLayoutFeaturedMediaUrls: json["blog_post_layout_featured_media_urls"],
    categoriesNames: json["categories_names"],
    commentsNumber: json["comments_number"],
    caption: Guid.fromJson(json["caption"]),
    altText: json["alt_text"],
    mediaType: mediaTypeValues.map[json["media_type"]]!,
    mimeType: mimeTypeValues.map[json["mime_type"]]!,
    mediaDetails: MediaDetails.fromJson(json["media_details"]),
    sourceUrl: json["source_url"],
    links: WpFeaturedmediaLinks.fromJson(json["_links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date.toIso8601String(),
    "slug": slug,
    "type": wpFeaturedmediaTypeValues.reverse[type],
    "link": link,
    "title": title.toJson(),
    "author": author,
    "smush": smush.toJson(),
    "blog_post_layout_featured_media_urls": blogPostLayoutFeaturedMediaUrls,
    "categories_names": categoriesNames,
    "comments_number": commentsNumber,
    "caption": caption.toJson(),
    "alt_text": altText,
    "media_type": mediaTypeValues.reverse[mediaType],
    "mime_type": mimeTypeValues.reverse[mimeType],
    "media_details": mediaDetails.toJson(),
    "source_url": sourceUrl,
    "_links": links.toJson(),
  };
}

class Guid {
  Guid({
    required this.rendered,
  });

  String rendered;

  factory Guid.fromJson(Map<String, dynamic> json) => Guid(
    rendered: json["rendered"],
  );

  Map<String, dynamic> toJson() => {
    "rendered": rendered,
  };
}

class WpFeaturedmediaLinks {
  WpFeaturedmediaLinks({
    required this.self,
    required this.collection,
    required this.about,
    required this.author,
    required this.replies,
  });

  List<About> self;
  List<About> collection;
  List<About> about;
  List<ReplyElement> author;
  List<ReplyElement> replies;

  factory WpFeaturedmediaLinks.fromJson(Map<String, dynamic> json) => WpFeaturedmediaLinks(
    self: List<About>.from(json["self"].map((x) => About.fromJson(x))),
    collection: List<About>.from(json["collection"].map((x) => About.fromJson(x))),
    about: List<About>.from(json["about"].map((x) => About.fromJson(x))),
    author: List<ReplyElement>.from(json["author"].map((x) => ReplyElement.fromJson(x))),
    replies: List<ReplyElement>.from(json["replies"].map((x) => ReplyElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "self": List<dynamic>.from(self.map((x) => x.toJson())),
    "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
    "about": List<dynamic>.from(about.map((x) => x.toJson())),
    "author": List<dynamic>.from(author.map((x) => x.toJson())),
    "replies": List<dynamic>.from(replies.map((x) => x.toJson())),
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

class ReplyElement {
  ReplyElement({
    required this.embeddable,
    required this.href,
  });

  bool embeddable;
  String href;

  factory ReplyElement.fromJson(Map<String, dynamic> json) => ReplyElement(
    embeddable: json["embeddable"],
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "embeddable": embeddable,
    "href": href,
  };
}

class MediaDetails {
  MediaDetails({
    required this.width,
    required this.height,
    required this.file,
    this.filesize,
    required this.sizes,
    required this.imageMeta,
  });

  int width;
  int height;
  String file;
  String? filesize;
  Map<String, MediaDetailsSize> sizes;
  ImageMeta imageMeta;

  factory MediaDetails.fromJson(Map<String, dynamic> json) => MediaDetails(
    width: json["width"],
    height: json["height"],
    file: json["file"],
    filesize: json["filesize"],
    sizes: Map.from(json["sizes"]).map((k, v) => MapEntry<String, MediaDetailsSize>(k, MediaDetailsSize.fromJson(v))),
    imageMeta: ImageMeta.fromJson(json["image_meta"]),
  );

  Map<String, dynamic> toJson() => {
    "width": width,
    "height": height,
    "file": file,
    "filesize": filesize,
    "sizes": Map.from(sizes).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "image_meta": imageMeta.toJson(),
  };
}

class ImageMeta {
  ImageMeta({
    required this.aperture,
    required this.credit,
    required this.camera,
    required this.caption,
    required this.createdTimestamp,
    required this.copyright,
    required this.focalLength,
    required this.iso,
    required this.shutterSpeed,
    required this.title,
    required this.orientation,
    this.keywords,
  });

  String aperture;
  String credit;
  String camera;
  String caption;
  String createdTimestamp;
  String copyright;
  String focalLength;
  String iso;
  String shutterSpeed;
  String title;
  String orientation;
  List<dynamic>? keywords;

  factory ImageMeta.fromJson(Map<String, dynamic> json) => ImageMeta(
    aperture: json["aperture"],
    credit: json["credit"],
    camera: json["camera"],
    caption: json["caption"],
    createdTimestamp: json["created_timestamp"],
    copyright: json["copyright"],
    focalLength: json["focal_length"],
    iso: json["iso"],
    shutterSpeed: json["shutter_speed"],
    title: json["title"],
    orientation: json["orientation"],
    keywords: json["keywords"] == null ? [] : List<dynamic>.from(json["keywords"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "aperture": aperture,
    "credit": credit,
    "camera": camera,
    "caption": caption,
    "created_timestamp": createdTimestamp,
    "copyright": copyright,
    "focal_length": focalLength,
    "iso": iso,
    "shutter_speed": shutterSpeed,
    "title": title,
    "orientation": orientation,
    "keywords": keywords == null ? [] : List<dynamic>.from(keywords!.map((x) => x)),
  };
}

class MediaDetailsSize {
  MediaDetailsSize({
    required this.file,
    required this.width,
    required this.height,
    required this.mimeType,
    required this.sourceUrl,
    this.filesize,
    this.uncropped,
  });

  String file;
  int width;
  int height;
  MimeType mimeType;
  String sourceUrl;
  String? filesize;
  dynamic uncropped;

  factory MediaDetailsSize.fromJson(Map<String, dynamic> json) => MediaDetailsSize(
    file: json["file"],
    width: json["width"],
    height: json["height"],
    mimeType: mimeTypeValues.map[json["mime_type"]]!,
    sourceUrl: json["source_url"],
    filesize: json["filesize"],
    uncropped: json["uncropped"],
  );

  Map<String, dynamic> toJson() => {
    "file": file,
    "width": width,
    "height": height,
    "mime_type": mimeTypeValues.reverse[mimeType],
    "source_url": sourceUrl,
    "filesize": filesize,
    "uncropped": uncropped,
  };
}

enum MimeType { IMAGE_JPEG, IMAGE_PNG }

final mimeTypeValues = EnumValues({
  "image/jpeg": MimeType.IMAGE_JPEG,
  "image/png": MimeType.IMAGE_PNG
});

enum MediaType { IMAGE }

final mediaTypeValues = EnumValues({
  "image": MediaType.IMAGE
});

class Smush {
  Smush({
    required this.stats,
    required this.sizes,
  });

  Stats stats;
  Map<String, SmushSize> sizes;

  factory Smush.fromJson(Map<String, dynamic> json) => Smush(
    stats: Stats.fromJson(json["stats"]),
    sizes: Map.from(json["sizes"]).map((k, v) => MapEntry<String, SmushSize>(k, SmushSize.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "stats": stats.toJson(),
    "sizes": Map.from(sizes).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class SmushSize {
  SmushSize({
    required this.percent,
    required this.bytes,
    required this.sizeBefore,
    required this.sizeAfter,
    required this.time,
  });

  double percent;
  int bytes;
  int sizeBefore;
  int sizeAfter;
  double time;

  factory SmushSize.fromJson(Map<String, dynamic> json) => SmushSize(
    percent: json["percent"]?.toDouble(),
    bytes: json["bytes"],
    sizeBefore: json["size_before"],
    sizeAfter: json["size_after"],
    time: json["time"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "percent": percent,
    "bytes": bytes,
    "size_before": sizeBefore,
    "size_after": sizeAfter,
    "time": time,
  };
}

class Stats {
  Stats({
    required this.percent,
    required this.bytes,
    required this.sizeBefore,
    required this.sizeAfter,
    required this.time,
    required this.apiVersion,
    required this.lossy,
    required this.keepExif,
  });

  double percent;
  int bytes;
  int sizeBefore;
  int sizeAfter;
  double time;
  String apiVersion;
  bool lossy;
  int keepExif;

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
    percent: json["percent"]?.toDouble(),
    bytes: json["bytes"],
    sizeBefore: json["size_before"],
    sizeAfter: json["size_after"],
    time: json["time"]?.toDouble(),
    apiVersion: json["api_version"],
    lossy: json["lossy"],
    keepExif: json["keep_exif"],
  );

  Map<String, dynamic> toJson() => {
    "percent": percent,
    "bytes": bytes,
    "size_before": sizeBefore,
    "size_after": sizeAfter,
    "time": time,
    "api_version": apiVersion,
    "lossy": lossy,
    "keep_exif": keepExif,
  };
}

enum WpFeaturedmediaType { ATTACHMENT }

final wpFeaturedmediaTypeValues = EnumValues({
  "attachment": WpFeaturedmediaType.ATTACHMENT
});

class EmbeddedWpTerm {
  EmbeddedWpTerm({
    required this.id,
    required this.link,
    required this.name,
    required this.slug,
    required this.taxonomy,
    required this.links,
  });

  int id;
  String link;
  String name;
  String slug;
  Taxonomy taxonomy;
  WpTermLinks links;

  factory EmbeddedWpTerm.fromJson(Map<String, dynamic> json) => EmbeddedWpTerm(
    id: json["id"],
    link: json["link"],
    name: json["name"],
    slug: json["slug"],
    taxonomy: taxonomyValues.map[json["taxonomy"]]!,
    links: WpTermLinks.fromJson(json["_links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "link": link,
    "name": name,
    "slug": slug,
    "taxonomy": taxonomyValues.reverse[taxonomy],
    "_links": links.toJson(),
  };
}

class WpTermLinks {
  WpTermLinks({
    required this.self,
    required this.collection,
    required this.about,
    required this.wpPostType,
    required this.curies,
  });

  List<About> self;
  List<About> collection;
  List<About> about;
  List<About> wpPostType;
  List<Cury> curies;

  factory WpTermLinks.fromJson(Map<String, dynamic> json) => WpTermLinks(
    self: List<About>.from(json["self"].map((x) => About.fromJson(x))),
    collection: List<About>.from(json["collection"].map((x) => About.fromJson(x))),
    about: List<About>.from(json["about"].map((x) => About.fromJson(x))),
    wpPostType: List<About>.from(json["wp:post_type"].map((x) => About.fromJson(x))),
    curies: List<Cury>.from(json["curies"].map((x) => Cury.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "self": List<dynamic>.from(self.map((x) => x.toJson())),
    "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
    "about": List<dynamic>.from(about.map((x) => x.toJson())),
    "wp:post_type": List<dynamic>.from(wpPostType.map((x) => x.toJson())),
    "curies": List<dynamic>.from(curies.map((x) => x.toJson())),
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

enum Taxonomy { CATEGORY, POST_TAG }

final taxonomyValues = EnumValues({
  "category": Taxonomy.CATEGORY,
  "post_tag": Taxonomy.POST_TAG
});

enum Format { STANDARD }

final formatValues = EnumValues({
  "standard": Format.STANDARD
});

class CargoNewWireNewsResponseLinks {
  CargoNewWireNewsResponseLinks({
    required this.self,
    required this.collection,
    required this.about,
    required this.author,
    required this.replies,
    required this.versionHistory,
    required this.predecessorVersion,
    required this.wpFeaturedmedia,
    required this.wpAttachment,
    required this.wpTerm,
    required this.curies,
  });

  List<About> self;
  List<About> collection;
  List<About> about;
  List<ReplyElement> author;
  List<ReplyElement> replies;
  List<VersionHistory> versionHistory;
  List<PredecessorVersion> predecessorVersion;
  List<ReplyElement> wpFeaturedmedia;
  List<About> wpAttachment;
  List<LinksWpTerm> wpTerm;
  List<Cury> curies;

  factory CargoNewWireNewsResponseLinks.fromJson(Map<String, dynamic> json) => CargoNewWireNewsResponseLinks(
    self: List<About>.from(json["self"].map((x) => About.fromJson(x))),
    collection: List<About>.from(json["collection"].map((x) => About.fromJson(x))),
    about: List<About>.from(json["about"].map((x) => About.fromJson(x))),
    author: List<ReplyElement>.from(json["author"].map((x) => ReplyElement.fromJson(x))),
    replies: List<ReplyElement>.from(json["replies"].map((x) => ReplyElement.fromJson(x))),
    versionHistory: List<VersionHistory>.from(json["version-history"].map((x) => VersionHistory.fromJson(x))),
    predecessorVersion: List<PredecessorVersion>.from(json["predecessor-version"].map((x) => PredecessorVersion.fromJson(x))),
    wpFeaturedmedia: List<ReplyElement>.from(json["wp:featuredmedia"].map((x) => ReplyElement.fromJson(x))),
    wpAttachment: List<About>.from(json["wp:attachment"].map((x) => About.fromJson(x))),
    wpTerm: List<LinksWpTerm>.from(json["wp:term"].map((x) => LinksWpTerm.fromJson(x))),
    curies: List<Cury>.from(json["curies"].map((x) => Cury.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "self": List<dynamic>.from(self.map((x) => x.toJson())),
    "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
    "about": List<dynamic>.from(about.map((x) => x.toJson())),
    "author": List<dynamic>.from(author.map((x) => x.toJson())),
    "replies": List<dynamic>.from(replies.map((x) => x.toJson())),
    "version-history": List<dynamic>.from(versionHistory.map((x) => x.toJson())),
    "predecessor-version": List<dynamic>.from(predecessorVersion.map((x) => x.toJson())),
    "wp:featuredmedia": List<dynamic>.from(wpFeaturedmedia.map((x) => x.toJson())),
    "wp:attachment": List<dynamic>.from(wpAttachment.map((x) => x.toJson())),
    "wp:term": List<dynamic>.from(wpTerm.map((x) => x.toJson())),
    "curies": List<dynamic>.from(curies.map((x) => x.toJson())),
  };
}

class PredecessorVersion {
  PredecessorVersion({
    required this.id,
    required this.href,
  });

  int id;
  String href;

  factory PredecessorVersion.fromJson(Map<String, dynamic> json) => PredecessorVersion(
    id: json["id"],
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "href": href,
  };
}

class VersionHistory {
  VersionHistory({
    required this.count,
    required this.href,
  });

  int count;
  String href;

  factory VersionHistory.fromJson(Map<String, dynamic> json) => VersionHistory(
    count: json["count"],
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "href": href,
  };
}

class LinksWpTerm {
  LinksWpTerm({
    required this.taxonomy,
    required this.embeddable,
    required this.href,
  });

  Taxonomy taxonomy;
  bool embeddable;
  String href;

  factory LinksWpTerm.fromJson(Map<String, dynamic> json) => LinksWpTerm(
    taxonomy: taxonomyValues.map[json["taxonomy"]]!,
    embeddable: json["embeddable"],
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "taxonomy": taxonomyValues.reverse[taxonomy],
    "embeddable": embeddable,
    "href": href,
  };
}

class Meta {
  Meta({
    required this.eventAllDay,
    required this.eventTimezone,
    required this.eventStartDate,
    required this.eventEndDate,
    required this.eventStartDateUtc,
    required this.eventEndDateUtc,
    required this.eventShowMap,
    required this.eventShowMapLink,
    required this.eventUrl,
    required this.eventCost,
    required this.eventCostDescription,
    required this.eventCurrencySymbol,
    required this.eventCurrencyCode,
    required this.eventCurrencyPosition,
    required this.eventDateTimeSeparator,
    required this.eventTimeRangeSeparator,
    required this.eventOrganizerId,
    required this.eventVenueId,
    required this.organizerEmail,
    required this.organizerPhone,
    required this.organizerWebsite,
    required this.venueAddress,
    required this.venueCity,
    required this.venueCountry,
    required this.venueProvince,
    required this.venueZip,
    required this.venuePhone,
    required this.venueUrl,
    required this.venueStateProvince,
    required this.venueLat,
    required this.venueLng,
  });

  bool eventAllDay;
  String eventTimezone;
  String eventStartDate;
  String eventEndDate;
  String eventStartDateUtc;
  String eventEndDateUtc;
  bool eventShowMap;
  bool eventShowMapLink;
  String eventUrl;
  String eventCost;
  String eventCostDescription;
  String eventCurrencySymbol;
  String eventCurrencyCode;
  String eventCurrencyPosition;
  String eventDateTimeSeparator;
  String eventTimeRangeSeparator;
  List<dynamic> eventOrganizerId;
  int eventVenueId;
  String organizerEmail;
  String organizerPhone;
  String organizerWebsite;
  String venueAddress;
  String venueCity;
  String venueCountry;
  String venueProvince;
  String venueZip;
  String venuePhone;
  String venueUrl;
  String venueStateProvince;
  String venueLat;
  String venueLng;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    eventAllDay: json["_EventAllDay"],
    eventTimezone: json["_EventTimezone"],
    eventStartDate: json["_EventStartDate"],
    eventEndDate: json["_EventEndDate"],
    eventStartDateUtc: json["_EventStartDateUTC"],
    eventEndDateUtc: json["_EventEndDateUTC"],
    eventShowMap: json["_EventShowMap"],
    eventShowMapLink: json["_EventShowMapLink"],
    eventUrl: json["_EventURL"],
    eventCost: json["_EventCost"],
    eventCostDescription: json["_EventCostDescription"],
    eventCurrencySymbol: json["_EventCurrencySymbol"],
    eventCurrencyCode: json["_EventCurrencyCode"],
    eventCurrencyPosition: json["_EventCurrencyPosition"],
    eventDateTimeSeparator: json["_EventDateTimeSeparator"],
    eventTimeRangeSeparator: json["_EventTimeRangeSeparator"],
    eventOrganizerId: List<dynamic>.from(json["_EventOrganizerID"].map((x) => x)),
    eventVenueId: json["_EventVenueID"],
    organizerEmail: json["_OrganizerEmail"],
    organizerPhone: json["_OrganizerPhone"],
    organizerWebsite: json["_OrganizerWebsite"],
    venueAddress: json["_VenueAddress"],
    venueCity: json["_VenueCity"],
    venueCountry: json["_VenueCountry"],
    venueProvince: json["_VenueProvince"],
    venueZip: json["_VenueZip"],
    venuePhone: json["_VenuePhone"],
    venueUrl: json["_VenueURL"],
    venueStateProvince: json["_VenueStateProvince"],
    venueLat: json["_VenueLat"],
    venueLng: json["_VenueLng"],
  );

  Map<String, dynamic> toJson() => {
    "_EventAllDay": eventAllDay,
    "_EventTimezone": eventTimezone,
    "_EventStartDate": eventStartDate,
    "_EventEndDate": eventEndDate,
    "_EventStartDateUTC": eventStartDateUtc,
    "_EventEndDateUTC": eventEndDateUtc,
    "_EventShowMap": eventShowMap,
    "_EventShowMapLink": eventShowMapLink,
    "_EventURL": eventUrl,
    "_EventCost": eventCost,
    "_EventCostDescription": eventCostDescription,
    "_EventCurrencySymbol": eventCurrencySymbol,
    "_EventCurrencyCode": eventCurrencyCode,
    "_EventCurrencyPosition": eventCurrencyPosition,
    "_EventDateTimeSeparator": eventDateTimeSeparator,
    "_EventTimeRangeSeparator": eventTimeRangeSeparator,
    "_EventOrganizerID": List<dynamic>.from(eventOrganizerId.map((x) => x)),
    "_EventVenueID": eventVenueId,
    "_OrganizerEmail": organizerEmail,
    "_OrganizerPhone": organizerPhone,
    "_OrganizerWebsite": organizerWebsite,
    "_VenueAddress": venueAddress,
    "_VenueCity": venueCity,
    "_VenueCountry": venueCountry,
    "_VenueProvince": venueProvince,
    "_VenueZip": venueZip,
    "_VenuePhone": venuePhone,
    "_VenueURL": venueUrl,
    "_VenueStateProvince": venueStateProvince,
    "_VenueLat": venueLat,
    "_VenueLng": venueLng,
  };
}

enum StatusEnum { PUBLISH }

final statusEnumValues = EnumValues({
  "publish": StatusEnum.PUBLISH
});

enum CargoNewWireNewsResponseType { POST }

final cargoNewWireNewsResponseTypeValues = EnumValues({
  "post": CargoNewWireNewsResponseType.POST
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
