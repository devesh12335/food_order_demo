import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_orders/presentation/screens/cart/bloc.dart';
import 'package:food_orders/presentation/screens/cart/events.dart';
import 'package:food_orders/presentation/screens/cart/state.dart';
import 'package:food_orders/services/mock_data/fake_food_items.dart';
import 'package:mocktail/mocktail.dart';


import 'package:food_orders/global_state/globalState.dart';
import 'package:food_orders/models/cart_model.dart';
import 'package:food_orders/models/food_list_model.dart';
import 'package:food_orders/presentation/screens/checkout/view.dart';


class MockGlobalState extends Mock implements GlobalState {}
class MockNavigatorObserver extends Mock implements NavigatorObserver {}
class MockBuildContext extends Mock implements BuildContext {}

   final foodItem1 =  FoodItem.fromJson(fake_food_items['data'][1]);
   final foodItem2 =   FoodItem.fromJson(fake_food_items['data'][2]);
   final cartItem1 = CartModel(Quntity: 1, item: foodItem1);
   final cartItem2 = CartModel(Quntity: 1, item: foodItem2);
void main() {
  late CartBloc cartBloc;
  late MockGlobalState mockGlobalState;
  late MockNavigatorObserver mockObserver;
  // late FoodItem foodItem1;
  // late FoodItem foodItem2;
  // late CartModel cartItem1;
  // late CartModel cartItem2;
  
  setUpAll(() {
    registerFallbackValue(
        MaterialPageRoute(builder: (context) => CheckoutScreen(subtotalPrice: 0.0)));
    registerFallbackValue( CartInitEvent()); 
  });

  setUp(() {
    mockGlobalState = MockGlobalState();
    GlobalState.instance = mockGlobalState; 
    mockObserver = MockNavigatorObserver();
    cartBloc = CartBloc();
  });

  tearDown(() {
    cartBloc.close();
  });

  test('initial state is CartState.initial()', () {
    expect(cartBloc.state, equals(CartState.initial()));
  });


  group('CartInitEvent', () {
    final mockFoodList = [foodItem1, foodItem2];
    
    blocTest<CartBloc, CartState>(
      'emits [loading, loaded] with correct cart items and total price when initialized',
      setUp: () {
        when(() => mockGlobalState.CartItemList).thenReturn(mockFoodList);
      },
      build: () => cartBloc,
      act: (bloc) => bloc.add( CartInitEvent()),
      expect: () => [
         CartState(status: CartStatus.loading),
        CartState(
          status: CartStatus.loaded,
          cartItems: [cartItem1, cartItem2],
          totalPrice: 0.0,
        ),
        CartState(
          status: CartStatus.loaded,
          cartItems: [cartItem1, cartItem2],
          totalPrice: 100.0, // 1*10.0 + 1*5.0 = 15.0
        ),
      ],
      verify: (_) {
        
        verify(() => mockGlobalState.CartItemList).called(1);
      },
    );
    
    blocTest<CartBloc, CartState>(
      'emits [loading, error] when initialization fails',
      setUp: () {
       
        when(() => mockGlobalState.CartItemList).thenThrow(Exception('Init Error'));
      },
      build: () => cartBloc,
      act: (bloc) => bloc.add( CartInitEvent()),
      expect: () => [
         CartState(status: CartStatus.loading),
         CartState(status: CartStatus.error, error: 'Exception: Init Error'),
      ],
    );
  });



  group('increaseQtyEvent', () {
    final initialState = CartState(
      cartItems: [cartItem1, cartItem2], // Qty: 1, 1. Total: 15.0
      totalPrice: 160.0,
      status: CartStatus.loaded,
    );
    
    final expectedCartItems = [
      CartModel(Quntity: 2, item: foodItem1), // Qty: 2
      cartItem2,
    ];

    blocTest<CartBloc, CartState>(
      'increases quantity of an item and updates total price',
      build: () => cartBloc,
      seed: () => initialState,
      act: (bloc) => bloc.add(increaseQtyEvent(item: cartItem1)),
      // Expect the state with updated quantity, followed by the state with updated total price
      expect: () => [
        initialState.copyWith(
          cartItems: expectedCartItems,
          totalPrice: 160.0, // Total price is still 15.0 before the second event
        ),
        initialState.copyWith(
          cartItems: expectedCartItems,
          totalPrice: 140.0, // (2*10.0) + (1*5.0) = 25.0
        ),
      ],
    );
  });
  


  group('decreaseQtyEvent', () {
    final initialCartItem1 = CartModel(Quntity: 2, item: foodItem1);
    final initialState = CartState(
      cartItems: [initialCartItem1, cartItem2], // Qty: 2, 1. Total: 25.0
      totalPrice: 280.0,
      status: CartStatus.loaded,
    );
    
    final expectedCartItems = [
      CartModel(Quntity: 1, item: foodItem1), // Qty: 1
      cartItem2,
    ];

    blocTest<CartBloc, CartState>(
      'decreases quantity of an item and updates total price',
      build: () => cartBloc,
      seed: () => initialState,
      act: (bloc) => bloc.add(decreaseQtyEvent(item: initialCartItem1)),
      expect: () => [
        initialState.copyWith(
          cartItems: expectedCartItems,
          totalPrice: 280.0, // Before updateTotalPriceEvent runs
        ),
        initialState.copyWith(
          cartItems: expectedCartItems,
          totalPrice: 100.0, // (1*10.0) + (1*5.0) = 15.0
        ),
      ],
    );
  });

  
  group('updateTotalPriceEvent', () {
    final cartItems = [
      CartModel(Quntity: 3, item: foodItem1), 
      CartModel(Quntity: 2, item: foodItem2), 
    ];
    const expectedTotal = 240.0; 
    
    blocTest<CartBloc, CartState>(
      'calculates and updates the total price correctly',
      build: () => cartBloc,
      seed: () => CartState(
        cartItems: cartItems, 
        totalPrice: 0.0,
        status: CartStatus.loaded,
      ),
      act: (bloc) => bloc.add(updateTotalPriceEvent()),
      expect: () => [
        CartState(
          cartItems: cartItems,
          totalPrice: expectedTotal,
          status: CartStatus.loaded,
        ),
      ],
    );
  });


}