import requests
from bs4 import BeautifulSoup
import argparse

def scan_sql_injection(url):
    payloads = ["' OR 1=1 --", '" OR 1=1 --']
    for payload in payloads:
        test_url = f"{url}?id={payload}"
        response = requests.get(test_url)
        if "error" in response.text.lower():
            print(f"Potential SQL Injection at: {test_url}")

def scan_xss(url):
    payloads = ["<script>alert('XSS')</script>", "<img src='x' onerror='alert(1)'>"]
    for payload in payloads:
        test_url = f"{url}?q={payload}"
        response = requests.get(test_url)
        if payload in response.text:
            print(f"Potential XSS at: {test_url}")

def main():
    parser = argparse.ArgumentParser(description="Web Vulnerability Scanner")
    parser.add_argument("url", help="Target URL to scan")
    args = parser.parse_args()

    print(f"Scanning {args.url} for vulnerabilities...")
    scan_sql_injection(args.url)
    scan_xss(args.url)

if __name__ == "__main__":
    main()

