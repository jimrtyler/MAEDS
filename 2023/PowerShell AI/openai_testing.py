# Testing image generation for Python, pretty neat IMO but not powershell ;)
# Will have to install openai and or requests via pip or pip3
import openai
import requests
generate_this = input("What image do you want generated?")
openai.api_key_path = ".\APIKeys.txt"
openai.Model.list()
completion = openai.Image.create(prompt=generate_this,n=1,size="1024x1024")
image_url = completion['data'][0]['url']
img_data = requests.get(image_url).content
with open('generated.jpg','wb') as handler:
    handler.write(img_data)

