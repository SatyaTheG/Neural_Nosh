# Example Usage:
# Create a Person instance
from person import Person,Display
import warnings

# Filter out InconsistentVersionWarning
warnings.filterwarnings("ignore", category=UserWarning, module="sklearn")



person_info= {
    "age": 25,
    "height": 170,
    "weight": 65,
    "gender": "Male",
    "activity": "Moderate exercise (3-5 days/wk)",
    "meals_calories_perc": {"breakfast": 0.35, "lunch": 0.40, "dinner": 0.25},
    "weight_loss": 0.8
} 


person = Person(**person_info)

# Create a Display instance
display = Display()

# Display BMI
display.display_bmi(person)

# Display Calories
display.display_calories(person)

# Generate Recommendations
recommendations = person.generate_recommendations()

# Display Recommendations
display.display_recommendation(person, recommendations)