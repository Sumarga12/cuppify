import 'package:ecommerce/app/shared_prefs/token_shared_prefs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../data/models/add_cart_request.dart';
import '../../data/models/cart_request.dart';
import '../../data/models/update_cart_request.dart';
import '../../domain/entities/cart.dart';
import '../../domain/entities/cart_items.dart';
import '../../domain/usecases/add_cart.dart';
import '../../domain/usecases/fetch_cart.dart';
import '../../domain/usecases/update_cart.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final TokenSharedPrefs tokenSharedPrefs;
  final FetchCart fetchCart;
  final AddCart addCart;
  final UpdateCart updateCart;

  CartCubit(
      this.tokenSharedPrefs,
    this.addCart,
    this.fetchCart,
    this.updateCart,
  ) : super(CartLoading());

  Future<void> getCart() async {
    final id = await tokenSharedPrefs.getUserId();
    print('Fetching cart for userId: $id');  // Debugging
    if (id == null) {
      emit(CartError('User not logged in'));
      return;
    }

    final res = await fetchCart(CartRequest(userId: id));
    res.fold(
          (l) {
        print('Fetch Cart Error: ${l.message}'); // Debugging
        emit(CartError(l.message));
      },
          (r) {
        print('Cart Fetched Successfully'); // Debugging
        emit(CartLoaded(r.cart, r.cartItems));
      },
    );
  }



  Future<void> addNewCart(String cartId) async {
    EasyLoading.show(status: 'Adding to cart');

    final userId = await tokenSharedPrefs.getUserId();

    if (userId == null) {
      emit(CartError('User not logged in'));
      EasyLoading.dismiss();
      return;
    }

    final res = await addCart(AddCartRequest(
      userId: userId, // Pass the userId
      item: cartId,
      quantity: 1,
    ));

    res.fold(
          (l) => emit(CartError(l.message)),
          (r) => getCart(),
    );

    EasyLoading.dismiss();
  }

  Future<void> addToCart(String itemId) async {
    EasyLoading.show(status: 'Adding to cart');

    final userId = await tokenSharedPrefs.getUserId();
    if (userId == null) {
      emit(CartError('User not logged in'));
      EasyLoading.dismiss();
      return;
    }

    final res = await addCart(AddCartRequest(
      userId: userId, // Pass the userId
      item: itemId,
      quantity: 1,
    ));

    res.fold(
          (l) => emit(CartError(l.message)),
          (r) => getCart(),
    );

    EasyLoading.dismiss();
  }




  Future<void> removeFromCart(String cartId) async {
    if (state is! CartLoaded) return;

    EasyLoading.show(status: 'Removing from cart');
    final userId = await tokenSharedPrefs.getUserId();
    final res = await updateCart(UpdateCartRequest(userId: userId ?? '', cartitem: cartId, quantity: -1));

    res.fold(
      (l) => emit(CartError(l.message)),
      (r) => getCart(),
    );
    EasyLoading.dismiss();
  }

  Future<void> removeAll(BuildContext context, String cartId) async {
    if (state is! CartLoaded) return;

    final toRemoveAll = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remove all from cart'),
        content: Text('Are you sure you want to remove all from cart?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('No', style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Yes', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (toRemoveAll == null || !toRemoveAll) return;

    final currentState = state as CartLoaded;
    EasyLoading.show(status: 'Removing cart');
    final userId = await tokenSharedPrefs.getUserId();
    final cartItem = currentState.cartItems.firstWhere((element) => element.id == cartId);
    final res = await updateCart(UpdateCartRequest(userId: userId ?? '', cartitem: cartItem.id, quantity: -1 * cartItem.quantity));

    res.fold(
      (l) => emit(CartError(l.message)),
      (r) => getCart(),
    );

    EasyLoading.dismiss();
  }
}
