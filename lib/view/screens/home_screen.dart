import 'dart:async';
import 'package:newz_app/services/function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:newz_app/services/call_api.dart';
import 'package:newz_app/widgets/categorie_button.dart';
import '../../constant.dart';
import 'package:http/http.dart' as http;


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState()  => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f5fcff),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0, left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Welcome Text
              const Text(
                'Welcome, ___!',
                style: TextStyle(
                  fontSize: fontbigger,
                  fontFamily: 'neue',
                ),
              ),

              /// Space
              const SizedBox(
                height: 10.0,
              ),

              /// TabBar view
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                padding: const EdgeInsets.only(top: 20.0),
                height: MediaQuery.of(context).size.height / 6,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CategorieButton(
                      categorie: 'health',
                      categorieImage: 'assets/images/Health.png',
                      categorietext: 'Health',
                      categorietextSize: 20.0,
                      categorieScaleImage: 1.0,
                    ),
                    CategorieButton(
                      categorie: 'sports',
                      categorieImage: 'assets/images/Sports.png',
                      categorietext: 'Sports',
                      categorietextSize: 20.0,
                    ),
                    CategorieButton(
                      categorie: 'technology',
                      categorieImage: 'assets/images/Technology.png',
                      categorietext: 'Technology',
                      categorieScaleImage: 1.1,
                      categorietextSize: 18.0,
                    ),
                    CategorieButton(
                      categorie: 'science',
                      categorieImage: 'assets/images/science.png',
                      categorietext: 'science',
                      categorieScaleImage: 0.7,
                      categorietextSize: 20.0,
                    ),
                    CategorieButton(
                      categorie: 'enviroment',
                      categorieImage: 'assets/images/Enviroment.png',
                      categorietext: 'Enviroment',
                      categorieScaleImage: 1.1,
                      categorietextSize: 18.0,
                    ),
                    CategorieButton(
                      categorie: 'business',
                      categorieImage: 'assets/images/Business.png',
                      categorietext: 'Business',
                      categorietextSize: 20.0,
                      categorieScaleImage: 1.1,
                    ),
                  ],
                ),
              ),

              /// Choose Text
              const Text(
                'General News',
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: darkblue,
                  fontSize: 20.0,
                  fontFamily: 'neue',
                ),
              ),
              /// Cards
              Expanded(
                child: FutureBuilder(
                  future: Api.fetchArticle(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: ()
                              {
                                if(snapshot.data[index].url==null){
                                  SnackBar snackBar = SnackBar(content: Text('This URL is\'nt avialable'));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }else{
                                  function.openLink('${snapshot.data[index].url}');
                                }
                              },
                              child: Card(
                                elevation: 10.0,
                                shadowColor: Colors.blue.withOpacity(0.3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Column(
                                  children: [
                                    Image.network(
                                      (snapshot.data[index].urlToImage==null)?'https://i.pinimg.com/564x/96/f2/bb/96f2bb94fcc9d64ca1fba04a1cf45a5e.jpg'
                                          :snapshot.data[index].urlToImage,
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 5.0),
                                      child: Text(
                                        '${snapshot.data[index].title}',
                                        textAlign: TextAlign.end,
                                        maxLines: 4,
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children:  [
                                        IconButton(
                                          onPressed:()
                                          {
                                            SnackBar snackBar =const SnackBar(content: Text('Link Copeid'));
                                            function.CopyLink(snapshot.data[index].url).then((value) =>
                                                ScaffoldMessenger.of(context).showSnackBar(snackBar));
                                          },
                                          icon:const Icon(Icons.content_copy_rounded,color: Colors.grey,),
                                          iconSize: 30.0,
                                        ),
                                        const SizedBox(width: 5.0,),
                                        IconButton(
                                          onPressed: ()
                                          {
                                            function.shareLink(snapshot.data[index].url);
                                          },
                                          icon:const Icon(Icons.share_rounded),
                                          iconSize: 30.0,
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}