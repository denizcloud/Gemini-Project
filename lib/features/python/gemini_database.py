import firebase_admin
from firebase_admin import firestore
from firebase_admin import credentials


app = firebase_admin.initialize_app()
db = firestore.client()


users_ref = db.collection("news")
docs = users_ref.stream()

for doc in docs:
    print(f"{doc.id} => {doc.to_dict()}")
