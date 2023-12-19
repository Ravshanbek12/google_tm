import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:productive/constants/colors.dart';
import 'package:productive/constants/icons.dart';
import 'package:productive/constants/routes.dart';
import 'package:productive/features/create_tasks/presentation/create_screen.dart';
import 'package:productive/features/tasks/home/navbar.dart';
import 'navigator.dart';
import 'widgets/nav_bar_item.dart';

enum NavItemEnum { tasks, expenses, create, calendar, stats }

class HomeScreen extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute<void>(builder: (_) => const HomeScreen());

  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _controller;
  late double navBarWidth;

  late AnimationController controller;
  final Map<NavItemEnum, GlobalKey<NavigatorState>> _navigatorKeys = {
    NavItemEnum.tasks: GlobalKey<NavigatorState>(),
    NavItemEnum.expenses: GlobalKey<NavigatorState>(),
    NavItemEnum.create: GlobalKey<NavigatorState>(),
    NavItemEnum.calendar: GlobalKey<NavigatorState>(),
    NavItemEnum.stats: GlobalKey<NavigatorState>(),
  };

  List<NavBar> labels = [];

  int _currentIndex = 0;
  int currentPage = 0;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    _controller = TabController(length: 5, vsync: this);
    controller.addListener(() {});
    _controller.addListener(onTabChange);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onTabChange() {
    setState(() => _currentIndex = _controller.index);
  }

  Widget _buildPageNavigator(NavItemEnum tabItem) => TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      );

  void changePage(int index) {
    setState(() => _currentIndex = index);
    _controller.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    labels = const [
      NavBar(id: 0, icon: AppIcons.tasks, title: "Tasks"),
      NavBar(id: 1, icon: AppIcons.expense, title: "Expense"),
      NavBar(id: 2, icon: AppIcons.create, title: "Create"),
      NavBar(id: 3, icon: AppIcons.calendar, title: "Calendar"),
      NavBar(id: 4, icon: AppIcons.stats, title: "Stats"),
    ];
    List<String> icons = [
      AppIcons.income,
      AppIcons.expense,
      AppIcons.tasks,
      AppIcons.notes,
      AppIcons.event,
      AppIcons.close
    ];
    List<String> titles = ["Income", "Expense", "Tasks", "Notes", "Event", ""];
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: white,
      ),
      child: HomeTabControllerProvider(
        controller: _controller,
        child: WillPopScope(
          onWillPop: () async {
            final isFirstRouteInCurrentTab =
                !await _navigatorKeys[NavItemEnum.values[_currentIndex]]!
                    .currentState!
                    .maybePop();
            if (isFirstRouteInCurrentTab) {
              if (NavItemEnum.values[_currentIndex] != NavItemEnum.tasks) {
                changePage(0);
                return false;
              }
            }
            return isFirstRouteInCurrentTab;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            bottomNavigationBar: Container(
              height: 75 + MediaQuery.of(context).padding.bottom,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: navigationBarBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff1F211C).withOpacity(0.08),
                    blurRadius: 30,
                    offset: const Offset(0, -4),
                  )
                ],
              ),
              child: TabBar(
                enableFeedback: true,
                indicator: const BoxDecoration(),
                controller: _controller,
                labelPadding: EdgeInsets.zero,
                tabs: [
                  TabItemWidget(
                    onActiveTap: () {
                      _navigatorKeys[NavItemEnum.values[_currentIndex]]
                          ?.currentState
                          ?.popUntil((route) => route.isFirst);
                    },
                    isActive: _currentIndex == 0,
                    item: labels[0],
                  ),
                  TabItemWidget(
                    onActiveTap: () {
                      _navigatorKeys[NavItemEnum.values[_currentIndex]]
                          ?.currentState
                          ?.popUntil((route) => route.isFirst);
                    },
                    isActive: _currentIndex == 1,
                    item: labels[1],
                  ),
                  TabItemWidget(
                    onActiveTap: () {
                      showModalBottomSheet<void>(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          int index = -1;
                          int l = 4;
                          return SizedBox(
                              height: double.maxFinite,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 43,vertical: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                    children: List.generate(3, (k) {
                                  l--;
                                  return l != 1
                                      ? Padding(
                                    padding: EdgeInsets.symmetric(vertical: 36),
                                        child: Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: List.generate(l, (i) {
                                            index++;
                                            return GestureDetector(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTaskScreen()));
                                              },
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(12),
                                                    width: 45,
                                                    height: 45,
                                                    decoration: BoxDecoration(
                                                      color: cleaning,
                                                      borderRadius:
                                                          BorderRadius.circular(50),
                                                    ),
                                                    child: SvgPicture.asset(
                                                        icons[index]),
                                                  ),
                                                  Gap(8),
                                                  Text(
                                                    titles[index],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                            color: Colors.white),
                                                  )
                                                ],
                                              ),
                                            );
                                          })),
                                      )
                                      : GestureDetector(
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                        child: SvgPicture.asset(
                                            icons[5],
                                          ),
                                      );
                                })),
                              ));
                        },
                      );
                    },
                    isActive: _currentIndex == 2,
                    item: labels[2],
                  ),
                  TabItemWidget(
                    onActiveTap: () {
                      _navigatorKeys[NavItemEnum.values[_currentIndex]]
                          ?.currentState
                          ?.popUntil((route) => route.isFirst);
                    },
                    isActive: _currentIndex == 3,
                    item: labels[3],
                  ),
                  TabItemWidget(
                    onActiveTap: () {
                      _navigatorKeys[NavItemEnum.values[_currentIndex]]
                          ?.currentState
                          ?.popUntil((route) => route.isFirst);
                    },
                    isActive: _currentIndex == 4,
                    item: labels[4],
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildPageNavigator(NavItemEnum.tasks),
                _buildPageNavigator(NavItemEnum.expenses),
                _buildPageNavigator(NavItemEnum.create),
                _buildPageNavigator(NavItemEnum.calendar),
                _buildPageNavigator(NavItemEnum.stats),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeTabControllerProvider extends InheritedWidget {
  const HomeTabControllerProvider({
    required Widget child,
    required this.controller,
    Key? key,
  }) : super(key: key, child: child);

  final TabController controller;

  @override
  bool updateShouldNotify(HomeTabControllerProvider oldWidget) => false;

  static HomeTabControllerProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<HomeTabControllerProvider>()!;
}
