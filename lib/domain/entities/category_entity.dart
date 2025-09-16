import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String slug;
  final String name;
  final String url;

  CategoryEntity({
    required this.slug,
    required this.name,
    required this.url,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [slug, name, url];
}