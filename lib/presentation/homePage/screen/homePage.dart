import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gtr_assessment/presentation/auth/cubit/login_cubit.dart';
import 'package:gtr_assessment/presentation/homePage/components/customer_card.dart';
import 'package:gtr_assessment/presentation/homePage/cubit/customer_cubit.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 1;
  final int _pageSize = 20;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // Load initial customer list with token from login state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });
  }

  void _loadInitialData() {
    final loginState = context.read<LoginCubit>().state;
    if (loginState is LoginSuccess && loginState.user.token != null) {
      context.read<CustomerCubit>().loadCustomerList(
        pageNo: _currentPage,
        pageSize: _pageSize,
        token: loginState.user.token!,
      );
    } else {
      // If no valid token, redirect to login
      context.go('/login');
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final customerState = context.read<CustomerCubit>().state;
      final loginState = context.read<LoginCubit>().state;

      if (customerState is CustomerLoaded &&
          customerState.customerList.hasNextPage &&
          loginState is LoginSuccess &&
          loginState.user.token != null) {
        _currentPage++;
        context.read<CustomerCubit>().loadCustomerList(
          searchQuery: _searchQuery,
          pageNo: _currentPage,
          pageSize: _pageSize,
          token: loginState.user.token!,
        );
      }
    }
  }

  void _performSearch() {
    final loginState = context.read<LoginCubit>().state;

    if (loginState is LoginSuccess && loginState.user.token != null) {
      _searchQuery = _searchController.text.trim();
      _currentPage = 1;
      context.read<CustomerCubit>().loadCustomerList(
        searchQuery: _searchQuery,
        pageNo: _currentPage,
        pageSize: _pageSize,
        token: loginState.user.token!,
      );
    } else {
      // If no valid token, redirect to login
      context.go('/login');
    }
  }

  void _retryLoad() {
    final loginState = context.read<LoginCubit>().state;

    if (loginState is LoginSuccess && loginState.user.token != null) {
      _currentPage = 1;
      context.read<CustomerCubit>().loadCustomerList(
        searchQuery: _searchQuery,
        pageNo: _currentPage,
        pageSize: _pageSize,
        token: loginState.user.token!,
      );
    } else {
      // If no valid token, redirect to login
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, loginState) {
        // If user is logged out or login state changes, redirect to login
        if (loginState is! LoginSuccess) {
          context.go('/login');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, loginState) {
              String title = 'Customer List';
              if (loginState is LoginSuccess) {
                title = 'Welcome, ${loginState.user.name}';
              }
              return Text(title);
            },
          ),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () {
                context.read<LoginCubit>().resetState();
                context.read<CustomerCubit>().resetState();
                context.go('/login');
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, loginState) {
            // Check if user is properly logged in
            if (loginState is! LoginSuccess || loginState.user.token == null) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.login, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'Please log in to continue',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                // Search Bar
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search customers...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          onSubmitted: (_) => _performSearch(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: _performSearch,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        child: const Text('Search'),
                      ),
                    ],
                  ),
                ),

                // Customer List
                Expanded(
                  child: BlocBuilder<CustomerCubit, CustomerState>(
                    builder: (context, state) {
                      if (state is CustomerLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is CustomerError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 64,
                                color: Colors.red[300],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Error: ${state.message}',
                                style: const TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: _retryLoad,
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      } else if (state is CustomerLoaded) {
                        final customers = state.customerList.customers;

                        if (customers.isEmpty) {
                          return const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.people_outline,
                                  size: 64,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'No customers found',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return ListView.builder(
                          controller: _scrollController,
                          itemCount:
                              customers.length +
                              (state.customerList.hasNextPage ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == customers.length) {
                              // Loading indicator for pagination
                              return const Padding(
                                padding: EdgeInsets.all(16),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            return CustomerCard(customer: customers[index]);
                          },
                        );
                      } else {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.refresh,
                                size: 64,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Pull to refresh or search for customers.',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: _loadInitialData,
                                child: const Text('Load Customers'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
