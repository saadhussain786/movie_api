import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:untitled1/Screens/description.dart';
import 'package:untitled1/Services/movie_services.dart';
import 'package:untitled1/Utils/styles.dart';
class Fetch extends StatefulWidget {
  const Fetch({super.key});

  @override
  State<Fetch> createState() => _FetchState();
}

class _FetchState extends State<Fetch> {
  int num=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          if(num>1)
            {
              setState(() {
                num--;
              });

            }
          else
            {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You are already in page 1')));
            }
        },
        icon: Icon(Icons.chevron_left),
        ),
        title: Text('$num'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            setState(() {
              num++;
            });

          },
            icon: Icon(Icons.chevron_right),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: FutureBuilder(future: MovieApi.MovieFetch(num),
            builder: (context, snapshot) {
          if(ConnectionState.waiting==snapshot.connectionState)
            {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          if(snapshot.hasError)
            {
              return Center(
                child: Text('There has some Error!',style: TextStyle(
                  color: Colors.red,
                  fontSize: 25
                ),),
              );
            }
          if(snapshot.hasData)
            {
              Map map1=jsonDecode(snapshot.data);
              List data=map1['tv_shows'];

              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                String movie_name=data[index]['name'];
                String movie_network=data[index]['network'];
                String movie_country=data[index]['country'];
                String movie_thumbnail=data[index]['image_thumbnail_path'];
                String movie_date=data[index]['start_date'];
                var id=data[index]['id'];

                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Description(id1: id),));
                  },
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage('$movie_thumbnail')
                              )
                          ),
                          width: double.infinity,
                          height: 400,
                        ),
                        Text('$movie_name',style: AppStyles.textStyle(),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('$movie_country',style: AppStyles.textStyle(),),
                            SizedBox(width: 15,),
                            Text('$movie_network',style: AppStyles.textStyle(),)
                          ],
                        ),
                        Text('$movie_date',style: AppStyles.textStyle(),)
                      ],
                    ),
                  ),
                );
              },);
            }
              return Container();
            },),
      ),
    );
  }
}
