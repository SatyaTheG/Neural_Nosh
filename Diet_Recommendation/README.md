# Preventive healthCare🧑‍⚕️
The project aims to develop a groundbreaking solution for personalized nutrition in the digital age. With an increasing focus on health and well-being, address the need for tailored dietary recommendations based on individual health metrics by seamlessly integrating BMI data.

NeuralNosh harnesses the power of machine learning algorithms to provide users with precise and targeted food suggestions. Our platform not only empowers users to make informed dietary choices but also educates them on nutrition and healthy eating habits. With its intuitive interface, virtual assistant and comprehensive features.

## Clone Repo And use it
* Clone NeuralNosh repo using below command
```git
git clone https://github.com/SatyaTheG/NeuralNosh.git
```

## Installation Steps

```bash
  pip install -r requirements.txt
```

## Execution Steps

=> Just locate your Command Prompt or Powershell to Project Folder

=> Run the following command to activate the flask API server

```bash
  python app.py
```

=> Here we have an endpoint "/calculate_recommendations".

=> To use the service of API, you have give the following inputs to PostMan...

1. Create a new request with POST method and http://127.0.0.1:5000/calculate_recommendations

2. In Body tab move to raw tab, enter format as "JSON" and give input in below format.
   ```bash
    {"person_info":{
      "age": 25,
      "height": 170,
      "weight": 65,
      "gender": "Male",
      "activity": "Moderate exercise (3-5 days/wk)",
      "meals_calories_perc": {"breakfast": 0.35, "lunch": 0.40, "dinner": 0.25},
      "weight_loss": 0.8}
   }
   ```
3. Enjoy with your results with daily tailored deitary recommendations.   
