# 🛍️ Dealership 🌟

Welcome to the Dealership

Commands:
 - /buyvehicle - can buy any vehicle
 - /changespawnvehicle - change pos spawn your vehicle

## ⚙️ Prerequisites

To set up and run the Dealership, ensure that your system has the following
requirements:

- [sampctl](https://github.com/Southclaws/sampctl)
- [MySQL] 5.0 or later

## 🚀 Installation

Follow these steps to install the Watch Store Application:

1. Clone the repository:

    ```
    git clone git@github.com:vlad-platonov/dealership.git
    ```
2. Set up your database, for this you can use the sql script located on the path database/db.sql

3. Build the project using sampctl:

    ```
    sampctl ensure
    sampctl build
    ```

## 🎮 Running the Application

You can now run the Dealership by executing one of the following commands:

- Using the bash:

    ```bash
    MYSQL_USER=user MYSQL_PASSWORD=password MYSQL_HOST=localhost MYSQL_DATABASE=database sampctl run
    ```

- Using the bash PowerShell:

    ```powershell

    $env:MYSQL_USER="user"; $env:MYSQL_PASSWORD="password"; $env:MYSQL_HOST="localhost"; $env:MYSQL_DATABASE="database"; sampctl run
    ```