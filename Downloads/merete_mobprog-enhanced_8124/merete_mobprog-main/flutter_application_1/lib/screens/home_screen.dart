import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/data/dummy_data.dart';
import 'package:flutter_application_1/screens/friends_screen.dart';
import 'package:flutter_application_1/screens/newsfeed_screen.dart';
import 'package:flutter_application_1/screens/notifications_screen.dart';
import 'package:flutter_application_1/screens/profile_screen.dart';
import 'package:flutter_application_1/widgets/custom_text.dart';

/// Describes one tab: its title (for the AppBar) and its icons (for the
/// bottom navigation bar).
class _NavTab {
  final String title;
  final IconData icon;
  final IconData activeIcon;

  const _NavTab(this.title, this.icon, this.activeIcon);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  // Enhancement 3: more BottomNavigationBarItems (was Home + Notifications).
  static const List<_NavTab> _tabs = [
    _NavTab(kAppName, Icons.home_outlined, Icons.home),
    _NavTab('Friends', Icons.people_outline, Icons.people),
    _NavTab('Notifications', Icons.notifications_none, Icons.notifications),
    _NavTab('Profile', Icons.person_outline, Icons.person),
  ];
  static const int _notificationsTab = 2;

  // Read notifications. Kept here so the bell badge and the Notifications
  // tab always agree.
  late final Set<String> _readIds = {
    for (final n in notifications)
      if (n.isRead) n.id,
  };

  int get _unreadCount => notifications.length - _readIds.length;

  void _markRead(String id) => setState(() => _readIds.add(id));

  void _markAllRead() {
    setState(() => _readIds.addAll(notifications.map((n) => n.id)));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('All notifications marked as read'),
          duration: Duration(seconds: 1),
        ),
      );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fbBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shadowColor: fbLightPrimary,
        elevation: 2,
        scrolledUnderElevation: 2,
        centerTitle: false,
        title: _buildTitle(),
        actions: _buildActions(),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (page) => setState(() => _selectedIndex = page),
        children: [
          const NewsfeedScreen(),
          const FriendsScreen(),
          NotificationsScreen(readIds: _readIds, onRead: _markRead),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // needed for 4+ items
        backgroundColor: Colors.white,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        onTap: _onTappedBar,
        selectedItemColor: fbPrimary,
        unselectedItemColor: fbTextGrey,
        currentIndex: _selectedIndex,
        items: [
          for (var i = 0; i < _tabs.length; i++)
            BottomNavigationBarItem(
              icon: _withBadge(i, Icon(_tabs[i].icon)),
              activeIcon: _withBadge(i, Icon(_tabs[i].activeIcon)),
              label: i == 0 ? 'Home' : _tabs[i].title,
            ),
        ],
      ),
    );
  }

  /// Enhancement 2: dynamic AppBar title.
  /// Home shows the app's logo text; every other tab shows its own title
  /// (e.g. "Notifications", like in the sample output).
  Widget _buildTitle() {
    final isHome = _selectedIndex == 0;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: CustomText(
        key: ValueKey(_selectedIndex),
        text: isHome ? kAppName.toLowerCase() : _tabs[_selectedIndex].title,
        fontSize: ScreenUtil().setSp(isHome ? 27 : 22),
        color: isHome ? fbPrimary : fbTextDark,
        fontFamily: isHome ? 'Klavika' : null,
        fontWeight: isHome ? FontWeight.w700 : FontWeight.bold,
      ),
    );
  }

  /// The AppBar buttons also change with the tab.
  List<Widget> _buildActions() {
    switch (_selectedIndex) {
      case 0:
        return [_circleAction(Icons.search), _circleAction(Icons.chat_bubble)];
      case _notificationsTab:
        return [
          IconButton(
            tooltip: 'Mark all as read',
            onPressed: _unreadCount == 0 ? null : _markAllRead,
            icon: const Icon(Icons.done_all),
            color: fbPrimary,
          ),
        ];
      case 3:
        return [_circleAction(Icons.settings)];
      default:
        return [_circleAction(Icons.search)];
    }
  }

  Widget _circleAction(IconData icon) {
    return Padding(
      padding: EdgeInsets.only(right: ScreenUtil().setWidth(8)),
      child: CircleAvatar(
        radius: ScreenUtil().setSp(18),
        backgroundColor: fbBackground,
        child: Icon(icon, color: fbTextDark, size: ScreenUtil().setSp(20)),
      ),
    );
  }

  /// Red-dot count on the bell for unread notifications.
  Widget _withBadge(int index, Widget icon) {
    if (index != _notificationsTab || _unreadCount == 0) return icon;
    return Badge(
      label: Text('$_unreadCount'),
      backgroundColor: fbSecondary,
      child: icon,
    );
  }

  void _onTappedBar(int value) {
    setState(() => _selectedIndex = value);
    _pageController.jumpToPage(value);
  }
}
