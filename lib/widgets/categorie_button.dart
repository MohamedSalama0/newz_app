import 'package:flutter/material.dart';
import 'package:newz_app/view/screens/categorie_screen.dart';

class CategorieButton extends StatelessWidget {
  String categorietext;
  double categorietextSize;
  var categorieImage;
  double categorieScaleImage;
  String categorie;

  CategorieButton(
      {Key? key, required this.categorietextSize,
      this.categorieScaleImage = 1.0,
      required this.categorieImage,
      required this.categorietext,
      required this.categorie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width / 4,
        child: InkWell(
          onTap: ()
          {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context)
                  {
                    return CategorieScreen(category: categorie,categoryImage: categorieImage,);
                  })
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                children: [
                  Image.asset(
                    '$categorieImage',
                    scale: categorieScaleImage,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      categorietext,
                      style: TextStyle(
                        fontSize: categorietextSize,
                        fontFamily: 'neue',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}
