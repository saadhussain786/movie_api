import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:untitled1/Services/movie_services.dart';
class Description extends StatefulWidget {
  int id1;


  Description({required this.id1});

  @override
  State<Description> createState() => _DescriptionState(id2: id1);
}

class _DescriptionState extends State<Description> {
  int id2;

  _DescriptionState({required this.id2});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: MovieApi.MovieDescription(id2),
        builder: (context,AsyncSnapshot<dynamic> snapshot) {
          if(ConnectionState.waiting==snapshot.connectionState)
          {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasError)
          {
            return Center(child: Text('Error'));
          }
          if(snapshot.hasData)
          {
            Map map2=jsonDecode(snapshot.data);
            String name=map2['tvShow']['name'];
            String description=map2['tvShow']['description'];
            double rating=double.parse(map2['tvShow']['rating'])/2;
            String image=map2['tvShow']['image_thumbnail_path'];
            List pictures=map2['tvShow']['pictures'];

            print(rating);
            // List category=map2['genres'];
            
            return SingleChildScrollView(
              child: Column(
                children: [
                  Text('$name'),
                  Text('$description'),
                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   itemBuilder: (context, index) {
                  //   return Text('${category[index]}');
                  // },),
                  SizedBox(height: 20,),
                  CarouselSlider.builder(itemCount: 4, itemBuilder: (context, index, realIndex) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage('${pictures[index]}')
                        )
                      ),
                      width: double.infinity,height: 300,);
                  }, options: CarouselOptions(
                    autoPlay: true,
                    viewportFraction: 1
                  )),
                  SizedBox(height: 20,),
                  RatingBar.builder(
                    initialRating: rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    ignoreGestures: true,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ), onRatingUpdate: (rating) {  },
                  ),

                  Text('$rating'),
                  Container(
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage('$image')
                      )
                    ),
                  ),
                  SizedBox(height: 20,),


              
              
                ],
              ),
            );
          }
          return Container();
        },),
    );
  }
}
