library mapbox_autocomplete_search_widget;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'custom_widgets/search_app_bar_widget.dart';
import 'models/place.dart';
import 'providers/app_providers.dart';
import 'utils/app_constants.dart';

class MapboxAutocompleteSearchWidget extends ConsumerWidget {
  final _placeNameTextController = TextEditingController();
  final Function onPlaceSelected;
  final String hintText;
  final String mapboxApiKey;
  final Color appBarColor;
  final Color infoButtonColor;
  final Color backButtonColor;
  final Color clearButtonColor;
  final Color cursorColor;
  final Color searchTextColor;
  Timer _timer;

  MapboxAutocompleteSearchWidget({
    @required this.onPlaceSelected,
    @required this.mapboxApiKey,
    this.hintText = 'Search Place',
    this.appBarColor = Colors.grey,
    this.backButtonColor = Colors.white,
    this.infoButtonColor = Colors.white,
    this.clearButtonColor = Colors.white,
    this.cursorColor = Colors.white,
    this.searchTextColor = Colors.white,
  });

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _appStateProvider = watch(appStateProvider).state;

    return Scaffold(
      body: Container(
        color: Colors.blueGrey[50],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SearchAppBarWidget(
              searchTextDidChange: _searchTextDidChange,
              onValueSubmitted: _onValueSubmitted,
              placeNameTextController: _placeNameTextController,
              hintText: hintText,
              appBarColor: appBarColor,
              infoButtonColor: infoButtonColor,
              backButtonColor: backButtonColor,
              clearButtonColor: clearButtonColor,
              cursorColor: cursorColor,
              searchTextColor: searchTextColor,
            ),
            _getWidgetForAppState(context: context, appState: _appStateProvider)
          ],
        ),
      ),
    );
  }

  Widget _getWidgetForAppState({BuildContext context, AppState appState}) {
    switch (appState) {
      case AppState.loadingState:
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0,
          ),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
        break;
      case AppState.loadedState:
        final _placesListProvider = context.read(placesListProvider);
        final _placesList = _placesListProvider.state;
        if (_placesList.isEmpty) {
          return Center(
            child: Text('No places found for your search query.'),
          );
        } else {
          return Expanded(
            child: ListView(
              padding: EdgeInsets.only(
                top: 10.0,
                left: 10.0,
                right: 10.0,
              ),
              children: _placesList
                  .map(
                    (_place) => _buildPlaceSearchCardWidget(
                      context: context,
                      place: _place,
                    ),
                  )
                  .toList(),
            ),
          );
        }
        break;
      case AppState.defaultState:
        return Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            child: Center(
                child: Image.asset(
              'images/mapbox_logo.png',
              package: 'mapbox_autocomplete_search_widget',
              fit: BoxFit.contain,
              width: 120,
              height: 50,
            )));
        break;
      default:
        return Center(child: Text('Error'));
    }
  }

  Widget _buildPlaceSearchCardWidget({BuildContext context, Place place}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: ListTile(
          leading: Icon(Icons.location_pin),
          title: Text(
            '${place.placeName}',
          ),
          onTap: () {
            onPlaceSelected(context, place);
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  void _searchForQuery(BuildContext context, String value) async {
    if (value.length > 2) {
      final _queryProvider = context.read(queryProvider);
      _queryProvider.state = value;

      if (_timer != null) {
        _timer.cancel();
        _timer = null;
      }
      _timer = Timer(Duration(seconds: 1), () {
        _fetchPlaces(context);
      });
    }
  }

  void _fetchPlaces(BuildContext context) {
    final _apiKey = context.read(apiKeyProvider);
    _apiKey.state = mapboxApiKey;

    final _appStateProvier = context.read(appStateProvider);
    _appStateProvier.state = AppState.loadingState;

    context.read(placesFetchProvider).then((_places) {
      final _placesListProvider = context.read(placesListProvider);
      _placesListProvider.state = _places;

      _appStateProvier.state = AppState.loadedState;
    });
  }

  //TextField search methods
  void _searchTextDidChange(BuildContext context, String value) {
    _searchForQuery(context, value);
  }

  void _onValueSubmitted(BuildContext context, String value) {
    _searchForQuery(context, value);
  }
}
