# mapbox_autocomplete_search_widget

Language: [English](README.md)

- [mapbox_autocomplete_search_widget](#mapbox_autocomplete_search_widget)
- [How to use it.](#how-to-use-it)
- [parameters](#parameters)

## mapbox_autocomplete_search_widget
MapboxAutocompleteSearchWidget is a flutter package that allows you to search for place name in a autocomplete fashion. 

Technical Notes:
The search is carried out only when search text length is greater than 2 and also a delay of 1 second is added before placing a server call. (Since user types continuously, unnessarry calls will be made to server. So we make the call with 1 second delay after user has stopped typing.)

The package uses Riverpod for state management. So Please ensure you import flutter_riverpod and wrap the app with ProviderScope.

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
```

To use this Package, Please get the Access-Token from here https://docs.mapbox.com/help/glossary/access-token/

The Package has necessarry attributions to Mapbox and can doesnot violate mapbox ![Terms and Conditions](https://www.mapbox.com/legal/tos/).

![](https://github.com/TeaTalkInternal/github_assets/blob/master/gifs/place_autocomplete.gif)


##  How to use it.

the usage is very simple, just use the following

```dart
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
```

```dart
  MapboxAutocompleteSearchWidget(
      onPlaceSelected: (BuildContext context, Place place) {
        
      },
      mapboxApiKey: 'mapboxApiKey',
    ),
```

## parameters

| parameter                  | description                                                                           | value                                                                                                                                                                               |
| -------------------------- | ------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| onPlaceSelected                       | Completion Handler which returns a BuildContext and selected place from picker                                                                  |     (BuildContext context, Place place) {}                                                                                                                                                                              |
| mapboxApiKey          | Your Mapbox ApiKey (Auth-Token)                                            | ApiKey Value                                                                                                                                                    |
| appBarColor          | Color of App Bar widget                                           | This is a optional parameter                                                                                                                                                    |
| backButtonColor          | Color of back arrow button                                            | This is a optional parameter                                                                                                                                                    |
| infoButtonColor          | Color of mapbox info button                                            | This is a optional parameter                                                                                                                                                    |
| clearButtonColor          | Color of clear button in Search widget                                            | This is a optional parameter                                                                                                                                                    |
| cursorColor          | Color of cursor in Search widget                                            | This is a optional parameter                                                                                                                                                    |
| searchTextColor          | Color of Text in Search widget                                            | This is a optional parameter                                                                                                                                                    |
| searchBackgroundColor          | Color of Search area background                                            | This is a optional parameter                                                                                                                                                    |

[git repo here](https://github.com/TeaTalkInternal/mapbox_autocomplete_search_widget)

Made with ❤ and dedicated with respect to the Saviour  [Sonu Sood](https://twitter.com/SonuSood)