part of 'favourite_cubit.dart';

class FavouriteState extends Equatable {
  FavouriteState({List<Coffee>? coffees}) : coffees = coffees ?? [];

  factory FavouriteState.fromJson(Map<String, dynamic> json) {
    return FavouriteState(
      coffees: (json['coffees'] as List)
          .map((e) => Coffee.fromJson(e as Map<String, dynamic>))
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
