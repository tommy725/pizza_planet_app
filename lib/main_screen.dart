import 'package:flutter/material.dart';
import 'package:pizza_planet/pages/home.dart';
import 'package:pizza_planet/pages/cart.dart';
import 'package:pizza_planet/pages/login.dart';
import 'package:pizza_planet/pages/orders.dart';
import 'package:pizza_planet/utils.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

var scaffoldKey = GlobalKey<ScaffoldState>();

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final pages =  [
    const Home(),
    const Cart(),
    const Orders(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: primaryBlue,
          centerTitle: true,
          title: const Text(
              'Pizza Planet'
          ),
          actions: [
            IconButton(
                onPressed: () {
                  SharedPref.addBoolToSF("LoggedIn", false);
                  SharedPref.removeValues("phoneNumber");
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
              icon: const Icon(Icons.login_outlined),
            ),
          ]
      ),
      bottomNavigationBar: Container(
        color: primaryRed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 15.0),
          child: GNav(
            backgroundColor: primaryRed,
            color: Colors.black,
            activeColor: primaryBlue,
            tabBackgroundColor: const Color(0xCCFFFFFF),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            gap: 12.0,
            onTabChange: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            tabs: const [
              GButton(
                icon: Icons.home,
                iconSize: 31,
                iconColor: primaryWhite,
                text: 'Home',
              ),
              GButton(
                icon: Icons.shopping_cart,
                iconSize: 31,
                iconColor: primaryWhite,
                text: 'Your Cart',
              ),
              GButton(
                icon: Icons.list_alt_rounded,
                iconSize: 31,
                iconColor: primaryWhite,
                text: 'Orders',
              ),
            ],
          ),
        ),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
    );
  }
}
