from fastapi import FastAPI
from transformers import pipeline 

app = FastAPI()

pipe = pipeline("text2text-generation", model="google/flan-t5-small")

@app.get("/")
def home():
    return {"message":"Hello world!!"}

@app.get("/generate")
def generate(text:str):
    # use pipeline to generate text from given input text
    output = pipe(text)
    # return generated text in json
    return {"output":output[0]['generated_text']}