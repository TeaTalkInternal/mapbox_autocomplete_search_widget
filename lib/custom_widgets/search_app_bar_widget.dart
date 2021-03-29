import 'package:flutter/material.dart';
import 'package:mapbox_autocomplete_search_widget/utils/url_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchAppBarWidget extends StatefulWidget {
  const SearchAppBarWidget({
    Key key,
    @required Function searchTextDidChange,
    @required Function onValueSubmitted,
    @required TextEditingController placeNameTextController,
    @required String hintText,
    Color appBarColor = Colors.grey,
    Color backButtonColor = Colors.white,
    Color infoButtonColor = Colors.white,
    Color clearButtonColor = Colors.white,
    Color cursorColor = Colors.white,
    Color searchTextColor = Colors.white,
  })  : _searchTextDidChange = searchTextDidChange,
        _onValueSubmitted = onValueSubmitted,
        _hintText = hintText,
        _placeNameTextController = placeNameTextController,
        _appBarColor = appBarColor,
        _infoButtonColor = infoButtonColor,
        _backButtonColor = backButtonColor,
        _clearButtonColor = clearButtonColor,
        _cursorColor = cursorColor,
        _searchTextColor = searchTextColor,
        super(key: key);

  final TextEditingController _placeNameTextController;
  final Function _searchTextDidChange;
  final Function _onValueSubmitted;
  final String _hintText;
  final Color _appBarColor;
  final Color _infoButtonColor;
  final Color _backButtonColor;
  final Color _clearButtonColor;
  final Color _cursorColor;
  final Color _searchTextColor;

  @override
  _SearchAppBarWidgetState createState() => _SearchAppBarWidgetState();
}

class _SearchAppBarWidgetState extends State<SearchAppBarWidget> {
  bool _showClearButton = false;
  @override
  void initState() {
    super.initState();
    _showClearButton = widget._placeNameTextController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final _appbarHeight = MediaQuery.of(context).size.height * 0.12;
    final _searchTextStyle = TextStyle(color: widget._searchTextColor);
    return Container(
      height: _appbarHeight,
      color: widget._appBarColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: widget._backButtonColor,
          ),
          Flexible(
            child: TextField(
              controller: widget._placeNameTextController,
              autofocus: true,
              style: _searchTextStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget._hintText,
                labelStyle: _searchTextStyle,
                hintStyle: _searchTextStyle,
                suffixIcon: _showClearButton
                    ? IconButton(
                        iconSize: 20.0,
                        color: widget._clearButtonColor,
                        onPressed: () {
                          setState(() {
                            widget._placeNameTextController.clear();
                            _showClearButton = false;
                          });
                        },
                        icon: Icon(Icons.clear_rounded),
                      )
                    : null,
              ),
              cursorColor: widget._cursorColor,
              onChanged: (value) {
                setState(() {
                  _showClearButton =
                      widget._placeNameTextController.text.isNotEmpty;
                });
                widget._searchTextDidChange(context, value);
              },
              onSubmitted: (value) => widget._onValueSubmitted(context, value),
            ),
          ),
          IconButton(
            icon: Icon(Icons.info_rounded),
            onPressed: () {
              //show Mapbox Attributions here
              launch(URLConstants.mapBoxAttributionURL);
            },
            color: widget._infoButtonColor,
          ),
        ],
      ),
    );
  }
}
