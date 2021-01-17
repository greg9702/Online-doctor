from flask import Flask, request, jsonify
from flask_cors import CORS

import diagnose_network

app = Flask(__name__)

CORS(app)

@app.route('/api/symptoms', methods = ['GET'])
def symptoms():
    all_symptoms = diagnose_network.get_all_symptoms()
    return jsonify(all_symptoms=all_symptoms)

@app.route('/api/diagnose', methods = ['POST'])
def diagnose():
    data = request.json
    symptoms = data['symptoms']
    age = int(data['age'])
    temperature = int(data['temperature'])
    diagnose = diagnose_network.get_diagnose(age, temperature, symptoms)

    return_array = []
    if diagnose != None:
        return_array.append(diagnose)

    return jsonify(diagnose=return_array)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=False)
