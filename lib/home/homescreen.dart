import 'package:flutter/material.dart';
import 'package:newproject/provider/serviceprovider.dart';
import 'package:provider/provider.dart';

import '../model/albumItem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {

  late Future<Album> albumFuture;

  Future<List<Album>>? mainData;

  @override
  void initState() {
    super.initState();

   /* albumFuture = fetchAlbum();*/

    mainData = Provider.of<MainProvider>(context, listen: false).getItems();

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              FutureBuilder<List<Album>>(
                future: mainData,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return Center(
                      child: Text(
                        '${snapshot.error} occurred',
                        style: const TextStyle(fontSize: 18),
                      ),
                    );

                    // if we got our data
                  }
                  else if (snapshot.connectionState == ConnectionState.waiting) {

                    return const Padding(
                      padding: EdgeInsets.only(top: 40.0),
                      child: Center(child: CircularProgressIndicator(),),
                    );

                  }

                  else if (snapshot.connectionState == ConnectionState.done){

                    var snapData = snapshot.data!;
                    List<Album> list = snapData;


                    return buildList(list.take(5).toList());


                  }
                  else if (!snapshot.hasData){
                    return  const Center(
                      child: Text(
                        'No data!',
                        style: TextStyle(fontSize: 18),
                      ),
                    );

                  }
                  else {
                    showDialog(context: context, builder: (context) {
                                      return const Center(child: CircularProgressIndicator(),);
                                    });
                    print(snapshot.connectionState);
                    return Text(' ');
                  }

                },
              ),
            ],

          ),
        ),
      ),
    );
  }


  buildList(List<Album> albums) {
    return Column( children: List.generate(albums.length, (index) =>
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(20),
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(3.9),
          ),
          child: Column(
            children: [
              Image.network(albums[index].thumbnailUrl!, width: 40, height: 40,),
              SizedBox(height: 20,),
              Text(albums[index].title!, style: TextStyle(fontSize: 12),),
            ],
          ),
        )
    )
    );
  }


}
