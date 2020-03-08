import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_login/theme.dart';
import 'package:flutter_login/widgets.dart';
import 'transition_route_observer.dart';
import 'widgets/fade_in.dart';
import 'constants.dart';
import 'widgets/animated_numeric_text.dart';
import 'widgets/round_button.dart';

import 'widgets/counter.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
  with SingleTickerProviderStateMixin, TransitionRouteAware {

  Future<bool> _goToLogin(BuildContext context) {
    return Navigator.of(context)
        .pushReplacementNamed('/')
        // we dont want to pop the screen, just replace it completely
        .then((_) => false);
  }

  final routeObserver = TransitionRouteObserver<PageRoute>();
  static const headerAniInterval =
      const Interval(.1, .3, curve: Curves.easeOut);
  Animation<double> _headerScaleAnimation;
  AnimationController _loadingController;


  @override
  void initState() {
    super.initState();

    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1250),
    );

    _headerScaleAnimation =
        Tween<double>(begin: .6, end: 1).animate(CurvedAnimation(
      parent: _loadingController,
      curve: headerAniInterval,
    ));
  }


  int n1 = 8;
  int n2 = 8;
  int n3 = 16;
  int n4 = 16;
  int series = 6;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _loadingController.dispose();
    super.dispose();
  }

  @override
  void didPushAfterTransition() => _loadingController.forward();

  AppBar _buildAppBar(ThemeData theme) {
    final menuBtn = IconButton(
      color: theme.accentColor,
      icon: const Icon(FontAwesomeIcons.bars),
      onPressed: () {},
    );
    final signOutBtn = IconButton(
      icon: const Icon(FontAwesomeIcons.signOutAlt),
      color: theme.accentColor,
      onPressed: () => _goToLogin(context),
    );
    final title = Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Hero(
              tag: Constants.logoTag,
              child: Image.asset(
                'assets/images/logo.png',
                filterQuality: FilterQuality.high,
                height: 30,
              ),
            ),
          ),
          HeroText(
            Constants.appName,
            tag: Constants.titleTag,
            viewState: ViewState.shrunk,
            style: LoginThemeHelper.loginTextStyle,
          ),
          SizedBox(width: 20),
        ],
      ),
    );

    return AppBar(
      leading: FadeIn(
        child: menuBtn,
        controller: _loadingController,
        offset: .3,
        //curve: headerAniInterval,
        //fadeDirection: FadeDirection.startToEnd,
      ),
      actions: <Widget>[
        FadeIn(
          child: signOutBtn,
          controller: _loadingController,
          offset: .3,
          //curve: headerAniInterval,
          //fadeDirection: FadeDirection.endToStart,
        ),
      ],
      title: title,
      backgroundColor: theme.primaryColor.withOpacity(.1),
      elevation: 0,
      textTheme: theme.accentTextTheme,
      iconTheme: theme.accentIconTheme,
    );
  }

  Widget _buildButton({Widget icon, String label, Interval interval}) {
    return RoundButton(
      icon: icon,
      label: label,
      loadingController: _loadingController,
      interval: Interval(
        interval.begin,
        interval.end,
        curve: ElasticOutCurve(0.42),
      ),
      onPressed: () {},
    );
  }

  Widget _buildDashboardGrid() {
    const step = 0.04;
    const aniInterval = 0;

    return GridView.count(
      padding: const EdgeInsets.symmetric(
        horizontal: 32.0,
        vertical: 20,
      ),
      childAspectRatio: .9,
      // crossAxisSpacing: 5,
      crossAxisCount: 2,
      children: [
        new Count(
                  count: n1,
                  text: 'Inhale',
                  onCountSelected: () {
                    print("Count was selected.");
                  },
                  onCountChange: (int val) {
                    setState(() => n1 += val);
                  },
        ),
        new Count(
                  count: n2,
                  text: 'Exhale',
                  onCountSelected: () {
                    print("Count was selected.");
                  },
                  onCountChange: (int val) {
                    print("Count was changed.");
                    setState(() => n2 += val);
                  },
        ),
        new Count(
                  count: n3,
                  text: 'Pause',
                  onCountSelected: () {
                    print("Count was selected.");
                  },
                  onCountChange: (int val) {
                    setState(() => n3 += val);
                  },
        ),
        new Count(
                  count: n4,
                  text: 'Pause',
                  onCountSelected: () {
                    print("Count was selected.");
                  },
                  onCountChange: (int val) {
                    setState(() => n4 += val);
                  },
        ),
        new Count(
          count: series,
          text: 'Series',
          onCountSelected: () {
            print("Count was selected.");
          },
          onCountChange: (int val) {
            setState(() => n1 += val);
          },
        ),
        new FloatingActionButton(
          heroTag: null,
          child: new Icon(Icons.play_arrow, color: Colors.black,),
          backgroundColor: Colors.white),        
      ],
    );
  }

  Widget _buildDebugButtons() {
    const textStyle = TextStyle(fontSize: 12, color: Colors.white);

    return Positioned(
      bottom: 0,
      right: 0,
      child: Row(
        children: <Widget>[
          RaisedButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Colors.red,
            child: Text('loading', style: textStyle),
            onPressed: () => _loadingController.value == 0
                ? _loadingController.forward()
                : _loadingController.reverse(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () => _goToLogin(context),
      child: SafeArea(
        child: Scaffold(
          appBar: _buildAppBar(theme),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color: theme.primaryColor.withOpacity(.1),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(height: 40),
                    Expanded(
                      flex: 8,
                      child: ShaderMask(
                        // blendMode: BlendMode.srcOver,
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            tileMode: TileMode.clamp,
                            colors: <Color>[
                              Colors.deepPurpleAccent.shade100,
                              Colors.deepPurple.shade100,
                              Colors.deepPurple.shade100,
                              Colors.deepPurple.shade100,
                              // Colors.red,
                              // Colors.yellow,
                            ],
                          ).createShader(bounds);
                        },
                        child: _buildDashboardGrid(),
                      ),
                    ),                                        
                  ],
                ),
                if (!kReleaseMode) _buildDebugButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
