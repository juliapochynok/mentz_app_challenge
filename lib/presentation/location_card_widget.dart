import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentz_app_challenge/domain/location_entity.dart';
import 'dart:convert' show utf8;

import 'package:mentz_app_challenge/presentation/app_theme.dart';
import 'package:mentz_app_challenge/presentation/bloc/home_screen_event.dart';

import 'bloc/home_screen_bloc.dart';

class CardsColorScheme {
  Color poi = const Color(0xFFD9C2AE);
  Color stop = const Color(0xFFD3ACBA);
  Color locality = const Color(0xFFB5D3B5);
  Color street = const Color(0xFFACC9D5);
  Color other = const Color(0xFFABB7D9);

  Color typeToColor(String type) {
    switch (type.toLowerCase()) {
      case "poi":
        return poi;
      case "stop":
        return stop;
      case "locality":
        return locality;
      case "street":
        return street;
      default:
        return other;
    }
  }
}

class LocationCardWidget extends StatelessWidget {
  final LocationEntity location;
  final LocationEntity? chosenLocation;

  const LocationCardWidget({
    super.key,
    required this.location,
    required this.chosenLocation,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: Card(
        elevation: 2,
        child: LocationContainer(
          item: location,
          liked: chosenLocation != null
              ? chosenLocation?.id.toLowerCase() == location.id.toLowerCase()
              : false,
        ),
      ),
    );
  }
}

class LocationContainer extends StatelessWidget {
  final LocationEntity item;
  final bool? liked;

  const LocationContainer({
    Key? key,
    required this.item,
    required this.liked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.colorScheme.primaryContainer,
        gradient: LinearGradient(
          colors: [
            AppTheme.colorScheme.onSecondary,
            AppTheme.colorScheme.onTertiary,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 1.0],
        ),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(1, 3),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding:
            EdgeInsets.only(left: 12.w, right: 12.w, top: 12.h, bottom: 4.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 12.w,
            ),
            Expanded(
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _locationName(item),
                          if (item.streetName != "") ...[
                            _cityText(context),
                          ] else ...[
                            SizedBox(height: 10.h),
                          ],
                          SizedBox(height: 5.h),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    _types(context, item),
                                  ],
                                ),
                              ]),
                        ],
                      ),
                    ),
                    _likeButton(context, item),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _locationName(LocationEntity item) {
    return Flexible(
      child: RichText(
        overflow: TextOverflow.ellipsis,
        strutStyle: const StrutStyle(fontSize: 12.0),
        text: TextSpan(
          text: utf8.decode(item.disassembledName.codeUnits),
          style: AppTheme.textTheme.titleMedium,
        ),
      ),
    );
  }

  Widget _cityText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Text(
        utf8.decode(item.streetName.codeUnits),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              overflow: TextOverflow.ellipsis,
            ),
      ),
    );
  }

  Widget _likeButton(BuildContext context, LocationEntity item) {
    IconData likeIcon;
    if (liked != null && liked!) {
      likeIcon = Icons.check_circle;
    } else {
      likeIcon = Icons.circle_outlined;
    }
    return IconButton(
      icon: Icon(
        likeIcon,
        color: AppTheme.colorScheme.tertiary,
        size: 24.h,
      ),
      onPressed: () {
        if (liked != null && liked!) {
          context.read<HomeScreenBloc>().add(UnlikeEvent(item: item));
        } else {
          context.read<HomeScreenBloc>().add(LikeEvent(item: item));
        }
      },
    );
  }

  Widget _types(BuildContext context, LocationEntity item) {
    return Row(
      children: [
        _typeContainer(context, item.type ?? ""),
        if (item.subType != "") ...[
          SizedBox(width: 8.w),
          _typeContainer(context, item.subType),
        ]
      ],
    );
  }

  Widget _typeContainer(BuildContext context, String type) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.colorScheme.primaryContainer,
        border: Border.all(
          color: CardsColorScheme().typeToColor(type),
          width: 4.0,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Text(
          type,
          style: AppTheme.textTheme.labelSmall,
        ),
      ),
    );
  }
}
