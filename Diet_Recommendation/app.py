from flask import Flask, request, jsonify
from app import app
from person import Person, Display
import warnings

# Filter out InconsistentVersionWarning
warnings.filterwarnings("ignore", category=UserWarning, module="sklearn")

app = Flask(__name__)

@app.route('/')
def index():
    return "Hello world"

@app.route('/calculate_recommendations', methods=['POST'])
def calculate_recommendations():
    try:
        data = request.get_json()
        # data = request.form.get('data')
        person = Person(**data['person_info'])
        display = Display()

        bmi_result = display.display_bmi(person)
        calories_result = display.display_calories(person)
        recommendations = person.generate_recommendations()
        output = display.display_recommendation(person, recommendations)

        response = {
            'bmi_result': bmi_result,
            'calories_result': calories_result,
            'recommendations': output
        }

        return jsonify(response)
    except Exception as e:
        return jsonify({'error': str(e)}), 500


if __name__ == '__main__':
    app.run(debug=True)