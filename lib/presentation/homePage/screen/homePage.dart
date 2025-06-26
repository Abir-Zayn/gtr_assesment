import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gtr_assessment/common/components/app_text.dart';
import 'package:gtr_assessment/presentation/auth/cubit/login_cubit.dart';
import 'package:gtr_assessment/presentation/homePage/components/customer_card.dart';
import 'package:gtr_assessment/presentation/homePage/components/pagination.dart';
import 'package:gtr_assessment/presentation/homePage/cubit/customer_cubit.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentPage = 1;
  final int _pageSize = 15; // Changed to 15 items per page

  @override
  void initState() {
    super.initState();
    // Load initial customer list with token from login state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadInitialData();
    });
  }

  void loadInitialData() {
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

  void loadPage(int pageNumber) {
    final loginState = context.read<LoginCubit>().state;
    if (loginState is LoginSuccess && loginState.user.token != null) {
      setState(() {
        _currentPage = pageNumber;
      });
      context.read<CustomerCubit>().loadCustomerList(
        pageNo: _currentPage,
        pageSize: _pageSize,
        token: loginState.user.token!,
      );
    }
  }

  void retryLoading() {
    final loginState = context.read<LoginCubit>().state;

    if (loginState is LoginSuccess && loginState.user.token != null) {
      _currentPage = 1;
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

  // Find the total numbers of pages based on total count and page size
  int totalPageCount(int totalCount) {
    return (totalCount / _pageSize).ceil();
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
              return AppText(
                text: title,
                textfontsize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              );
            },
          ),
          backgroundColor: Theme.of(context).primaryColor,
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
              // Show snackbar and redirect to login
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please log in to continue'),
                    backgroundColor: Colors.orange,
                    duration: Duration(seconds: 2),
                  ),
                );
                context.go('/login');
              });

              // Return empty container while redirecting
              return const SizedBox.shrink();
            }

            return BlocBuilder<CustomerCubit, CustomerState>(
              builder: (context, state) {
                if (state is CustomerLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CustomerError) {
                  // Show error snackbar
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: ${state.message}'),
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 4),
                        action: SnackBarAction(
                          label: 'Retry',
                          textColor: Colors.white,
                          onPressed: retryLoading,
                        ),
                      ),
                    );
                  });

                  // Return loading indicator while handling error
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CustomerLoaded) {
                  final customers = state.customerList.customers;
                  final totalPages = totalPageCount(
                    state.customerList.totalCount,
                  );
                  //As From API customer list isnt empty
                  //therefore we wont handle the if customer list is empty
                  return Column(
                    children: [
                      // Customer List into the Customer Card
                      Expanded(
                        child: ListView.builder(
                          itemCount: customers.length,
                          itemBuilder: (context, index) {
                            return CustomerCard(customer: customers[index]);
                          },
                        ),
                      ),

                      // Pagination Widget
                      if (totalPages > 1)
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Pagination(
                            currentPage: _currentPage,
                            totalPages: totalPages,
                            onPageChanged: loadPage,
                          ),
                        ),
                    ],
                  );
                } else {
                  return SizedBox();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
