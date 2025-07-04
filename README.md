# 🤖 Tusky Automation Bot

This script is engineered to automate interactions, such as swaps, on the Tuskey platform. It's designed for users looking to manage multiple accounts and streamline their on-chain activity with ease.

[![Telegram](https://img.shields.io/badge/Community-Airdrop_ALC-26A5E4?style=for-the-badge&logo=telegram)](https://t.me/airdropalc/2583)

---

## ✨ Key Features

* **👤 Multi-Account Management:** Effortlessly run tasks for multiple accounts by simply adding their unique bearer tokens.
* **⚙️ Customizable Automation:** Automates key platform interactions (like swaps or uploads) according to your setup.
* **🌐 Built-in Proxy Support:** Enhance your operational security and avoid IP-based restrictions by routing traffic through your own list of proxies.

---

## 🚀 Installation & Execution

You have two options for running this bot. Choose the one that best fits your needs.

### Option 1: The Easy Way (One-Click Install)

This method is recommended for a quick, zero-configuration setup. It downloads and runs a setup script with a single command.

```bash
wget https://raw.githubusercontent.com/airdropalc/Tusky-Auto-Upload/refs/heads/main/tusky.sh -O Tusky.sh && chmod +x Tusky.sh && ./Tusky.sh
```

---

### Option 2: The Manual Method (For Advanced Control)

This method is for users who want to customize settings, such as proxies, and have more control over the script's execution.

#### 1. Clone the Repository
First, download the project files to your machine and navigate into the main folder.
```bash
git clone [https://github.com/airdropalc/Tusky-Auto-Upload](https://github.com/airdropalc/Tusky-Auto-Upload)
cd Tusky-Auto-Upload
```

#### 2. Install Dependencies
Install the required Node.js packages.
```bash
npm install
```

#### 3. Configure Bearer Tokens
You must add your account bearer tokens to the `.env` file. Each token represents one account.

```bash
# Use your preferred text editor
nano .env
```
**Required format for `.env`:**
```
token_1=YOUR_FIRST_BEARER_TOKEN_HERE
token_2=YOUR_SECOND_BEARER_TOKEN_HERE
# Add more tokens on new lines following the format token_3=...
```

#### 4. Configure Proxies (Optional)
If you wish to use proxies, edit the `proxies.txt` file and add one proxy per line.

```bash
nano proxies.txt
```
**Required format for `proxies.txt`:**
```
http://username:password@ip:port
```

#### 5. Run the Bot
Once your configuration is complete, start the bot.
```bash
node tusky.js
```

---

## ⚠️ Security Warning & Disclaimer

**This tool is for educational purposes only. Use it wisely and at your own risk.**

* **Handle Bearer Tokens with Extreme Care:** Your bearer tokens grant full access to your accounts. **Treat them like passwords.** Never share them or commit them to public repositories.
* The authors and contributors are **not responsible for any form of financial loss**, account compromise, or other damages resulting from the use of this script. The security of your accounts is **your responsibility**.

---

> Inspired by and developed for the [Airdrop ALC](https://t.me/airdropalc) community.

## License

![Version](https://img.shields.io/badge/version-1.0.0-blue)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)]()

---
