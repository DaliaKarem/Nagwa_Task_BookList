import 'dart:convert';

import 'package:equatable/equatable.dart';

class BookModel extends Equatable {
  final int id;
  final String title;
  final List<Authors> authors;
  final List<String>? summaries;
  final List<String>? subjects;
  final List<String>? bookshelves;
  final List<String>? languages;
  final bool? copyright;
  final String? mediaType;
  final Formats? formats;
  final int? downloadCount;
  BookModel(
      { required this.id,
        required this.title,
        required this.authors,
        this.summaries,
        this.subjects,
        this.bookshelves,
        this.languages,
        this.copyright,
        this.mediaType,
        this.formats,
        this.downloadCount,});

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No Title',
      authors: (json['authors'] as List<dynamic>?)
          ?.map((e) => Authors.fromJson(e))
          .toList() ?? [],
      summaries: (json['summaries'] as List<dynamic>?)?.cast<String>(),
      subjects: (json['subjects'] as List<dynamic>?)?.cast<String>(),
      bookshelves: (json['bookshelves'] as List<dynamic>?)?.cast<String>(),
      languages: (json['languages'] as List<dynamic>?)?.cast<String>(),
      copyright: json['copyright'],
      mediaType: json['media_type'],
      formats: json['formats'] != null ? Formats.fromJson(json['formats']) : null,
      downloadCount: json['download_count'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'authors': jsonEncode(authors.map((a) => a.toJson()).toList()),
      'summaries': jsonEncode(summaries),
      'subjects': jsonEncode(subjects),
      'bookshelves': jsonEncode(bookshelves),
      'languages': jsonEncode(languages),
      'copyright': copyright == true ? 1 : 0,
      'media_type': mediaType,
      'formats': formats != null ? jsonEncode(formats!.toJson()) : null,
      'download_count': downloadCount,
    };
  }


  @override
  List<Object?> get props => [
    id,
    title,
    authors,
    summaries,
    subjects,
    bookshelves,
    languages,
    copyright,
    mediaType,
    formats,
    downloadCount,
  ];
}

class Authors {
  String? name;
  int? birthYear;
  int? deathYear;

  Authors({this.name, this.birthYear, this.deathYear});

  Authors.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    birthYear = json['birth_year'];
    deathYear = json['death_year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['birth_year'] = this.birthYear;
    data['death_year'] = this.deathYear;
    return data;
  }
}

class Formats {
  String? textHtml;
  String? applicationEpubZip;
  String? applicationXMobipocketEbook;
  String? applicationRdfXml;
  String? imageJpeg;
  String? textPlainCharsetUsAscii;
  String? applicationOctetStream;

  Formats(
      {this.textHtml,
        this.applicationEpubZip,
        this.applicationXMobipocketEbook,
        this.applicationRdfXml,
        this.imageJpeg,
        this.textPlainCharsetUsAscii,
        this.applicationOctetStream});

  Formats.fromJson(Map<String, dynamic> json) {
    textHtml = json['text/html'];
    applicationEpubZip = json['application/epub+zip'];
    applicationXMobipocketEbook = json['application/x-mobipocket-ebook'];
    applicationRdfXml = json['application/rdf+xml'];
    imageJpeg = json['image/jpeg'];
    textPlainCharsetUsAscii = json['text/plain; charset=us-ascii'];
    applicationOctetStream = json['application/octet-stream'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text/html'] = this.textHtml;
    data['application/epub+zip'] = this.applicationEpubZip;
    data['application/x-mobipocket-ebook'] = this.applicationXMobipocketEbook;
    data['application/rdf+xml'] = this.applicationRdfXml;
    data['image/jpeg'] = this.imageJpeg;
    data['text/plain; charset=us-ascii'] = this.textPlainCharsetUsAscii;
    data['application/octet-stream'] = this.applicationOctetStream;
    return data;
  }
}
