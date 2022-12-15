abstract class HomeEvents{}

class GetChannels extends HomeEvents{
  final String url;

  GetChannels(this.url);
}