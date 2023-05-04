import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/new_and_hot/widgets/description_text_widget.dart';
import 'package:netflix/presentation/new_and_hot/widgets/image_with_mute.dart';

class EveryonesWatching extends StatelessWidget {
  const EveryonesWatching({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ListView(
      children: [
        EveryoneWatchingItem(size: size),
        EveryoneWatchingItem(size: size),
        EveryoneWatchingItem(size: size),
        EveryoneWatchingItem(size: size),
      ],
    );
  }
}

class EveryoneWatchingItem extends StatelessWidget {
  const EveryoneWatchingItem({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          DescriptionTextWidget(
            description:
                'Landing the lead in the school musical is a dream come true for Jodi,Untill the pressure sends her confidence--and her relationship into a talspin.',
            title: 'Tall Girl 2',
          ),
          SizedBox(
            height: 25,
          ),
          ImageWithMuteButton(size: size, widthPercet: 1, heightpercent: 0.6),
          kHeight20,
          SizedBox(
            height: 50,
            child: Row(
              children: [
                kWidth,
                Text(
                  'LOST\nIN\nSPACE',
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [Icon(CupertinoIcons.paperplane), Text('Share')],
                ),
                kWidth,
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(CupertinoIcons.add),
                    Text('My List'),
                  ],
                ),
                kWidth,
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [Icon(CupertinoIcons.play), Text('Play')],
                ),
                kWidth,
              ],
            ),
          ),
          kHeight20,
        ],
      ),
    );
  }
}
