part of 'favourite_cubit.dart';

class FavouriteState extends Equatable {
  FavouriteState({List<Coffee>? coffees}) : coffees = coffees ?? [];

  factory FavouriteState.fromJson(
    Map<String, dynamic> json, {
    required String path,
  }) {
    return FavouriteState(
      coffees: (json['coffees'] as List)
          .map((e) => Coffee.fromJson(e as Map<String, dynamic>, path: path))
          .toList(),
    );
  }

  final List<Coffee> coffees;

  Map<String, dynamic> toJson() => {
        'coffees': coffees.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object> get props => [coffees];
}
