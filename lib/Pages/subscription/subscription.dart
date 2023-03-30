import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:provider/provider.dart';
import 'package:sanad/model/packagesmodel.dart';
import 'package:sanad/pages/paypalPage/paypalScreen.dart';
import 'package:sanad/pages/wallet.dart';
import 'package:sanad/provider/apiprovider.dart';
import 'package:sanad/utils/sharepref.dart';
import 'package:sanad/utils/utility.dart';

import '../../Cubit/app_cubit.dart';
import '../../theme/color.dart';
import '../../widget/myappbar.dart';
import '../../widget/mytext.dart';
import 'consumable_store.dart';

final bool _kAutoConsume = Platform.isIOS || true;

class Subscription extends StatefulWidget {
  const Subscription({Key? key}) : super(key: key);

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  String? userId;
  SharePref sharePref = SharePref();
  List<Result>? packagelist;
  late int selectIndex;

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  final List<ProductDetails> _products = <ProductDetails>[];
  final List<String> _kProductIds = <String>[];
  final List<PurchaseDetails> _purchases = <PurchaseDetails>[];
  List<String> _consumables = <String>[];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String? _queryProductError;

  @override
  void initState() {
    getUserId();
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object error) {
      // handle error here.
    });
    initStoreInfo();
    super.initState();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }

    final ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        log("===> ${productDetailResponse.error!.message}");
        _queryProductError = productDetailResponse.error!.message;
        _isAvailable = isAvailable;

        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        log("===> ${productDetailResponse.productDetails}");
        _queryProductError = null;
        _isAvailable = isAvailable;
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    final List<String> consumables = await ConsumableStore.load();
    setState(() {
      _isAvailable = isAvailable;
      log("===> 2 ${productDetailResponse.productDetails}");
      _purchasePending = false;
      _loading = false;
    });
  }

  getUserId() async {
    userId = await sharePref.read('userId') ?? "0";
    debugPrint('userID===>${userId.toString()}');

    final packageProvider = Provider.of<ApiProvider>(context, listen: false);
    packageProvider.getPackage(context, userId);
  }

  @override
  void dispose() {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final packageProvider = Provider.of<ApiProvider>(context);
    if (packageProvider.loading) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: appBgColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(children: [
              Container(
                height: 260,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/dash_bg.png"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(50.0, 50.0)),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MyAppbar(title: "Subscription"),
                  Center(
                    child: SizedBox(
                      height: 180,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset(
                          "assets/images/ic_subscription.png",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
              ],
            )
          ],
        ),
      );
    } else {
      if (packageProvider.packagesModel.status == 200 &&
          (packageProvider.packagesModel.result?.length ?? 0) > 0) {
        packagelist = packageProvider.packagesModel.result;
        log("===>package ${packagelist?.length}");
        return BlocConsumer<AppCubit, AppStateCubit>(
          listener: (context, state) {
            if (state is PayPalSuccessState) {
              Utility.navigateTo(context,
                  widget: PaypalScreen(
                      paypalLink: AppCubit.get(context).paymentLink!));
            }
          },
          builder: (context, state) {
            var cubit = AppCubit.get(context);
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: appBgColor,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(children: [
                    Container(
                      height: 260,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/dash_bg.png"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.elliptical(50.0, 50.0)),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const MyAppbar(title: "Subscription"),
                        Center(
                          child: SizedBox(
                            height: 180,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Image.asset(
                                "assets/images/ic_subscription.png",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
                  Expanded(
                    child: ListView.builder(
                      itemCount: packagelist?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            await cubit.getPayPalLink(
                                userId: int.parse(userId!),
                                planSubscriptionId: packagelist![index].id!,
                                transactionAmount:
                                    int.parse(packagelist![index].price!),
                                coin: int.parse(packagelist![index].coin!));
                            selectIndex = index;
                            _kProductIds.clear();
                            log('===> ${packagelist?[index].productPackage}');
                            _kProductIds
                                .add(packagelist?[index].productPackage ?? "");
                            log("===> ${_kProductIds.length}");
                            // purchaseItem();
                            // if (state is PayPalSuccessState) {
                            //   Future.delayed(const Duration(seconds: 2), () {
                            //     Utility.navigateTo(context,
                            //         widget: PaypalScreen(
                            //             paypalLink: cubit.paymentLink!));
                            //   });
                            // }

                            // addPurchase();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, top: 8, right: 20, bottom: 8),
                            child: Container(
                              height: 130,
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/ic_packagebg.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 5),
                                  MyText(
                                    title: (packageProvider.packagesModel
                                                .result?[index].coin ??
                                            "") +
                                        " Coins",
                                    size: 20,
                                    fontWeight: FontWeight.w500,
                                    colors: white,
                                  ),
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    child: MyText(
                                      title: (packageProvider.packagesModel
                                              .result?[index].name ??
                                          ""),
                                      size: 24,
                                      fontWeight: FontWeight.w500,
                                      colors: white,
                                      maxline: 2,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Spacer(),
                                      MyText(
                                        title: "Select Plan ->",
                                        size: 18,
                                        fontWeight: FontWeight.w600,
                                        colors: sharebg,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          },
        );
      } else {
        return Container();
      }
    }
  }

  purchaseItem() async {
    final ProductDetailsResponse response =
        await InAppPurchase.instance.queryProductDetails(_kProductIds.toSet());
    // if (response.notFoundIDs.isNotEmpty) {
    //   Utility.toastMessage("Please check SKU");
    //   return;
    // }
    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: response.productDetails[0]);
    InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          log("===> status ${purchaseDetails.status}");
          final bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            deliverProduct(purchaseDetails);
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }
        if (Platform.isAndroid) {
          if (!_kAutoConsume &&
              purchaseDetails.productID ==
                  packagelist?[selectIndex].productPackage) {
            final InAppPurchaseAndroidPlatformAddition androidAddition =
                _inAppPurchase.getPlatformAddition<
                    InAppPurchaseAndroidPlatformAddition>();
            await androidAddition.consumePurchase(purchaseDetails);
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          log("===> pendingCompletePurchase ${purchaseDetails.pendingCompletePurchase}");
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    log("===> productID ${purchaseDetails.productID}");
    if (purchaseDetails.productID == packagelist?[selectIndex].productPackage) {
      await ConsumableStore.save(purchaseDetails.purchaseID!);
      final List<String> consumables = await ConsumableStore.load();
      log("===> consumables ${consumables}");
      addPurchase();
      setState(() {
        _purchasePending = false;
        _consumables = consumables;
      });
    } else {
      log("===> consumables else ${purchaseDetails}");
      setState(() {
        _purchases.add(purchaseDetails);
        _purchasePending = false;
      });
    }
  }

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    log("===> invalid Purchase ${purchaseDetails}");
  }

  addPurchase() async {
    final provider = Provider.of<ApiProvider>(context, listen: false);
    await provider.getaddTranscation(
        userId.toString(),
        packagelist?[selectIndex].id.toString() ?? "",
        packagelist?[selectIndex].price.toString() ?? "",
        packagelist?[selectIndex].coin.toString() ?? "");
    debugPrint('===>get responce${provider.successModel.status}');
    if (provider.loading) {
      const CircularProgressIndicator();
    } else {
      if (provider.successModel.status == 200) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Wallet()));
      }
    }
  }
}

class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
