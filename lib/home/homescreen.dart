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


                    return buildList(list);


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
          padding:EdgeInsets.all(10),
          width: (MediaQuery.of(context).size.width - 60) / 2,
          height: 160,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(3.9),
          ),
          child: Column(
            children: [
              Image.network(albums[index].url!),
              SizedBox(height: 8,),
              Text(albums[index].title!, style: TextStyle(fontSize: 14),),
            ],
          ),
        )
    )
    );
  }


}
