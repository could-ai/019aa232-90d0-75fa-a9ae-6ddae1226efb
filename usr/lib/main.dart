import 'package:flutter/material.dart';

// --- MAIN APPLICATION START ---

void main() {
  runApp(const ShadeCutApp());
}

// Global Color Scheme - Modern Black and Teal
const Color kPrimaryColor = Color(0xFF00ADB5); // Bright Teal
const Color kBackgroundColor = Color(0xFF1F2124); // Dark Gray/Black
const Color kCardColor = Color(0xFF2E3136); // Slightly lighter card background
const Color kAccentColor = Color(0xFFFFFFFF); // White for text/icons
const Color kErrorColor = Color(0xFFF44336);

class ShadeCutApp extends StatelessWidget {
  const ShadeCutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShadeCut',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBackgroundColor,
        cardColor: kCardColor,
        // Global Text Theme
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: kAccentColor),
          bodyMedium: TextStyle(color: kAccentColor),
          titleLarge: TextStyle(color: kAccentColor, fontWeight: FontWeight.bold),
          // Used for button and tool labels
          labelLarge: TextStyle(color: kAccentColor, fontSize: 12),
        ),
        // Global AppBar Theme
        appBarTheme: const AppBarTheme(
          backgroundColor: kBackgroundColor,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: kAccentColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        // Global Icon Theme
        iconTheme: const IconThemeData(color: kAccentColor),
        // BottomNavigationBar Theme
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: kCardColor,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: Color(0xFF888888), // Lighter gray
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
        // Button Theme for Teal accents
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: kBackgroundColor,
            backgroundColor: kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        // Card Theme
        cardTheme: CardTheme(
          color: kCardColor,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 2,
        ),
        // Floating Action Button
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: kPrimaryColor,
          foregroundColor: kBackgroundColor,
        )
      ),
      home: const MainScaffold(),
    );
  }
}

// --- MAIN WIDGET SCAFFOLD (Bottom Navigation) ---

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const TemplatesScreen(),
    // The main edit button navigates to a dedicated screen
    // We keep a placeholder here to match the BottomNav
    const PlaceholderScreen(title: 'Edit Project'),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      // Simulate tapping the 'Edit' center button to start a new project
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const EditorScreen()),
      );
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex == 2 ? 0 : _selectedIndex), // Display Home if index is 2 (Edit)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onItemTapped(2), // Center FAB for 'New Project'
        tooltip: 'New Project',
        heroTag: 'new_project_fab',
        child: const Icon(Icons.add, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: kCardColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildNavItem(0, 'Home', Icons.home_rounded),
            _buildNavItem(1, 'Templates', Icons.auto_awesome_mosaic_rounded),
            const SizedBox(width: 40), // Spacer for FAB
            _buildNavItem(3, 'Export', Icons.cloud_upload_rounded), // Export/Projects tab placeholder
            _buildNavItem(4, 'Profile', Icons.person_rounded),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String label, IconData icon) {
    // Logic to handle the 'Edit' center button which is the FAB (index 2)
    // We remap the bottom nav items (3 and 4) to actual indices 2 and 3 for the internal list
    int actualIndex = index > 2 ? index - 1 : index;

    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(index),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                icon,
                color: _selectedIndex == actualIndex && index != 2
                    ? kPrimaryColor
                    : const Color(0xFF888888),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: _selectedIndex == actualIndex && index != 2
                      ? kPrimaryColor
                      : const Color(0xFF888888),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- PLACEHOLDER SCREENS ---

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          '$title Content Area\n(Feature implementation would go here)',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, color: Color(0xFF888888)),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulate user login state (essential for the cloud backend requirement)
    bool isLoggedIn = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ShadeCut'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            onPressed: () => print('Settings tapped'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // User/Login Status Card
            Card(
              child: ListTile(
                leading: Icon(isLoggedIn ? Icons.cloud_done : Icons.cloud_off, color: isLoggedIn ? kPrimaryColor : kErrorColor),
                title: Text(isLoggedIn ? 'Welcome Back!' : 'Sign In Required'),
                subtitle: Text(isLoggedIn ? 'Projects saved to cloud.' : 'Tap to log in and sync projects.'),
                trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF888888)),
                onTap: () => print('Login/Profile tapped'),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Recent Projects', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            // Placeholder Grid for Recent Projects
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return ProjectCard(index: index);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final int index;
  const ProjectCard({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.2),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
              ),
              child: Center(
                child: Icon(
                  Icons.movie_creation_rounded,
                  size: 50,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Project $index',
              style: const TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
            child: Text(
              '${10 + index} clips, 01:2${index} min',
              style: TextStyle(fontSize: 12, color: kAccentColor.withOpacity(0.6)),
            ),
          ),
        ],
      ),
    );
  }
}

