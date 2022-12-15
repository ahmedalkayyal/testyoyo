import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testyoyo/view/home/bloc/home_bloc.dart';
import 'package:testyoyo/view/home/bloc/home_events.dart';
import 'package:testyoyo/view/home/bloc/home_states.dart';
import 'package:testyoyo/view/video_player/video_player_screen.dart';
import 'package:video_player/video_player.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _textEditingController;

  late VideoPlayerController controller;

  String videoUrl = '';
  final HomeBloc _bloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(videoUrl);
    _textEditingController = TextEditingController(text: "https://iptv-org.github.io/iptv/countries/dz.m3u");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder(
        bloc:_bloc,
        builder: (context, HomeStates state){
          if(state is HomeUninitialized){
            return SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   const Text('Add The M3U URL',
                    style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold,),
                  ),
                  const SizedBox(height: 50,),
                  Center(
                    child: TextFormField(
                      controller: _textEditingController,
                      autofocus: true,
                      cursorColor: Colors.red,
                      style: const TextStyle(color: Colors.white),
                      onFieldSubmitted: (String s){
                        _bloc.add(GetChannels(_textEditingController.value.text));
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          if(state is HomeLoaded){
            return ListView.builder(
                shrinkWrap: false,
                itemCount: state.myData.length,
                itemBuilder: (context, i) {
                  return ListTile(
                      leading: SizedBox(
                        width: MediaQuery.of(context).size.width*0.25,
                          child: Center(
                            child: Text(state.myData[i].category,
                              style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          )),
                      title: Padding(
                        padding: const EdgeInsets.all(10.0),
                         child: Text(state.myData[i].title,
                          style: const TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontSize: 18),),
                      ),
                      //subtitle: Text(state.myData[i].link,style: TextStyle(color: Colors.white,fontSize: 11),),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => VideoPlayerScreen(
                          videoUrl: state.myData[i].link,
                        )));
                      });
                });
          }
          if(state is HomeLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(state is HomeFailed){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(state.title),
                const SizedBox(
                  height: 16,
                ),
                Text(state.body)
              ],
            );
          }
          else{
            return Container();
          }
        }
      ),
    );
  }
}
