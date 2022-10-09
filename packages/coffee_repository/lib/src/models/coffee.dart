import 'dart:io';

import 'package:equatable/equatable.dart';

class Coffee extends Equatable {
  const Coffee({
    required this.url,
    required this.image,
  });

  factory Coffee.fromJson(Map<String, dynamic> json) {
    return Coffee(
      url: json['url'] as String,
      image: File.fromUri(
        Uri.file(
          json['image_path'] as String,
        ),
      ),
    );
  }

  Coffee copyWith({
    String? url,
    File? image,
  }) =>
      Coffee(
        url: url ?? this.url,
        image: image ?? this.image,
      );

  final String url;
  final File image;

  Map<String, dynamic> toJson() => {
        'url': url,
        'image_path': image.path,
      };

  @override
  List<Object?> get props => [url, image];
}
