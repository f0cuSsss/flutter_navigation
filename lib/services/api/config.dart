enum APIs { data, photos }

enum DATA_ENDPOINT_TYPES {
  post,
  posts,
}

extension URLsExtension on APIs {
  String get url {
    switch (this) {
      case APIs.data:
        return 'https://jsonplaceholder.typicode.com/';
      case APIs.photos:
        return 'https://api.unsplash.com/';
    }
  }

  String get authority {
    switch (this) {
      case APIs.data:
        return 'jsonplaceholder.typicode.com';
      case APIs.photos:
        return 'api.unsplash.com';
    }
  }

  Map<dynamic, String> get endpoints {
    switch (this) {
      case APIs.data:
        Map<DATA_ENDPOINT_TYPES, String> endpointsMap =
            Map<DATA_ENDPOINT_TYPES, String>();
        endpointsMap[DATA_ENDPOINT_TYPES.post] = 'post/';
        endpointsMap[DATA_ENDPOINT_TYPES.posts] = 'posts';
        return endpointsMap;
      case APIs.photos:
        return null;
    }
  }
}
