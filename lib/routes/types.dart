enum route_types { home, products, favorites, auth }

const Map<route_types, String> RoutePaths = {
  route_types.home: '/',
  route_types.auth: '/auth',
  route_types.products: '/products',
  route_types.favorites: '/favorites'
};
