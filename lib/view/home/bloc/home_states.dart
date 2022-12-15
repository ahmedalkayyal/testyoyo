import 'package:testyoyo/model/my_channel_model.dart';

abstract class HomeStates {}

class HomeUninitialized extends HomeStates{}

class HomeLoading extends HomeStates{}

class HomeLoaded extends HomeStates{

  final List<MyChannelModel> myData;

  HomeLoaded(this.myData);
}

class HomeFailed extends HomeStates{
  final String title;
  final String body;

  HomeFailed(this.title, this.body);
}

