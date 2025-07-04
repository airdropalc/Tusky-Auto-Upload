#!/bin/bash
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m'

BOT_DIR="Tusky_Bot"
NODE_SCRIPT_NAME="tusky.js"
SCREEN_SESSION_NAME="TuskyBot"

initial_setup() {
    echo -e "${CYAN}➤ Starting initial setup for the Tusky Bot...${NC}"

    if [ ! -d "$BOT_DIR" ]; then
        echo -e "${CYAN}Creating bot directory: $BOT_DIR${NC}"
        mkdir "$BOT_DIR"
    else
        echo -e "${YELLOW}Directory '$BOT_DIR' already exists. Skipping creation.${NC}"
    fi

    echo -e "${CYAN}Downloading required files from GitHub...${NC}"
    (cd "$BOT_DIR" && wget -q --show-progress -O "$NODE_SCRIPT_NAME" "https://raw.githubusercontent.com/airdropalc/Tusky-Auto-Upload/refs/heads/main/tusky.js")
    (cd "$BOT_DIR" && wget -q --show-progress -O "package.json" "https://raw.githubusercontent.com/airdropalc/Tusky-Auto-Upload/refs/heads/main/package.json")
    echo -e "${GREEN}✓ Files downloaded successfully.${NC}"

    echo -e "${CYAN}➤ Installing required NodeJS packages using npm...${NC}"
    (cd "$BOT_DIR" && npm install)
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ Dependencies installed successfully.${NC}"
    else
        echo -e "${RED}✗ Failed to install dependencies. Please check your npm and internet connection.${NC}"
        read -n 1 -s -r -p "Press any key to return to the menu..."
        return 1
    fi

    echo ""
    echo -e "${GREEN}✅ Initial setup completed! Please configure your proxies and .env file next.${NC}"
    echo ""
    read -n 1 -s -r -p "Press any key to return to the menu..."
}

configure_proxies() {
    echo -e "${CYAN}➤ Proxy Configuration${NC}"
    echo -e "${YELLOW}Enter your proxies one by one. Press ENTER on an empty line to finish.${NC}"
    echo -e "${YELLOW}Format: http://username:password@host:port OR ip:port${NC}"

    > "$BOT_DIR/proxies.txt"
    local count=0
    while true; do
        read -p "Enter proxy: " proxy_line
        if [ -z "$proxy_line" ]; then
            break
        fi
        echo "$proxy_line" >> "$BOT_DIR/proxies.txt"
        count=$((count + 1))
    done

    if [ "$count" -gt 0 ]; then
        echo -e "${GREEN}✓ Saved $count proxies to $BOT_DIR/proxies.txt successfully.${NC}"
    else
        echo -e "${YELLOW}⚠ No proxies were entered. The file is empty.${NC}"
    fi
    echo ""
    read -n 1 -s -r -p "Press any key to return to the menu..."
}

configure_env() {
    echo -e "${CYAN}➤ Environment (.env) Configuration${NC}"
    echo -e "${YELLOW}Please enter the required token values.${NC}"

    > "$BOT_DIR/.env"

    read -p "Enter your token_1: " token_1_value
    echo "token_1=${token_1_value}" >> "$BOT_DIR/.env"

    read -p "Enter your token_2: " token_2_value
    echo "token_2=${token_2_value}" >> "$BOT_DIR/.env"
    
    echo -e "${GREEN}✓ Configuration saved to $BOT_DIR/.env successfully.${NC}"
    echo ""
    read -n 1 -s -r -p "Press any key to return to the menu..."
}

run_bot() {
    if [ ! -f "$BOT_DIR/.env" ] || [ ! -f "$BOT_DIR/proxies.txt" ]; then
        echo -e "${RED}✗ Configuration file (.env or proxies.txt) not found!${NC}"
        echo -e "${YELLOW}Please complete the setup and configuration first (Options 1, 2, and 3).${NC}"
    else
        echo -e "${CYAN}➤ Starting the bot in a background 'screen' session named '${SCREEN_SESSION_NAME}'...${NC}"
        (cd "$BOT_DIR" && screen -dmS "$SCREEN_SESSION_NAME" node "$NODE_SCRIPT_NAME")
        echo -e "${GREEN}✓ Bot has been started.${NC}"
        echo -e "${YELLOW}IMPORTANT: To view the bot's output, use Option 5 (Check Bot Status).${NC}"
        echo -e "${YELLOW}To detach from the session window after checking, press: ${CYAN}CTRL+A${YELLOW} then ${CYAN}D${NC}"
    fi
    echo ""
    read -n 1 -s -r -p "Press any key to return to the menu..."
}

check_status() {
    echo -e "${CYAN}➤ Attaching to screen session '${SCREEN_SESSION_NAME}'...${NC}"
    echo -e "${YELLOW}To detach and return to the terminal, press: ${CYAN}CTRL+A${YELLOW} then ${CYAN}D${NC}"
    sleep 2
    screen -r "$SCREEN_SESSION_NAME"
    echo -e "\n${GREEN}Returned from screen session.${NC}"
    echo ""
    read -n 1 -s -r -p "Press any key to return to the menu..."
}

stop_bot() {
    echo -e "${CYAN}➤ Attempting to stop the bot...${NC}"
    if screen -list | grep -q "$SCREEN_SESSION_NAME"; then
        screen -X -S "$SCREEN_SESSION_NAME" quit
        echo -e "${GREEN}✓ Bot session '${SCREEN_SESSION_NAME}' has been stopped.${NC}"
    else
        echo -e "${YELLOW}⚠ Bot session '${SCREEN_SESSION_NAME}' is not currently running.${NC}"
    fi
    echo ""
    read -n 1 -s -r -p "Press any key to return to the menu..."
}

while true; do
    clear
    echo -e "${CYAN}================================================${NC}"
    echo -e "${CYAN}        TUSKY AUTO UPLOAD BY AIRDROP ALC        ${NC}"
    echo -e "${CYAN}================================================${NC}"
    echo -e "Please choose an option:"
    echo -e "1. ${GREEN}Initial Setup${NC} (Download files & Install Dependencies)"
    echo -e "2. ${GREEN}Configure Proxies${NC} (Create proxies.txt)"
    echo -e "3. ${GREEN}Configure .env File${NC} (Set your tokens)"
    echo -e "4. ${GREEN}Run Bot${NC} (Starts the upload process)"
    echo -e "5. ${YELLOW}Check Bot Status${NC} (View the bot's live output)"
    echo -e "6. ${RED}Stop Bot${NC}"
    echo -e "0. ${RED}Exit${NC}"
    echo -e "${CYAN}------------------------------------${NC}"
    read -p "Enter your choice [0-6]: " choice

    case $choice in
        1)
            initial_setup
            ;;
        2)
            configure_proxies
            ;;
        3)
            configure_env
            ;;
        4)
            run_bot
            ;;
        5)
            check_status
            ;;
        6)
            stop_bot
            ;;
        0)
            echo "Exiting. Goodbye!"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option. Please try again.${NC}"
            sleep 2
            ;;
    esac
done
