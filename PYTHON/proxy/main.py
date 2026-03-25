import requests
from bs4 import BeautifulSoup
import webbrowser


def get_telegram_proxies(url):
    try:
        headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
        }
        response = requests.get(url, headers=headers, timeout=10)
        response.raise_for_status()
        soup = BeautifulSoup(response.text, 'html.parser')
        links = soup.find_all('a', href=True)
        proxy_links = []
        for link in links:
            href = link['href']
            if href.startswith('tg://proxy') or 't.me/proxy' in href:
                proxy_links.append(href)
        return list(dict.fromkeys(proxy_links))
    except Exception as e:
        return f"Ошибка: {e}"


target_url = "https://mtproto.ru/personal-other.php"
proxies = get_telegram_proxies(target_url)

if isinstance(proxies, list) and proxies:
    webbrowser.open(proxies[0])