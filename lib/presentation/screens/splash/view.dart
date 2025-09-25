import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_orders/presentation/resources/router/route_manager.dart';

import 'bloc.dart';
import 'events.dart';
import 'state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc()..add(SplashInitEvent()),
      child: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state) {
          if(state.status == SplashStatus.loaded){
            Future.delayed(Duration(seconds: 3),(){
              Navigator.pushNamedAndRemoveUntil(context, Routes.homePage, (_)=>false);
            });
          }
          // handle navigation or snackbars
        },
        builder: (context, state) {
          switch (state.status) {
            case SplashStatus.initial:
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            case SplashStatus.loaded:
              return SplashLoadedPage();
            case SplashStatus.error:
              return Scaffold(
                body: Center(
                  child: Text(state.error ?? "An error occurred"),
                ),
              );
            default:
              return const Scaffold(
                body: Center(child: Text("Unknown state")),
              );
          }
        },
      ),
    );
  }
}

class SplashLoadedPage extends StatelessWidget {
  const SplashLoadedPage({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
         
          Image.network(
            'https://images.unsplash.com/photo-1484980972926-edee96e0960d?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            fit: BoxFit.cover,
          ),

         
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(255, 255, 0, 0.6), 
                  Color.fromRGBO(107, 9, 187, 0.4), 
                  Color.fromRGBO(16, 221, 211, 0.2), 
                ],
                stops: [0.0, 0.7, 1.0],
              ),
            ),
          ),

          
           Positioned(
            top: 150,right: MediaQuery.of(context).size.width*0.3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Logo
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.transparent,
                    child: Image.asset("assets/app_logo.png"),
                  ),
                ),

                
                Text(
                  'Foodies',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black54,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 50,
            right: MediaQuery.of(context).size.width*0.3,
            child: Text(
                  'Welcome to Foodies\n By Devesh Kharade',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black54,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),)
        ],
      ),
    );
  }
}
