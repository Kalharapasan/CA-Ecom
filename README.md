# ShopHub - Advanced Flutter E-Commerce App

## Overview
ShopHub is a modern, feature-rich e-commerce mobile application built with Flutter. This project demonstrates a complete shopping experience with beautiful UI/UX and advanced functionality.

## ✨ Features

### Core Features
- **Splash Screen** - Animated welcome screen with smooth transitions
- **Onboarding** - Interactive introduction to app features
- **Home Page** - Featured products with category filtering
- **Product Details** - Comprehensive product information with reviews and image gallery
- **Search & Filter** - Advanced product search with multiple filters
- **Shopping Cart** - Full cart management with quantity controls and price calculations
- **Wishlist** - Save favorite products for later
- **Categories** - Browse products by category with beautiful grid layout
- **Order History** - View past orders with detailed information
- **Profile** - User profile with statistics and settings
- **Settings** - Comprehensive app settings and preferences

### UI/UX Features
- **Material Design 3** - Modern, clean interface
- **Smooth Animations** - Transitions and micro-interactions
- **Pull to Refresh** - Refresh content with swipe gesture
- **Swipe to Delete** - Intuitive item removal
- **Loading States** - Proper feedback for user actions
- **Empty States** - Helpful messages when no content
- **Responsive Design** - Adapts to different screen sizes

### Advanced Features
- **Dynamic Pricing** - Real-time price calculations with tax and shipping
- **Product Reviews** - User ratings and comments
- **Promotional Banners** - Special offers and deals
- **Category Filtering** - Smart product filtering by category
- **Price Range Filter** - Filter products by price
- **Sorting Options** - Sort by name, price (low to high, high to low)
- **Badge Notifications** - Cart item counter
- **Multiple Product Images** - Image gallery with pagination
- **Quantity Management** - Add/remove quantity in cart

## 📁 Project Structure

