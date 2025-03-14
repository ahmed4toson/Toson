#!/bin/bash

# Colors for better UI
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to display the main menu
show_menu() {
    echo -e "${GREEN}"
    echo "======================================="
    figlet "TOSON"  # استخدام figlet لعرض اسم الأداة
    echo "======================================="
    echo -e "${NC}"
    echo "1. Nmap Scan"
    echo "2. Shodan Search"
    echo "3. DNS Lookup (nslookup)"
    echo "4. DNS Dig"
    echo "5. Vulnerability Scan (Nikto)"
    echo "6. Generate Report"
    echo "7. Exit"
    echo -e "${GREEN}=======================================${NC}"
    echo "Choose an option:"
}

# Function for Nmap scan
nmap_scan() {
    echo -e "${GREEN}Enter target IP or domain:${NC}"
    read target
    echo -e "${GREEN}Running Nmap scan on $target...${NC}"
    nmap -sV -O -T4 -p- $target -oN nmap_scan.txt
    echo -e "${GREEN}Scan completed. Results saved to nmap_scan.txt${NC}"
}

# Function for Shodan search
shodan_search() {
    echo -e "${GREEN}Enter your Shodan API key:${NC}"
    read api_key
    shodan init $api_key
    echo -e "${GREEN}Enter Shodan search query:${NC}"
    read query
    echo -e "${GREEN}Searching Shodan for $query...${NC}"
    shodan search $query > shodan_search.txt
    echo -e "${GREEN}Search completed. Results saved to shodan_search.txt${NC}"
}

# Function for DNS lookup (nslookup)
nslookup_function() {
    echo -e "${GREEN}Enter domain name:${NC}"
    read domain
    echo -e "${GREEN}Running nslookup on $domain...${NC}"
    nslookup $domain > nslookup.txt
    echo -e "${GREEN}Results saved to nslookup.txt${NC}"
}

# Function for DNS dig
dig_function() {
    echo -e "${GREEN}Enter domain name:${NC}"
    read domain
    echo -e "${GREEN}Running dig on $domain...${NC}"
    dig $domain ANY > dig.txt
    echo -e "${GREEN}Results saved to dig.txt${NC}"
}

# Function for vulnerability scan (Nikto)
nikto_scan() {
    echo -e "${GREEN}Enter target IP or domain:${NC}"
    read target
    echo -e "${GREEN}Running Nikto scan on $target...${NC}"
    nikto -h $target -o nikto_scan.txt
    echo -e "${GREEN}Scan completed. Results saved to nikto_scan.txt${NC}"
}

# Function to generate a report
generate_report() {
    echo -e "${GREEN}Generating report...${NC}"
    echo "=== Toson Tool Report ===" > report.txt
    echo "Date: $(date)" >> report.txt
    echo "=========================" >> report.txt

    if [ -f nmap_scan.txt ]; then
        echo -e "\n=== Nmap Scan Results ===" >> report.txt
        cat nmap_scan.txt >> report.txt
    fi

    if [ -f shodan_search.txt ]; then
        echo -e "\n=== Shodan Search Results ===" >> report.txt
        cat shodan_search.txt >> report.txt
    fi

    if [ -f nslookup.txt ]; then
        echo -e "\n=== DNS Lookup Results ===" >> report.txt
        cat nslookup.txt >> report.txt
    fi

    if [ -f dig.txt ]; then
        echo -e "\n=== DNS Dig Results ===" >> report.txt
        cat dig.txt >> report.txt
    fi

    if [ -f nikto_scan.txt ]; then
        echo -e "\n=== Nikto Vulnerability Scan Results ===" >> report.txt
        cat nikto_scan.txt >> report.txt
    fi

    echo -e "${GREEN}Report generated. Results saved to report.txt${NC}"
}

# Main loop
while true; do
    show_menu
    read option
    case $option in
        1) nmap_scan;;
        2) shodan_search;;
        3) nslookup_function;;
        4) dig_function;;
        5) nikto_scan;;
        6) generate_report;;
        7) echo -e "${RED}Exiting...${NC}"; break;;
        *) echo -e "${RED}Invalid option${NC}";;
    esac
done
