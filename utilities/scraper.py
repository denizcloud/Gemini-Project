import requests
from bs4 import BeautifulSoup
import csv
from datetime import datetime
import re
import google.generativeai as genai
from google.generativeai.types import HarmCategory, HarmBlockThreshold
import os
import logging

logging.getLogger().setLevel(logging.ERROR)

genai.configure(api_key=os.environ['GEMINI_API_KEY'])
model = genai.GenerativeModel('gemini-1.5-flash', generation_config={'candidate_count': 1},     safety_settings={
        HarmCategory.HARM_CATEGORY_SEXUALLY_EXPLICIT: HarmBlockThreshold.BLOCK_NONE,
        HarmCategory.HARM_CATEGORY_HATE_SPEECH: HarmBlockThreshold.BLOCK_NONE,
        HarmCategory.HARM_CATEGORY_HARASSMENT: HarmBlockThreshold.BLOCK_NONE,
        HarmCategory.HARM_CATEGORY_DANGEROUS_CONTENT: HarmBlockThreshold.BLOCK_NONE
    })

def summarize_content(content):
    prompt = "Provide a summary of the following article in a single paragraph. Only return that paragraph:\n\n" + content
    try:
        response = model.generate_content(prompt)
        return response._result.candidates[0].content.parts[0].text
    except Exception as e:
        print(f"Error summarizing content: {e}")
        return 'No summary available'

def fetch_cnn_news(filename='cnn_news.csv'):
    url = 'https://edition.cnn.com/'
    response = requests.get(url)
    soup = BeautifulSoup(response.content, 'html.parser')
    articles = soup.find_all('a', href=re.compile(r'/\d{4}/\d{2}/\d{2}/'))

    with open(filename, 'w', newline='', encoding='utf-8') as file:
        writer = csv.writer(file)
        writer.writerow(['Title', 'Date', 'Category', 'Summary', 'Image URL'])

        for article in articles:
            link = article['href']
            if not link.startswith('https'):
                link = 'https://edition.cnn.com' + link

            category_match = re.search(r'/\d{4}/\d{2}/\d{2}/([^/]+)/', link)
            category = category_match.group(1) if category_match else 'No Category'

            article_page = requests.get(link)
            article_soup = BeautifulSoup(article_page.content, 'html.parser')
            
            title_tag = article_soup.find('h1')
            title = title_tag.get_text().strip() if title_tag else 'No Title'

            date_tag = article_soup.find('meta', attrs={'itemprop': 'datePublished'})
            date = date_tag['content'] if date_tag else datetime.now().strftime('%Y-%m-%d')

            paragraphs = article_soup.find_all('div', class_='zn-body__paragraph') or article_soup.find_all('p')
            content = ' '.join([p.get_text() for p in paragraphs])

            image_tag = article_soup.find('meta', attrs={'property': 'og:image'})
            image_url = image_tag['content'] if image_tag else 'No Image'

            summary = summarize_content(content)
            
            writer.writerow([title, date, category, summary, image_url])
            print(f'Scraped and wrote: {title} | Category: {category} | Image: {image_url}')

if __name__ == '__main__':
    fetch_cnn_news()