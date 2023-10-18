import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentz_app_challenge/domain/location_entity.dart';
import 'package:mentz_app_challenge/presentation/app_theme.dart';
import 'package:mentz_app_challenge/presentation/bloc/home_screen_bloc.dart';
import 'package:mentz_app_challenge/presentation/bloc/home_screen_event.dart';
import 'package:mentz_app_challenge/presentation/bloc/home_screen_state.dart';

import 'location_card_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    context.read<HomeScreenBloc>().add(InitEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppTheme.colorScheme.onPrimary,
        title: Text(
          widget.title,
          style: AppTheme.textTheme.headlineLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
            builder: (context, itineraryState) {
          if (itineraryState.status == SearchStatus.initial) {
            editingController.clear();
          } else if (itineraryState.chosenLocation != null &&
              itineraryState.status == SearchStatus.success) {
            editingController.clear();
          }
          return Container(
            color: AppTheme.colorScheme.background,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                  child: TextField(
                    onChanged: (value) {
                      if (value == "") {
                        context
                            .read<HomeScreenBloc>()
                            .add(SearchEvent(searchText: value.toString()));
                      }
                    },
                    onSubmitted: (value) {
                      context
                          .read<HomeScreenBloc>()
                          .add(SearchEvent(searchText: value.toString()));
                    },
                    style: AppTheme.textTheme.bodySmall,
                    controller: editingController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 17.0),
                        filled: true,
                        fillColor: AppTheme.colorScheme.primaryContainer,
                        labelText: "Enter location",
                        hintText: "Enter location",
                        labelStyle: AppTheme.textTheme.bodySmall,
                        prefixIcon: const Icon(Icons.search),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)))),
                  ),
                ),
                if (itineraryState.status == SearchStatus.initial) ...[
                  _startSearch(),
                ] else if (itineraryState.status == SearchStatus.success ||
                    itineraryState.status == SearchStatus.search) ...[
                  if (editingController.text != "") ...[
                    _searchResults(context, itineraryState),
                  ] else if (itineraryState.chosenLocation != null) ...[
                    _hasChosenLocation(itineraryState.chosenLocation!),
                  ] else ...[
                    _startSearch(),
                  ]
                ],
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _startSearch() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 100.h,
        ),
        Image.asset(
          'assets/icons/location_3.png',
          width: 200.w,
          height: 200.h,
        ),
        SizedBox(height: 20.h),
        Text("Find a perfect starting point",
            style: AppTheme.textTheme.bodyLarge),
        Text("for your journey now", style: AppTheme.textTheme.bodyLarge),
      ],
    );
  }

  Widget _hasChosenLocation(LocationEntity item) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          Text("Your chosen starting point:",
              style: AppTheme.textTheme.titleMedium),
          SizedBox(height: 20.h),
          SizedBox(
            height: 120.h,
            width: 320.w,
            child: LocationContainer(
              item: item,
              liked: true,
            ),
          ),
          SizedBox(height: 40.h),
        ]);
  }

  Widget _searchResults(BuildContext context, HomeScreenState itineraryState) {
    if (itineraryState.result.isEmpty) {
      return _noResults();
    } else {
      itineraryState.result.sort((a, b) => b.matchQuality.compareTo(a.matchQuality));
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: itineraryState.result.length,
          itemBuilder: (context, index) {
            return LocationCardWidget(
              location: itineraryState.result[index],
              chosenLocation: itineraryState.chosenLocation,
            );
          },
        ),
      );
    }
  }

  Widget _noResults() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 100.h,
        ),
        Image.asset(
          'assets/icons/sad_2.png',
          width: 180.w,
          height: 180.h,
        ),
        SizedBox(height: 20.h),
        Text("What a pity!", style: AppTheme.textTheme.bodyLarge),
        Text("No suitable results were found",
            style: AppTheme.textTheme.bodyLarge),
      ],
    );
  }
}
