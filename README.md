# MYKANISA Backend

This is the backend repository for the **MYKANISA** (Kanisa App) Church Management System. Built on Laravel 9, it serves a comprehensive RESTful API handling multiple aspects of church administration, user management, and automated payments.

## Features & Modules

- **Authentication & Authorization**
  - Token-based API authentication via **Laravel Sanctum**.
  - **Role-Based Access Control (RBAC):** Extensive support for various leadership roles and permissions, including Admin, Pastor, Elder, Deacon, Secretary, Treasurer, Chairman, Group Leader, Choir Leader, Sunday School Teacher, and Regular Member.

- **Member Management**
  - Registration and profile management.
  - Profile avatars and digital file attachments (e.g., passports, marriage certificates).
  - Dependent tracking.
  - Member search and discovery for leadership.

- **Organizational Structure**
  - Hierarchical location management: **Regions** > **Presbyteries** > **Parishes** > **Congregations**.
  - Member grouping (Youth, Choir, Sunday School, Custom Groups, etc.).

- **Financials & Contributions**
  - Integrated **Safaricom M-Pesa** payments (STK Push initiation and callback parsing/handling).
  - Track contributions, pledges, and payment history.
  - Financial overview, reports, and transaction logs accessible to Treasurers and Admins.

- **Communications & Events**
  - Broadcast messaging and announcements directly from leadership.
  - Push notifications configured via **Firebase (fcm)** using `larafirebase`.
  - Event creation, announcements, and RSVP functionalities.

- **Administration & Records**
  - Meeting Minutes tracking and follow-up on action points (Secretaries).
  - Attendance management & history (Holy Communion, Sunday Services, Events).
  - QR Code generation and verification for event check-ins.
  - Robust Audit Logging for communications, tasks, and attendances.

## Tech Stack

- **Framework:** [Laravel ^9.19](https://laravel.com)
- **Language:** PHP ^8.0.2
- **Database:** MySQL / PostgreSQL (managed via Eloquent ORM)
- **Authentication:** Laravel Sanctum
- **Push Notifications:** [larafirebase](https://github.com/kutia-software-company/larafirebase)
- **HTTP Client:** Guzzle

## Installation & Setup

1. **Clone the repository:**
   ```bash
   git clone <repo-url>
   cd backend
   ```

2. **Install Composer dependencies:**
   ```bash
   composer install
   ```

3. **Configure Environment:**
   Copy the example environment variables file and update your database and API credentials (including M-Pesa and FCM keys).
   ```bash
   cp .env.example .env
   ```

4. **Generate Application Key:**
   ```bash
   php artisan key:generate
   ```

5. **Run Database Migrations and Seeders:**
   Make sure you have an empty database ready and correctly referenced in `.env`.
   ```bash
   php artisan migrate --seed
   ```

6. **Serve the Application:**
   ```bash
   php artisan serve
   ```
   *The API will be available at `http://localhost:8000/api`*

## API Architecture Overview

The API is heavily namespaced depending on the user interaction context:
- `routes/api.php` includes segregated grouping for:
  - **Public/Guest Endpoints**: Login, Register, Password Reset, M-Pesa Callbacks.
  - **Leadership Scopes**: `admin/*`, `pastor/*`, `elder/*`, `deacon/*`, `treasurer/*`, `secretary/*`, etc.
  - **General Authed**: `member/*` routes for personal profiles, pledges, and digital files.

## Third-Party Integrations
- **Safaricom Daraja API:** For direct C2B or STK push payments. Requires credentials configured in the `.env` file (e.g., consumer key, secret, passkey, shortcode).
- **Firebase Cloud Messaging (FCM):** Push notification routing. Make sure your server key is defined in the environment.

## Contribution Guidelines

To contribute, follow general PSR-12 coding standard guidelines. Create feature branches mapped to active tickets and submit pull requests accompanied by adequate test coverage.

## License

This project is proprietary software belonging to the MYKANISA development team phase/organization. Unauthorized copying or distributing of this software is strictly prohibited unless explicitly stated otherwise.
