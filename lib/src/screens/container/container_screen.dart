import 'package:flutter/material.dart';
import 'package:pokedex/locator.dart';
import 'package:pokedex/src/core/constants/color_constants.dart';
import 'package:pokedex/src/core/utils/custom_state.dart';
import 'package:pokedex/src/screens/container/container_bloc.dart';
import 'package:pokedex/src/screens/favourites/favourites_screen.dart';

import '../../core/utils/custom_textstyle.dart';
import '../all_pokemons/all_pokemon_screen.dart';

class ContainerScreen extends StatefulWidget {
  const ContainerScreen({Key? key}) : super(key: key);

  @override
  CustomState<ContainerScreen, ContainerBloc> createState() => _ContainerScreenState();
}

class _ContainerScreenState extends CustomState<ContainerScreen, ContainerBloc> with TickerProviderStateMixin {
  List<Widget> tabBarViews = [
    const AllPokemonScreen(),
    const FavouritesScreen(),
  ];
  TabController? _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/pokeball_ic.png", scale: 2.5),
            const SizedBox(
              width: 8,
            ),
            Text("Pokédex",
                style: locator<CustomTextStyle>()
                    .notoSansFont(color: ColorConstants.color_0xff161A33, fontSize: 28, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 2,
          ),
          Container(
            height: 60,
            color: ColorConstants.color_0xffFFFFFF,
            child: TabBar(
              controller: _tabController,
              tabs: [
                const Tab(
                  text: "All Pokémons",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Tab(text: "Favourites"),
                    StreamBuilder<int>(
                        initialData: bloc.counter,
                        stream: bloc.counterController.stream,
                        builder: (context, snapshot) {
                          return snapshot.data! > 0
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    backgroundColor: ColorConstants.color_0xff3558CD,
                                    radius: 12,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: FittedBox(child: Text("${snapshot.data}")),
                                    ),
                                  ),
                                )
                              : Container();
                        })
                  ],
                ),
              ],
            ),
          ),
          Expanded(child: TabBarView(controller: _tabController, children: tabBarViews)),
        ],
      ),
    );
  }

  @override
  void onStart() {
    bloc.startSubscription();
  }

  @override
  bool get wantKeepAlive => true;
}
