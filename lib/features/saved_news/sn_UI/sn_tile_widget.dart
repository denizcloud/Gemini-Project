import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:news_app_empty/features/news_button_model/news_button_model.dart';
import 'package:news_app_empty/features/saved_news/bloc/saved_news_bloc.dart';

class NewsTileWidget extends StatelessWidget {
  final NewsDataModel newsDataModel;
  final SavedNewsBloc snBloc;
  const NewsTileWidget(
      {super.key, required this.newsDataModel, required this.snBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(newsDataModel.imageUrl))),
          ),
          const SizedBox(height: 20),
          Text(newsDataModel.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(newsDataModel.description),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("\$" + newsDataModel.genre.toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        // homeBloc.add(HomeProductWishlistButtonClickedEvent(
                        //     clickedProduct: productDataModel));
                      },
                      icon: Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        snBloc.add(SNRemoveFromSNEvent(
                            newsDataModel: newsDataModel));
                      },
                      icon: Icon(Icons.shopping_bag)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
