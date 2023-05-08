import 'package:flutter/material.dart';
import 'package:netflix/core/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/core/strings.dart';

class BackgroundImageCard extends StatelessWidget {
  const BackgroundImageCard({
    super.key,
    required this.size, this.image,
  });
  final String? image;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.width * 1.5,
      child: Stack(
        children: [
          Container(
            width: size.width,
            height: size.width * 1.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(image==null?kImage:imageAppendUrl + image!),
              ),
            ),
          ),
          Container(
            width: size.width,
            height: size.width * 1.5,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                radius: 1,
                colors: [
                  Colors.transparent,
                  Color.fromARGB(181, 0, 0, 0),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              child: Container(
                height: size.width * 0.16,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        Text('My List'),
                      ],
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kWhiteColor,
                        elevation: 0,
                      ),
                      onPressed: () {},
                      icon: Icon(
                        Icons.play_arrow,
                        color: kTextColorBlack,
                      ),
                      label: Text(
                        'Play',
                        style: TextStyle(
                            color: kTextColorBlack,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.info_outlined),
                        Text('Info'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
