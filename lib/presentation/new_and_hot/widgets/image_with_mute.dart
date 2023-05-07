import 'package:flutter/material.dart';
import 'package:netflix/core/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/presentation/search/widgets/search_idle.dart';

class ImageWithMuteButton extends StatelessWidget {
  const ImageWithMuteButton({
    super.key,
    required this.size,
    required this.widthPercet,
    required this.heightpercent,
    required this.imgPath,
  });
  final String? imgPath;
  final double widthPercet;
  final double heightpercent;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return imgPath == null
        ? SizedBox(
            width: size.width * widthPercet,
            height: size.width * heightpercent,
            child: Center(
              child: Text('No Thumbnail Found'),
            ),
          )
        : Container(
            width: size.width * widthPercet,
            height: size.width * heightpercent,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imageAppendUrl + imgPath!),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 7,
                  right: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: Icon(
                      Icons.volume_off_outlined,
                      color: kWhiteColor,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
