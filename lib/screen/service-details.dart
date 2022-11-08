import 'package:cached_network_image/cached_network_image.dart';
import 'package:consulting1925/Model/service-page-model.dart';
import 'package:consulting1925/services/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class ServiceDetailsScreen extends StatefulWidget {
  final ServicePageModel servicePageModel;

  ServiceDetailsScreen({this.servicePageModel});

  @override
  _ServiceDetailsScreenState createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  ScrollController _scrollController;
  Color _theme;

  @override
  void initState() {
    _theme = Colors.black;

    _scrollController = ScrollController()
      ..addListener(
        () => _isAppBarExpanded
            ? _theme != Colors.white
                ? setState(
                    () {
                      _theme = Colors.white;
                      print('setState is called');
                    },
                  )
                : {}
            : _theme != Colors.black
                ? setState(() {
                    print('setState is called');
                    _theme = Colors.black;
                  })
                : {},
      );

    super.initState();

    Future.delayed(Duration(seconds: 0), () {
      containerHeight = (MediaQuery.of(context).size.height -
              imageContainerKey.currentContext.size.height) +
          ResponsiveFlutter.of(context).scale(80.0);
      setState(() {});
    });
  }

  bool get _isAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  final imageContainerKey = GlobalKey();
  double containerHeight = 800;

  @override
  Widget build(BuildContext context) {
    Color itemColor = _isAppBarExpanded ? themeColorYellow : Colors.transparent;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: containerHeight,
            child: CachedNetworkImage(
              imageUrl: widget.servicePageModel.image_url,
              imageBuilder: (context, imageProvider) => Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            /* decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImage(
                  imageUrl: widget.servicePageModel.small_icon_white,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover, scale: 3),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                fit: BoxFit.cover,
              ),
            ),*/
          ),
          CustomScrollView(
            controller: _scrollController,
            primary: false,
            physics: ClampingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                elevation: 0.0,
                forceElevated: false,
                backgroundColor: itemColor,
                pinned: true,
                centerTitle: true,
                collapsedHeight: AppBar().preferredSize.height,
                expandedHeight: 200,
                floating: true,
                leading: IconButton(
                  icon: Image.asset(
                    "assets/images/back_ic.png",
                    height: 25,
                    width: 25,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                iconTheme: IconThemeData(color: Colors.white),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  centerTitle: true,
                  title: Text(
                    !_isAppBarExpanded ? '' : widget.servicePageModel.title,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                  background: Container(),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SingleChildScrollView(
                    primary: true,
                    physics: NeverScrollableScrollPhysics(),
                    child: Container(
                      key: imageContainerKey,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 30.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(
                                        ResponsiveFlutter.of(context)
                                            .scale(50.0)),
                                    topLeft: Radius.circular(
                                        ResponsiveFlutter.of(context)
                                            .scale(50.0)))),
                            padding: EdgeInsets.symmetric(
                              horizontal: ResponsiveFlutter.of(context).wp(8.0),
                              vertical: ResponsiveFlutter.of(context).hp(5.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    widget.servicePageModel.title.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 20.00),
                                  child: Text(
                                    widget.servicePageModel.description
                                        .toString()
                                        .replaceAll("\\n", "\n"),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: ResponsiveFlutter.of(context).hp(2.0)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: CachedNetworkImage(
                                    placeholder: (context, url) => Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/logo-selected.png'),
                                            scale: 0.9),
                                      ),
                                    ),
                                    imageUrl: widget
                                        .servicePageModel.small_icon_white,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                            scale: 3),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
