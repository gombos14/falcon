import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'auth.dart';
import 'data.dart';
import 'data/repository.dart';
import 'screens/assistant.dart';
import 'screens/furniture_details.dart';
import 'screens/main.dart';
import 'screens/order_details.dart';
import 'screens/orders.dart';
import 'screens/scaffold.dart';
import 'screens/settings.dart';
import 'screens/sign_in.dart';
import 'widgets/fade_transition_page.dart';
import 'widgets/furniture_list.dart';

final appShellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'app shell');
final booksNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'books shell');

class Falconstore extends StatefulWidget {
  const Falconstore({super.key});

  @override
  State<Falconstore> createState() => _FalconstoreState();
}

class _FalconstoreState extends State<Falconstore> {
  final FalconAuth auth = FalconAuth();
  FurnitureRepository furnitureRepository = FurnitureRepository();
  OrderRepository orderRepository = OrderRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: (context, child) {
        if (child == null) {
          throw ('No child in .router constructor builder');
        }
        return FalconAuthScope(
          notifier: auth,
          child: child,
        );
      },
      routerConfig: GoRouter(
        refreshListenable: auth,
        debugLogDiagnostics: true,
        initialLocation: '/settings',
        redirect: (context, state) {
          final signedIn = FalconAuth.of(context).signedIn;
          if (state.uri.toString() != '/sign-in' && !signedIn) {
            return '/sign-in';
          }
          return null;
        },
        routes: [
          ShellRoute(
            navigatorKey: appShellNavigatorKey,
            builder: (context, state, child) {
              return FalconScaffold(
                selectedIndex: switch (state.uri.path) {
                  var p when p.startsWith('/home') => 0,
                  var p when p.startsWith('/assistant') => 1,
                  var p when p.startsWith('/orders') => 2,
                  var p when p.startsWith('/settings') => 3,
                  _ => 0,
                },
                child: child,
              );
            },
            routes: [
              ShellRoute(
                pageBuilder: (context, state, child) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    child: Builder(builder: (context) {
                      return MainScreen(
                        onTap: (idx) {
                          GoRouter.of(context).go(switch (idx) {
                            0 => '/home/popular',
                            1 => '/home/new',
                            2 => '/home/all',
                            _ => '/home/popular',
                          });
                        },
                        selectedIndex: switch (state.uri.path) {
                          var p when p.startsWith('/home/popular') => 0,
                          var p when p.startsWith('/home/new') => 1,
                          var p when p.startsWith('/home/all') => 2,
                          _ => 0,
                        },
                        child: child,
                      );
                    }),
                  );
                },
                routes: [
                  GoRoute(
                    path: '/home/popular',
                    pageBuilder: (context, state) {
                      return FadeTransitionPage<dynamic>(
                        key: state.pageKey,
                        child: Builder(
                          builder: (context) {
                            return FurnitureList(
                              furniture: furnitureRepository.getAllFurniture(),
                              onTap: (furniture) {
                                GoRouter.of(context)
                                    .go('/home/popular/furniture/${furniture.id}');
                              },
                            );
                          },
                        ),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'furniture/:furnitureId',
                        parentNavigatorKey: appShellNavigatorKey,
                        builder: (context, state) {
                          return FurnitureDetailsScreen(
                            furniture: furnitureRepository
                                .getFurniture(state.pathParameters['furnitureId'] ?? ''),
                          );
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    path: '/home/new',
                    pageBuilder: (context, state) {
                      return FadeTransitionPage<dynamic>(
                        key: state.pageKey,
                        child: Builder(
                          builder: (context) {
                            return FurnitureList(
                              furniture: furnitureRepository.getAllFurniture(),
                              onTap: (book) {
                                GoRouter.of(context)
                                    .go('/home/new/book/${book.id}');
                              },
                            );
                          },
                        ),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'home/:bookId',
                        parentNavigatorKey: appShellNavigatorKey,
                        builder: (context, state) {
                          return FurnitureDetailsScreen(
                            furniture: furnitureRepository
                                .getFurniture(state.pathParameters['furnitureId'] ?? ''),
                          );
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    path: '/home/all',
                    pageBuilder: (context, state) {
                      return FadeTransitionPage<dynamic>(
                        key: state.pageKey,
                        child: Builder(
                          builder: (context) {
                            return FurnitureList(
                              furniture: furnitureRepository.getAllFurniture(),
                              onTap: (furniture) {
                                GoRouter.of(context)
                                    .go('/home/${furniture.id}');
                              },
                            );
                          },
                        ),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'home/:furnitureId',
                        parentNavigatorKey: appShellNavigatorKey,
                        builder: (context, state) {
                          return FurnitureDetailsScreen(
                            furniture: furnitureRepository
                                .getFurniture(state.pathParameters['furniture'] ?? ''),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              GoRoute(
                path: '/assistant',
                builder: (context, state) {
                  return Builder(
                    builder: (context) {
                      return AssistantScreen();
                    },
                  );
                },
              ),
              GoRoute(
                path: '/orders',
                pageBuilder: (context, state) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    child: Builder(builder: (context) {
                      Future<List<Order>> orders = orderRepository.getAllOrders(FalconAuth.of(context).getUserId);
                      return OrdersScreen(
                        ordersFuture: orders,
                        onTap: (order) {
                          GoRouter.of(context)
                              .go('/orders/order/${order.id}');
                        },
                      );
                    }),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'order/:orderId',
                    builder: (context, state) {
                      return Builder(builder: (context) {
                        return OrderDetailsScreen(
                          order: orderRepository.getOrder(state.pathParameters['orderId']!),
                        );
                      });
                    },
                  )
                ],
              ),
              GoRoute(
                path: '/settings',
                pageBuilder: (context, state) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    child: const SettingsScreen(),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: '/sign-in',
            builder: (context, state) {
              return Builder(
                builder: (context) {
                  return SignInScreen(
                    onSignIn: (value) async {
                      final router = GoRouter.of(context);
                      await FalconAuth.of(context)
                          .signIn(context, value.username, value.password);
                      router.go('/home/popular');
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