class TemplatesScreen extends StatelessWidget {
  const TemplatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Templates')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 5,
        itemBuilder: (context, index) {
          return TemplateItem(index: index);
        },
      ),
    );
  }
}

class TemplateItem extends StatelessWidget {
  final int index;
  const TemplateItem({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.3),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star_half_rounded,
                    size: 60,
                    color: kPrimaryColor,
                  ),
                  Text(
                    'Template ${index + 1}: Beat Sync',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Dynamic Transition Pack', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('Uses 5 clips. Apply now!', style: TextStyle(fontSize: 12, color: kAccentColor.withOpacity(0.7))),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => print('Apply Template ${index + 1}'),
                  child: const Text('Use Template'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile & Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          // Profile Header
          ListTile(
            leading: const CircleAvatar(
              radius: 30,
              backgroundColor: kPrimaryColor,
              child: Icon(Icons.camera_alt_rounded, color: kBackgroundColor),
            ),
            title: const Text('User ShadeCut'),
            subtitle: Text('ID: ${'user_48a27d1b'}\nCloud Storage: 80% Full', style: TextStyle(color: kAccentColor.withOpacity(0.7))),
            trailing: const Icon(Icons.edit_rounded, color: kPrimaryColor),
          ),
          const Divider(height: 30, color: kCardColor),
          _buildSettingsTile(
            title: 'Cloud Projects',
            icon: Icons.cloud_queue_rounded,
            onTap: () => print('Cloud Project Management'),
          ),
          _buildSettingsTile(
            title: '4K Export Subscription',
            subtitle: 'Active. Next renewal in 30 days.',
            icon: Icons.diamond_rounded,
            color: kPrimaryColor,
            onTap: () => print('Subscription Management'),
          ),
          _buildSettingsTile(
            title: 'AI Enhancements',
            subtitle: 'AI Face Enhance, Voiceover AI, Script-to-Video settings.',
            icon: Icons.auto_fix_high_rounded,
            onTap: () => print('AI Settings'),
          ),
          _buildSettingsTile(
            title: 'Logout',
            icon: Icons.logout_rounded,
            color: kErrorColor,
            onTap: () => print('Logging out...'),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({required String title, String? subtitle, required IconData icon, Color color = kAccentColor, required VoidCallback onTap}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: TextStyle(color: color)),
        subtitle: subtitle != null ? Text(subtitle, style: TextStyle(color: kAccentColor.withOpacity(0.7))) : null,
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF888888)),
        onTap: onTap,
      ),
    );
  }
}


// --- MAIN VIDEO EDITOR SCREEN (UX Showcase) ---

