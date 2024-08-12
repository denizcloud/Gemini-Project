import os
import google.generativeai as genai
import numpy as np
from sklearn.metrics.pairwise import cosine_similarity

categories = [
    'asia', 'australia', 'business', 'china', 'entertainment', 'europe',
    'health', 'india', 'middleeast', 'politics', 'science', 'sport',
    'style', 'travel', 'us', 'world'
]

def get_embedding(text):
    result = genai.embed_content(
        model="models/text-embedding-004",
        content=text,
        task_type="retrieval_document",
        title="Embedding of single string")
    return result['embedding']

def analyze_categories(text, threshold_percentage=8, sharpening_factor=20):
    text_embedding = get_embedding(text)
    category_embeddings = {cat: get_embedding(cat) for cat in categories}

    similarities = {cat: cosine_similarity([text_embedding], [emb])[0][0] 
                    for cat, emb in category_embeddings.items()}

    sharpened_similarities = {cat: sim ** sharpening_factor for cat, sim in similarities.items()}

    total_similarity = sum(sharpened_similarities.values())
    percentages = {cat: (sim / total_similarity) * 100 for cat, sim in sharpened_similarities.items()}
    
    filtered_percentages = {cat: pct for cat, pct in percentages.items() if pct >= threshold_percentage}
    
    if filtered_percentages:
        total_filtered = sum(filtered_percentages.values())
        normalized_percentages = {cat: (pct / total_filtered) * 100 for cat, pct in filtered_percentages.items()}
    else:
        normalized_percentages = {"other": 100}
        
    return normalized_percentages

text = """
I'm mostly interested in news about donald trump, physics, and playing basketball. Also recommend me stuff about going to gym and playing football.
"""

result = analyze_categories(text, sharpening_factor=5)
print(f"Text: {text}")
print("Category Percentages:")
for category, percentage in sorted(result.items(), key=lambda x: x[1], reverse=True):
    print(f"{category}: {percentage:.2f}%")
