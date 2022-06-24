import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../models/review.dart';
import '../../resources/color_manager.dart';

class ReviewWidget extends StatelessWidget {
  ReviewModel review;
  ReviewWidget({required this.review, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // pushNewScreen(
        //   context,
        //   screen: OrderDetails(
        //     role: role,
        //     order: order,
        //   ),
        //   withNavBar: false,
        //   pageTransitionAnimation: PageTransitionAnimation.fade,
        // );
      },
      child: Card(
        elevation: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RatingBar(
                  initialRating: double.parse(review.star!),
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  ignoreGestures: true,
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                      full: const Icon(Icons.star, color: Colors.orange),
                      half: const Icon(
                        Icons.star_half,
                        color: Colors.orange,
                      ),
                      empty: const Icon(
                        Icons.star_outline,
                        color: Colors.orange,
                      )),
                  onRatingUpdate: (value) {}),
              const SizedBox(height: 10),
              Text(
                review.desc!,
              ),
              const SizedBox(height: 10),
              Text(
                "Diulas pada " + review.date!,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
