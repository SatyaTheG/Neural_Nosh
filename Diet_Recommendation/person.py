from random import uniform as rnd
from generator import Generator

class Person:
    def __init__(self, age, height, weight, gender, activity, meals_calories_perc, weight_loss):
        self.age = age
        self.height = height
        self.weight = weight
        self.gender = gender
        self.activity = activity
        self.meals_calories_perc = meals_calories_perc
        self.weight_loss = weight_loss

    def calculate_bmi(self):
        bmi = round(self.weight / ((self.height / 100) ** 2), 2)
        return bmi

    def display_result(self):
        bmi = self.calculate_bmi()
        bmi_string = f'{bmi} kg/m²'
        if bmi < 18.5:
            category = 'Underweight'
        elif 18.5 <= bmi < 25:
            category = 'Normal'
        elif 25 <= bmi < 30:
            category = 'Overweight'
        else:
            category = 'Obesity'
        return bmi_string, category

    def calculate_bmr(self):
        if self.gender == 'Male':
            bmr = 10 * self.weight + 6.25 * self.height - 5 * self.age + 5
        else:
            bmr = 10 * self.weight + 6.25 * self.height - 5 * self.age - 161
        return bmr

    def calories_calculator(self):
        activites = ['Little/no exercise', 'Light exercise', 'Moderate exercise (3-5 days/wk)',
                     'Very active (6-7 days/wk)', 'Extra active (very active & physical job)']
        weights = [1.2, 1.375, 1.55, 1.725, 1.9]
        weight = weights[activites.index(self.activity)]
        maintain_calories = self.calculate_bmr() * weight
        return maintain_calories

    def generate_recommendations(self):
        total_calories = self.weight_loss * self.calories_calculator()
        recommendations = []
        for meal in self.meals_calories_perc:
            meal_calories = self.meals_calories_perc[meal] * total_calories
            if meal == 'breakfast':
                recommended_nutrition = [meal_calories, rnd(10, 30), rnd(0, 4), rnd(0, 30), rnd(0, 400),
                                          rnd(40, 75), rnd(4, 10), rnd(0, 10), rnd(30, 100)]
            elif meal == 'launch':
                recommended_nutrition = [meal_calories, rnd(20, 40), rnd(0, 4), rnd(0, 30), rnd(0, 400),
                                          rnd(40, 75), rnd(4, 20), rnd(0, 10), rnd(50, 175)]
            elif meal == 'dinner':
                recommended_nutrition = [meal_calories, rnd(20, 40), rnd(0, 4), rnd(0, 30), rnd(0, 400),
                                          rnd(40, 75), rnd(4, 20), rnd(0, 10), rnd(50, 175)]
            else:
                recommended_nutrition = [meal_calories, rnd(10, 30), rnd(0, 4), rnd(0, 30), rnd(0, 400),
                                          rnd(40, 75), rnd(4, 10), rnd(0, 10), rnd(30, 100)]
            generator = Generator(recommended_nutrition)
            recommended_recipes = generator.generate()
            recommendations.append(recommended_recipes)
        # for recommendation in recommendations:
        #     for recipe in recommendation:
        #         recipe['image_link'] = find_image(recipe['Name'])
        return recommendations
    

class Display:
    def __init__(self):
        self.plans = ["Maintain weight", "Mild weight loss", "Weight loss", "Extreme weight loss"]
        self.weights = [1, 0.9, 0.8, 0.6]
        self.losses = ['-0 kg/week', '-0.25 kg/week', '-0.5 kg/week', '-1 kg/week']
        pass

    def display_bmi(self, person):
        bmi_string, category = person.display_result()
        return f'Body Mass Index (BMI): {bmi_string}\nCategory: {category}\nHealthy BMI range: 18.5 kg/m² - 25 kg/m².'

        # print(f'Body Mass Index (BMI): {bmi_string}')
        # print(f'Category: {category}')
        # print('Healthy BMI range: 18.5 kg/m² - 25 kg/m².')

    def display_calories(self, person):
        maintain_calories = person.calories_calculator()
        result = 'The results show a number of daily calorie estimates that can be used as a guideline for how many ' \
                 'calories to consume each day to maintain, lose, or gain weight at a chosen rate.\n'
        for plan, weight, loss in zip(self.plans, self.weights, self.losses):
            result += f'{plan}: {round(maintain_calories * weight)} Calories/day, Loss: {loss}\n'
        return result

        # print('The results show a number of daily calorie estimates that can be used as a guideline for how many '
        #       'calories to consume each day to maintain, lose, or gain weight at a chosen rate.')
        # for plan, weight, loss in zip(self.plans, self.weights, self.losses):
        #     print(f'{plan}: {round(maintain_calories * weight)} Calories/day, Loss: {loss}')

    def display_recommendation(self, person, recommendations):
        meals = person.meals_calories_perc
        result = 'Recommended recipes:\n'
        # print('Recommended recipes:')
        for meal_name, recommendation in zip(meals, recommendations):
            result += f'{meal_name.upper()}:\n'
            # print(f'{meal_name.upper()}:')
            for recipe in recommendation:
                recipe_name = recipe['Name']
                # recipe_link = recipe['image_link']
                result += f'  {recipe_name}\n'
                # print(f'  {recipe_name}')  
        return result          