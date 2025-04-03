import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'contact_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void toggleTheme() {
    setState(() {
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
      } else if (_themeMode == ThemeMode.dark) {
        _themeMode = ThemeMode.light;
      } else {
        _themeMode = ThemeMode.light;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        toggleTheme: toggleTheme,
        themeMode: _themeMode,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key, 
    required this.title,
    required this.toggleTheme,
    required this.themeMode,
  });

  final String title;
  final VoidCallback toggleTheme;
  final ThemeMode themeMode;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  int _counter = 0;
  int _selectedIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(
              widget.themeMode == ThemeMode.light 
                ? Icons.dark_mode 
                : Icons.light_mode,
            ),
            onPressed: widget.toggleTheme,
            tooltip: widget.themeMode == ThemeMode.light 
              ? 'Switch to Dark Mode' 
              : 'Switch to Light Mode',
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomePage();
      case 1:
        return _buildBusinessPage();
      case 2:
        return _buildSchoolPage();
      case 3:
        return _buildSettingsPage();
      default:
        return _buildHomePage();
    }
  }

  Widget _buildHomePage() {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.directions_car), text: 'Car'),
            Tab(icon: Icon(Icons.directions_transit), text: 'Transit'),
            Tab(icon: Icon(Icons.directions_bike), text: 'Bike'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildCarTab(),
              _buildTabContent('Transit Tab', Icons.directions_transit),
              _buildTabContent('Bike Tab', Icons.directions_bike),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCarTab() {
    return Padding(
      padding: EdgeInsets.all(AppTheme.spacingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available Cars',
            style: AppTheme.headingStyle,
          ),
          SizedBox(height: AppTheme.spacingMedium),
          Expanded(
            child: ListView(
              children: [
                _buildCarCard(
                  'Tesla Model 3',
                  'Electric Sedan',
                  '\$45,000',
                  'https://images.unsplash.com/photo-1560958089-b8a1929cea89?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
                ),
                SizedBox(height: AppTheme.spacingMedium),
                _buildCarCard(
                  'Toyota Camry',
                  'Midsize Sedan',
                  '\$25,000',
                  'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
                ),
                SizedBox(height: AppTheme.spacingMedium),
                _buildCarCard(
                  'Honda CR-V',
                  'Compact SUV',
                  '\$30,000',
                  'https://images.unsplash.com/photo-1519641471654-76ce0107ad1b?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
                ),
                SizedBox(height: AppTheme.spacingMedium),
                _buildCarCard(
                  'BMW X5',
                  'Luxury SUV',
                  '\$65,000',
                  'https://images.unsplash.com/photo-1555215695-3004980ad54e?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
                ),
                SizedBox(height: AppTheme.spacingMedium),
                _buildCarCard(
                  'Ford Mustang',
                  'Sports Car',
                  '\$40,000',
                  'https://images.unsplash.com/photo-1583121274602-3e2820c69888?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
                ),
                SizedBox(height: AppTheme.spacingLarge),
                
                // Kontaktformular-Button
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ContactForm(),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
                    child: Padding(
                      padding: const EdgeInsets.all(AppTheme.spacingMedium),
                      child: Row(
                        children: [
                          Icon(
                            Icons.contact_mail,
                            size: 40,
                            color: AppTheme.primaryColor,
                          ),
                          SizedBox(width: AppTheme.spacingMedium),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Contact Form',
                                  style: AppTheme.subheadingStyle,
                                ),
                                SizedBox(height: AppTheme.spacingSmall),
                                Text(
                                  'Fill out your contact information and download as PDF',
                                  style: AppTheme.captionStyle,
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppTheme.primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarCard(String title, String subtitle, String price, String imageUrl) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppTheme.borderRadiusLarge),
              topRight: Radius.circular(AppTheme.borderRadiusLarge),
            ),
            child: Image.network(
              imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 150,
                  color: Colors.grey[300],
                  child: Icon(Icons.error, size: 50, color: AppTheme.errorColor),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppTheme.spacingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.subheadingStyle,
                ),
                SizedBox(height: AppTheme.spacingSmall),
                Text(
                  subtitle,
                  style: AppTheme.captionStyle,
                ),
                SizedBox(height: AppTheme.spacingMedium),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Add booking functionality here
                      },
                      child: const Text('Book Now'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(String title, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 80, color: AppTheme.primaryColor),
          SizedBox(height: AppTheme.spacingLarge),
          Text(
            title,
            style: AppTheme.headingStyle,
          ),
          SizedBox(height: AppTheme.spacingLarge),
          Text(
            'You have pushed the button this many times:',
            style: AppTheme.bodyStyle,
          ),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Business Page',
            style: AppTheme.headingStyle,
          ),
          SizedBox(height: AppTheme.spacingLarge),
          Text(
            'This is the business section of the app.',
            style: AppTheme.bodyStyle,
          ),
          SizedBox(height: AppTheme.spacingLarge),
          ElevatedButton(
            onPressed: () {
              // Add business functionality here
            },
            child: const Text('Business Action'),
          ),
        ],
      ),
    );
  }

  Widget _buildSchoolPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'School Page',
            style: AppTheme.headingStyle,
          ),
          SizedBox(height: AppTheme.spacingLarge),
          Text(
            'This is the school section of the app.',
            style: AppTheme.bodyStyle,
          ),
          SizedBox(height: AppTheme.spacingLarge),
          ElevatedButton(
            onPressed: () {
              // Add school functionality here
            },
            child: const Text('School Action'),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Settings Page',
            style: AppTheme.headingStyle,
          ),
          SizedBox(height: AppTheme.spacingLarge),
          Text(
            'This is the settings section of the app.',
            style: AppTheme.bodyStyle,
          ),
          SizedBox(height: AppTheme.spacingLarge),
          ElevatedButton(
            onPressed: () {
              // Add settings functionality here
            },
            child: const Text('Settings Action'),
          ),
        ],
      ),
    );
  }
}
