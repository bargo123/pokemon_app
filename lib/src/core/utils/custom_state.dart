import 'package:flutter/widgets.dart';

import 'mixins.dart';

abstract class CustomState<T extends StatefulWidget, B extends Object> extends State
    with Screen<B>, WidgetsBindingObserver, AutomaticKeepAliveClientMixin {
  void onResume() {}
  void onStart();
  void onPause() {}
  void onStop() {}

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => onStart());
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      onPause();
    } else if (state == AppLifecycleState.resumed) {
      onResume();
    }
  }
}
