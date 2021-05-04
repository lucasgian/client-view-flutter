import 'package:client_view_flutter/design_order/design_order_app_theme.dart';
import 'package:client_view_flutter/design_order/models/category.dart';
import 'package:client_view_flutter/design_order/models/order.dart';
import 'package:client_view_flutter/design_order/repository/order_repository.dart';
import 'package:client_view_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';


class PopularOrderListView extends StatefulWidget {
  const PopularOrderListView({Key key, this.callBack}) : super(key: key);

  final Function callBack;
  @override
  _PopularOrderListViewState createState() => _PopularOrderListViewState();
}

class _PopularOrderListViewState extends State<PopularOrderListView>
    with TickerProviderStateMixin {
  AnimationController animationController;
  Future<List> orders;
  final LocalStorage storage = new LocalStorage('all');

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<List> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: FutureBuilder<List>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return GridView(
              padding: const EdgeInsets.all(8),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: List<Widget>.generate(
                snapshot.data.length,
                (int index) {
                  final int count = snapshot.data.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: Interval((1 / count) * index, 1.0,
                          curve: Curves.fastOutSlowIn),
                    ),
                  );
                  animationController.forward();
                  return CategoryView(
                    callback: () {
                      widget.callBack();
                      storage.setItem('id_order', snapshot.data[index].id);
                    },
                    order: snapshot.data[index],
                    category: Category.categoryList[index],
                    animation: animation,
                    animationController: animationController,
                  );
                },
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 32.0,
                crossAxisSpacing: 32.0,
                childAspectRatio: 1,
              ),
            );
          }
        },
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView(
      {Key key,
      this.order,
      this.category,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback callback;
  final Category category;
  final Order order;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                callback();
                
              },
              child: SizedBox(
                height: 280,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: HexColor('#F8FAFB'),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                                // border: new Border.all(
                                //     color: DesignOrderAppTheme.notWhite),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 16, left: 16, right: 16),
                                            child: Text(
                                              order.description,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                letterSpacing: 0.27,
                                                color: DesignOrderAppTheme
                                                    .darkerText,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8,
                                                left: 16,
                                                right: 16,
                                                bottom: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'RS: ${order.price}',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 12,
                                                    letterSpacing: 0.27,
                                                    color: DesignOrderAppTheme
                                                        .grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 48,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 48,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 24, right: 16, left: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: DesignOrderAppTheme.grey
                                      .withOpacity(0.2),
                                  offset: const Offset(0.0, 0.0),
                                  blurRadius: 6.0),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
                            child: AspectRatio(
                                aspectRatio: 1.28,
                                child: Image.network(order.imgThumbnail)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