class EditorScreen extends StatelessWidget {
  const EditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('New Project'),
        centerTitle: true,
        actions: [
          // 4K Export Button
          ElevatedButton.icon(
            onPressed: () => print('Starting 4K Export Process...'),
            icon: const Icon(Icons.file_download_rounded, size: 18),
            label: const Text('EXPORT', style: TextStyle(fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              backgroundColor: kPrimaryColor,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: const Column(
        children: [
          // 1. Video Player Area (Preview)
          Expanded(flex: 3, child: VideoPlayerPreview()),

          // 2. Editing Tools Toolbar
          EditingToolbar(),

          // 3. Timeline Editor Area (Multi-Layer)
          Expanded(flex: 2, child: TimelineEditor()),
        ],
      ),
    );
  }
}

class VideoPlayerPreview extends StatelessWidget {
  const VideoPlayerPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black, // Standard video player background
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.videocam_rounded, size: 80, color: Color(0xFF888888)),
            const SizedBox(height: 10),
            Text(
              'Video Preview Area\n(Timeline Position: 00:00:01:23)',
              textAlign: TextAlign.center,
              style: TextStyle(color: kAccentColor.withOpacity(0.7)),
            ),
          ],
        ),
      ),
    );
  }
}

class EditingToolbar extends StatelessWidget {
  const EditingToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tools = [
      {'icon': Icons.cut_rounded, 'label': 'Split'},
      {'icon': Icons.filter_center_focus_rounded, 'label': 'Filter'},
      {'icon': Icons.swap_horiz_rounded, 'label': 'Transition'},
      {'icon': Icons.closed_caption_rounded, 'label': 'AI Captions'},
      {'icon': Icons.palette_rounded, 'label': 'Adjust'},
      {'icon': Icons.slow_motion_video_rounded, 'label': 'Velocity'},
      {'icon': Icons.face_retouching_natural_rounded, 'label': 'AI Enhance'},
      {'icon': Icons.vpn_key_rounded, 'label': 'Keyframes'},
      {'icon': Icons.music_note_rounded, 'label': 'Beat Sync'},
      {'icon': Icons.screen_share_rounded, 'label': 'Green Screen'},
      {'icon': Icons.mic_rounded, 'label': 'Voiceover AI'},
    ];

    return Container(
      height: 80,
      color: kCardColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tools.length,
        itemBuilder: (context, index) {
          final tool = tools[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ToolButton(
              icon: tool['icon'] as IconData,
              label: tool['label'] as String,
              onTap: () => print('Tapped ${tool['label']}'),
            ),
          );
        },
      ),
    );
  }
}

class ToolButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ToolButton({required this.icon, required this.label, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: kPrimaryColor, size: 28),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 10, color: kAccentColor)),
          ],
        ),
      ),
    );
  }
}

class TimelineEditor extends StatelessWidget {
  const TimelineEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: Column(
        children: [
          // Timeline Scroll Bar / Ruler
          Container(
            height: 20,
            color: kCardColor,
            alignment: Alignment.center,
            child: Text(
              '<- 00:00:00 | 00:00:01 | 00:00:02 | 00:00:03 ->',
              style: TextStyle(fontSize: 10, color: kAccentColor.withOpacity(0.5)),
            ),
          ),
          // Main Video/Audio Layer
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                // Video Clip 1
                ClipItem(color: Colors.blue[800]!, label: 'Video Clip 1 (5s)'),
                // Transition
                TransitionItem(),
                // Video Clip 2
                ClipItem(color: Colors.green[800]!, label: 'Video Clip 2 (3s)'),
                // Add button
                Container(
                  width: 50,
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                  decoration: BoxDecoration(
                    color: kCardColor,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: kPrimaryColor),
                  ),
                  child: const Icon(Icons.add_circle_outline, color: kPrimaryColor),
                ),
              ],
            ),
          ),
          // Sub-Layers (Text, Overlay, AI Captions)
          Container(
            height: 40,
            color: kCardColor,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ClipItem(color: Colors.yellow[800]!, label: 'Text Overlay', width: 100),
                ClipItem(color: Colors.purple[800]!, label: 'AI Captions', width: 150),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ClipItem extends StatelessWidget {
  final Color color;
  final String label;
  final double width;

  const ClipItem({required this.color, required this.label, this.width = 200, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.white, width: 2),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class TransitionItem extends StatelessWidget {
  const TransitionItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: Icon(Icons.circle_rounded, size: 10, color: kPrimaryColor),
    );
  }
}