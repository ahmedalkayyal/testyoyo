import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m3u_nullsafe/m3u_nullsafe.dart';
import 'package:testyoyo/model/my_channel_model.dart';
import 'package:testyoyo/view/home/bloc/home_events.dart';
import 'package:testyoyo/view/home/bloc/home_states.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {

  HomeBloc() : super(HomeUninitialized());

  final List<MyChannelModel> _myData = [];

  @override
  Stream<HomeStates> mapEventToState(HomeEvents event) async* {
    if (event is GetChannels) {
      try {
        yield HomeLoading();

        Dio dio = Dio();
        var resp = await dio.get(event.url);
        // "https://iptv-org.github.io/iptv/countries/dz.m3u");
        var m3u = await M3uParser.parse(resp.data);
        final categories = sortedCategories(entries: m3u, attributeName: 'group-title');

        List<String> keyNames = categories.keys.toList();
        for (int i = 0; i < keyNames.length; i++) {
          //log('${keyNames[i]}: ${categories[keyNames[i]]}');
          List<M3uGenericEntry> temp = categories[keyNames[i]]!.toList();
          for (int j = 0; j < temp.length; j++) {
            _myData.add(MyChannelModel(temp[j].title, temp[j].link, keyNames[i]));
          }
        }
        print('init done');
        for (int i = 0; i < _myData.length; i++) {
          print("${_myData[i].title}: ${_myData[i].link}");
        }

        if (_myData.isNotEmpty) {
          yield HomeLoaded(_myData);

        } else {
          yield HomeFailed('error_title', 'error_body');
        }
      }
      catch (e) {
        print(e.toString());
        yield HomeFailed('error_title', e.toString());
      }
    }
  }
}
