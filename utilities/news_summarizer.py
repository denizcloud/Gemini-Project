import google.generativeai as genai
import firebase_admin
from firebase_admin import credentials
from firebase_admin import db

cred = credentials.Certificate("src/authorizer-e6ee1-firebase-adminsdk-lfar5-1f639a65a3.json")
firebase_admin.initialize_app(cred)


def get_path_by_title(reference_path, field_name, search_value):
    try:
        ref = db.reference(reference_path)
        
        query = ref.order_by_child(field_name).equal_to(search_value)
        
        results = query.get()
        
        if results:
            for key in results.keys():
                full_path = f"{reference_path}/{key}"
                return full_path
        else:
            print(f"No results found for {search_value} in {field_name}.")
    except Exception as e:
        print(f"An error occurred: {e}")
    return None

def get_full_news_from_realtime_db(title):

    reference_path = f"{get_path_by_title("news", "title", title)}/article"
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

def gemini_summarizer(title, english_level, bullet_point = False):
    model = genai.GenerativeModel(model_name="gemini-1.5-flash")

    news_article = get_full_news_from_realtime_db(title)
    summary_path = f"{get_path_by_title("news", "title", title)}/summary"

    if bullet_point:
        response = model.generate_content([news_article, "Can you summarize this article as a bulleted list and also give key points?"])

    elif not bullet_point:
        prompt = f"Can you summarize this article with {str(english_level)} level english?"
        response = model.generate_content([news_article, prompt])
    
    try:
        # Reference to the specific location in the Realtime Database
        ref = db.reference(summary_path)
        
        # Set the data at the reference path
        ref.set(response)
        print(f"Data written successfully to {summary_path}")
    except Exception as e:
        print(f"An error occurred: {e}")
