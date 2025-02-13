# Amazon Clone App

## Overview
Amazon Clone is a full-fledged e-commerce application that replicates the core functionalities of Amazon. It includes both a **User Side** and an **Admin Side**, allowing customers to browse, purchase products, and manage orders while enabling admins to oversee product listings, track analytics, and manage orders.

## Features

### User Side
1. **Authentication**
    - Login & Sign Up screen similar to Amazon.

2. **Home Screen**
    - Search bar for product search.
    - Category-wise filtering (e.g., Mobile, Appliances, Essentials, Books, Fashion).
    - Carousel images for promotions.
    - Top-selling items displayed with photos.

3. **Search Functionality**
    - Users can search for any product available on the platform.

4. **Category-wise Filter**
    - Clicking on a category (e.g., Mobile) displays all products related to that category.

5. **Profile Section**
    - List of past orders.
    - Wishlist functionality.
    - Logout button.

6. **Cart Section**
    - Displays selected items.
    - Dynamic price updates based on quantity.
    - "Proceed to Buy" button leading to **Google Pay (GPay) Payment Integration**.

### Admin Side
1. **Home Screen**
    - Displays all products available for sale.

2. **Analytics Dashboard**
    - Chart representation of best-selling products.
    - Revenue tracking and total sales data.

3. **Order Management**
    - List of recent customer orders.
    - Ability to update order status.

## Technologies Used
- **Frontend:** Flutter (Dart)
- **Backend:** Node.js with Express
- **Database:** MongoDB
- **Hosting:** Render
- **Payment Gateway:** Google Pay (GPay)
- **State Management:** Provider

## Installation & Setup
1. Clone the repository:
   ```sh
   git clone https://github.com/pranayjha5666/amazonclone
   ```
2. Navigate to the project folder:
   ```sh
   cd amazon-clone
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```
4. Run the application:
   ```sh
   flutter run
   ```

## Environment Variables (.env)
Create a `.env` file in the root directory and add the following:

```env
RENDER_BACKEND_URL=your_render_backend_url
CLOUDINARY_CLOUD_NAME=your_cloudinary_cloud_name
CLOUDINARY_UPLOAD_PRESET=your_cloudinary_upload_preset
```

## Future Enhancements
- Add real-time order tracking.
- Implement a review and rating system.
- Enhance UI/UX for better user experience.

## Contributors
- **Pranay Jha** (Developer)

## License
This project is for my educational purposes only .