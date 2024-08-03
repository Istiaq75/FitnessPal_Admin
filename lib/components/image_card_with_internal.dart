import 'package:flutter/material.dart';

class ImageCardWithInternal extends StatelessWidget {
  final String image, title, duration;

  const ImageCardWithInternal({
    required this.image,
    required this.title,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.85,
      height: size.width * 0.40,
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.only(right: 15.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(this.image,),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              this.duration,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 4.0,
              horizontal: 10.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
              color: Colors.black.withAlpha(900),
            ),
          ),
          Text(
            this.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
