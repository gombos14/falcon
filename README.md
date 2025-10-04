# Falcon

## Overview

Falcon is an AI-driven e-commerce application designed for furniture renting. The platform offers a seamless rental experience through a mobile app frontend developed in Dart (Flutter) and a backend implemented with Django REST framework. Falcon provides core e-commerce functionalities such as browsing furniture, selecting rental periods, applying discounts, and placing orders.

A standout feature is an integrated AI chatbot powered by a private GPT model (local large language model) that uses app data to provide customers with personalized information, instant support, and answers related to products, orders, discounts, and more.

## Features

- **Furniture Selection:** Users can browse and choose furniture items available for rent.
- **Rental Period:** Specify rental duration with real-time availability validation.
- **Discount Calculation:** Automatic and transparent discount computation based on rental quantity and period.
- **Order Placement:** Supports both guest checkouts and registered user accounts.
- **Order Tracking:** Registered users can track orders and receive loyalty discounts.
- **Inventory Management:** Backend system to manage stock updates, including manual adjustments by administrators.
- **Role-based Access Control:**
  - Guests: Place orders without registration.
  - Registered Users: Track orders, access discounts.
  - Employees: Access inventory and assigned delivery schedules.
  - Administrators: Manage inventory, approve orders, assign tasks.
- **Delivery and Pickup Scheduling:** Automatically generated and accessible via the web interface, with notifications via email.
- **AI Chatbot (PrivateGPT):** Real-time assistant providing product information, order assistance, discount queries, and detailed reports accessible according to user roles.
- **Secure and Efficient Network Architecture:** Utilizing Proxmox virtualization and WireGuard VPN to ensure data security and optimal communication between app, backend, and AI services.

## Technologies Used

- **Frontend:** Dart using Flutter framework for cross-platform mobile app development.
- **Backend:** Python Django with Django REST Framework for API development.
- **Database:** PostgreSQL for robust relational data storage.
- **AI Integration:** PrivateGPT using Mistral 7B local LLM for privacy-focused AI chatbot functionality.
- **Infrastructure:** Proxmox-based virtualization, WireGuard VPN for secure private network communication.
- **RESTful API:** Connects backend and mobile app, as well as backend and AI service.

## Installation

### Backend Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/gombos14/falcon.git
   cd falcon/backend
   ```
2. Set up a Python virtual environment and install dependencies:
   ```bash
   python3 -m venv venv
   source venv/bin/activate
   pip install -r requirements.txt
   ```
3. Configure PostgreSQL database and update Django settings accordingly.
4. Run migrations:
   ```bash
   python manage.py migrate
   ```
5. Start the Django backend server:
   ```bash
   python manage.py runserver
   ```

### Frontend Setup

1. Navigate to the Flutter app directory:
   ```bash
   cd ../mobile_app
   ```
2. Install Dart/Flutter dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app on emulator or physical device:
   ```bash
   flutter run
   ```

### AI Chatbot Server Setup

- The PrivateGPT server runs separately, connected to backend via API.
- Ensure the PrivateGPT service with the Mistral LLM model is deployed on an accessible node.
- Secure communication via WireGuard VPN is recommended.

## Usage

- Launch the mobile app to browse furniture and manage rental orders.
- Use the AI chatbot within the app for personalized assistance.
- Registered users can view past orders and apply loyalty discounts automatically.
- Administrators and employees use backend and web interfaces for managing inventory, orders, and schedules.

## Contributing

Contributions are welcome! To contribute:

1. Fork the repository.
2. Create a feature branch.
3. Make your changes.
4. Submit a pull request describing your modifications.

Please follow coding standards and include tests where applicable.

## Future Improvements

- Multi-server scalability with load balancing.
- Two-factor authentication for increased security.
- Push notifications for order updates.
- Offline app mode support.
- Enhanced AI personalization using user behavior data.
- Integration of additional payment methods.

## License

This project license will be specified by the author. (Add license details here.)

## Contact

For support or inquiries, please reach out through the GitHub repository issues or contact the maintainer directly.
