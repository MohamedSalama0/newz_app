import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newz_app/services/call_api.dart';
import 'package:newz_app/services/function.dart';
import 'package:newz_app/widgets/categorie_button.dart';

import '../../constant.dart';

class CategorieScreen extends StatefulWidget {
  final String? category;
  final  categoryImage;

  const CategorieScreen({Key? key, this.category,this.categoryImage}) : super(key: key);

  @override
  State<CategorieScreen> createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {
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
              Row(
                children: [
                  Image.asset(widget.categoryImage),
                  const SizedBox(width: 10.0,),
                  Text(
                    '${widget.category} News',
                    style: const TextStyle(
                      fontSize: 25.0,
                      fontFamily: 'neue',
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),

              /// Cards
              Expanded(
                child: FutureBuilder(
                  future: Api.fetchArticleByCategory(widget.category!),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                if (snapshot.data[index].url == null) {
                                  SnackBar snackBar = SnackBar(
                                      content:
                                          Text('This URL is\'nt avialable'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
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
                                      (snapshot.data[index].urlToImage == null)
                                          ? 'https://i.pinimg.com/564x/96/f2/bb/96f2bb94fcc9d64ca1fba04a1cf45a5e.jpg'
                                          : snapshot.data[index].urlToImage,
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
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
