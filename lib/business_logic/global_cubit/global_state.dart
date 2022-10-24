part of 'global_cubit.dart';

@immutable
abstract class GlobalState {}

class GlobalInitial extends GlobalState {}

class LoadingProductsState extends GlobalState{}

class LoadedProductsState extends GlobalState {
  final List<Products> products;

  LoadedProductsState(this.products);
  
}

class ErrorProductsState extends GlobalState {
  final String errorMessage;

  ErrorProductsState(this.errorMessage);
}

class LoadingHelpsState extends GlobalState{}

class LoadedHelpsState extends GlobalState {
  final List<Help> helps;

  LoadedHelpsState(this.helps);
  
}

class ErrorHelpsState extends GlobalState {
  final String errorMessage;

  ErrorHelpsState(this.errorMessage);
}







class BottomNavBarChangeState extends GlobalState{}


class CategoriesChangeState extends GlobalState{}

class SaveToSharedPrefrencesState extends GlobalState{}
class RemoveSharedPrefrencesState extends GlobalState{}
class GetCachedState extends GlobalState{}



class ChangeFavoriteStateState extends GlobalState{}