```
ict084/
├── lib/
│   ├── main.dart                   # App entry point
│   ├── data/
│   │   └── data.dart               # Mock data and models
│   ├── pages/                      # All app screens
│   │   ├── splash_screen.dart      # Animated splash screen
│   │   ├── onboarding_screen.dart  # Welcome screens
│   │   ├── home_page.dart          # Main home screen
│   │   ├── product_detail_page.dart# Product details
│   │   ├── search_page.dart        # Search with filters
│   │   ├── cart_page.dart          # Shopping cart
│   │   ├── wishlist_page.dart      # Saved items
│   │   ├── categories_page.dart    # Category browser
│   │   ├── profile_page.dart       # User profile
│   │   ├── order_history_page.dart # Past orders
│   │   └── settings_page.dart      # App settings
│   └── widgets/                    # Reusable components
│       ├── product_card.dart       # Product display card
│       └── category_list.dart      # Category selector
├── android/                        # Android platform files
├── ios/                            # iOS platform files
├── assets/
│   └── images/                     # App images and icons
└── pubspec.yaml                    # Dependencies and metadata
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.24 or higher)
- Dart SDK (3.5 or higher)
- Android Studio / VS Code with Flutter extensions
- Android device or emulator / iOS simulator

### Installation

1. **Clone or download this project**

2. **Navigate to the Flutter project directory**
   ```bash
   cd CA-Ecom/ict084
   ```

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 📱 App Flow

1. **Splash Screen** → Shows app logo with animation (3 seconds)
2. **Onboarding** → 3 screens introducing app features
3. **Home Page** → Main screen with:
   - Promotional banner
   - Category filters
   - Product grid
   - Search and cart access
4. **Navigation** → Bottom navigation bar with:
   - Home
   - Categories
   - Wishlist
   - Profile

## 🎨 Customization

### Colors
Edit the theme in `main.dart`:
```dart
theme: ThemeData(
  useMaterial3: true,
  colorSchemeSeed: Colors.blue, // Change to your brand color
),
```

### Products
Modify the products list in `lib/data/data.dart` or `lib/pages/home_page.dart`:
```dart
final List<Map<String, dynamic>> products = [
  {
    'name': 'Product Name',
    'price': '\$999',
    'category': 'Category',
    'image': 'assets/images/products/...',
  },
  // Add more products
];
```

### Categories
Update categories in `lib/pages/home_page.dart`:
```dart
final List<String> categories = [
  'All',
  'Your Category 1',
  'Your Category 2',
  // Add more categories
];
```

## 🔧 Key Components

### ProductCard Widget
Displays product with image, name, price, and action buttons
```dart
ProductCard(
  product: productData,
  onAddToCart: () => _addToCart(product),
  onAddToWishlist: () => _addToWishlist(product),
)
```

### CategoryList Widget
Horizontal scrollable category selector
```dart
CategoryList(
  categories: categories,
  selectedIndex: _selectedCategoryIndex,
  onCategoryTap: (index) => setState(() {
    _selectedCategoryIndex = index;
  }),
)
```

## 📊 Features Breakdown

### Shopping Cart
- Add/remove items
- Quantity management
- Price calculations (subtotal, tax, shipping)
- Swipe to delete
- Clear all functionality

### Wishlist
- Save favorite products
- Add to cart from wishlist
- Remove items
- Empty state handling

### Search & Filters
- Real-time search
- Category filter
- Price range slider
- Sort by name/price
- Filter chips display

### Product Details
- Image gallery with pagination
- Product description
- Customer reviews
- Quantity selector
- Add to cart/wishlist
- Share functionality

### Order History
- View past orders
- Order details modal
- Track order status
- Reorder functionality

### Settings
- Account settings
- Notifications preferences
- Language selection
- Dark mode toggle (UI ready)
- Help & support links

## 🎓 Learning Objectives

This project demonstrates:
- **State Management** - Using setState for local state
- **Navigation** - Multiple navigation patterns (push, replace, modal)
- **List Handling** - Filtering, sorting, and manipulating lists
- **UI Components** - Cards, dialogs, bottom sheets, sliver app bars
- **Animations** - Fade, scale, and page transitions
- **Form Handling** - Text fields and user input
- **Responsive Design** - Adapting to different screen sizes
- **Material Design** - Following Material Design 3 guidelines

## 🚧 Future Enhancements

- [ ] User authentication (login/signup)
- [ ] Backend integration (REST API/GraphQL)
- [ ] Payment gateway integration (Stripe, PayPal)
- [ ] Real-time order tracking
- [ ] Push notifications (Firebase Cloud Messaging)
- [ ] Dark mode implementation
- [ ] Multi-language support (i18n)
- [ ] Product ratings and reviews submission
- [ ] Social media sharing
- [ ] Delivery address management
- [ ] Coupon/promo code system
- [ ] AI-powered recommendations
- [ ] Voice search functionality
- [ ] Augmented Reality product preview
- [ ] Chat support (real-time messaging)

## 📝 Notes for University CA

### Frontend Focus
This project focuses purely on the frontend implementation:
- No backend/API integration
- Mock data for products and orders
- Simulated functionality (checkout, payments)
- UI/UX demonstrations only

### Key Highlights
- **Clean Code** - Well-organized and commented
- **Best Practices** - Following Flutter conventions
- **Modern UI** - Material Design 3 implementation
- **Comprehensive** - Multiple screens and features
- **Professional** - Production-ready UI components

## 🤝 Contributing

This is a university project. For improvements:
1. Review the code structure
2. Add new features in appropriate directories
3. Follow the existing naming conventions
4. Test on multiple devices

## 📄 License

This project is created for educational purposes as part of a university coursework assignment.

## 👨‍💻 Developer

**Pasan Kalhara**
- Email: kalharap84@gmail.com

---

**Version:** 1.0.0  
**Last Updated:** January 2026  
**Flutter Version:** 3.24+  
**Platform:** Android & iOS