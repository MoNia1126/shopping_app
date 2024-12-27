# Shopping App

A Flutter application that delivers a simple shopping App. In the app, one will have a product page
view, grid-based product displays, and a section for hot offers.

---

## Features

- **Product Page View**: A swipe-able featured products `PageView`.
- **Product Grid**: Here is a grid with products.
- **Hot Offers Section**: A list of offers in horizontal scroll view.
- **Add to Cart**: Add items to cart with feedback which show using `SnackBar`.
- **Responsive Design**: Optimized for various screen sizes.

---

### Screenshots

| **Feature**    | **Screenshot**             |
|----------------|----------------------------|
| **Product**    | ![Product](output.png)     |
| **Hot Offers** | ![Hot Offers](output2.png) |
| **Grid**       | ![Grid](grid.png)          |

---

## Folder Structure

```plaintext
shopping_app/
├── lib/
│   ├── main.dart                 # Main entry point of the app
│   ├── shopping_screen.dart    # Main shopping screen
│   ├── product_page_view.dart  # page view for featured products
│   ├── product_grid.dart       # Grid layout for product display
│   ├── hot_offer_list.dart     # Horizontal list for hot offers
├── assets/
│   ├── images/
│   │   └── product1.jpg       # Local image used in the app
│   └── fonts/
│       └── Lora-Regular.ttf   # Custom font file
├── pubspec.yaml                  # Dependencies and assets configuration
├── README.md                     # Project documentation
├── output.png                    # Create screenshot
└── output1.png        

```

## How to Run

1. Install and setup Flutter in your system.
2. Clone the repository and open the folder in your IDE or text editor.
3. Then, Run

```bash
flutter pub get
flutter run
