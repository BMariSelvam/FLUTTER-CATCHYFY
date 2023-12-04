import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import '../Const/assets.dart';

Widget webImage(
    {required String imageUrl,
    String placeholderImage = Assets.logo,
    double width = double.infinity,
    double height = double.infinity,
    BoxFit fit = BoxFit.fill}) {
  return imageUrl.isNotEmpty
      ? CachedNetworkImage(
          placeholder: (context, url) => Image.asset(
            placeholderImage,
            fit: fit,
            width: width,
            height: height,
          ),
          errorWidget: (context, url, il) => Image.asset(
            placeholderImage,
            fit: fit,
            width: width,
            height: height,
          ),
          imageUrl: imageUrl,
          fit: fit,
          width: width,
          height: height,
        )
      : Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            placeholderImage,
            fit: fit,
            width: width,
            height: height,
          ),
        );
}
