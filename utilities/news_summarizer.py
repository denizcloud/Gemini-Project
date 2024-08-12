import google.generativeai as genai
import firebase_admin
from firebase_admin import credentials
from firebase_admin import db


cred = credentials.Certificate("src/authorizer-e6ee1-firebase-adminsdk-lfar5-1f639a65a3.json")
default_app = firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://authorizer-e6ee1-default-rtdb.europe-west1.firebasedatabase.app/',
    'databaseAuthVariableOverride': None
})
genai.configure(api_key='AIzaSyCP1zqfDhDSxM8LH84xtzFvwTlzfl_LThs')


def get_path_by_title(reference_path, field_name):
    try:
        ref = db.reference(f"{reference_path}/{field_name}")
        
        results = ref.get()
        
        if results:
            full_path = f"{reference_path}/{field_name}"
            return full_path
        else:
            print(f"No results found for {field_name} in {field_name}.")
    except Exception as e:
        print(f"An error occurred: {e}")
    return None

def get_full_news_from_realtime_db(newsID):
    news = "/news"

    reference_path = f"{get_path_by_title(news, newsID)}/article"
    try:
        ref = db.reference(reference_path)
        
        paragraph = ref.get()
        
        if paragraph:
            return paragraph
        else:
            print("No data found at the specified reference path.")
    except Exception as e:
        print(f"An error occurred: {e}")
    return None

def gemini_summarizer(newsID, english_level, bullet_point = False):
    model = genai.GenerativeModel(model_name="gemini-1.5-flash")

    news = "/news"


    news_article = get_full_news_from_realtime_db(newsID)
    summary_path = f"{get_path_by_title(news, newsID)}/summary"

    if bullet_point:
        response = model.generate_content([news_article, "Can you summarize this article as a bulleted list and also give key points?"])

    elif not bullet_point:
        prompt = f"Can you summarize this article with {str(english_level)} level english in 30 words or less?"
        response = model.generate_content([news_article, prompt])
    try:
        # Reference to the specific location in the Realtime Database
        ref = db.reference(summary_path)
        text = (response.candidates[0].content.parts[0].text)
        # Set the data at the reference path
        ref.set(text)
        print(f"Data written successfully to {summary_path}")
    except Exception as e:
        print(f"An error occurred: {e}")


if __name__ == '__main__':
    gemini_summarizer("2", "C2")