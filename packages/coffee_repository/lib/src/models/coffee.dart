import 'dart:io';

import 'package:equatable/equatable.dart';

class Coffee extends Equatable {
  Coffee({
    required this.url,
    required this.image,
    String? imageName,
  }) : imageName = imageName ?? url.split('/').last;

  factory Coffee.fromJson(Map<String, dynamic> json, {required String path}) {
    final imageName = json['image_name'] as String;
    return Coffee(
      url: json['url'] as String,
      imageName: imageName,
      image: File.fromUri(
        Uri.file(
          '$path/$imageName',
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
  final String imageName;
  final File image;

  Map<String, dynamic> toJson() => {
        'url': url,
        'image_name': imageName,
      };

  @override
  List<Object?> get props => [url];
}
