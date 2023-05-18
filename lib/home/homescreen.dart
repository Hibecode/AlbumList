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


  Future<List<Album>>? mainData;

  @override
  void initState() {
    super.initState();

    mainData = Provider.of<MainProvider>(context, listen: false).getItems();

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Album List'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [


              Text('List of Albums', style: TextStyle(fontSize: 16),),

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


                    return buildList(list.take(30).toList());


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
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(8),
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(albums[index].thumbnailUrl!), fit: BoxFit.cover),
            color: Colors.grey,
            borderRadius: BorderRadius.circular(3.9),
          ),
          child: Column(
            children: [
              Align(
                child: Text(albums[index].title!, style: TextStyle(fontSize: 12, color: Colors.white),),
              ),
            ],
          ),
        )
    )
    );
  }


}
