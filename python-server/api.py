from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/api/symptoms', methods = ['GET'])
def symptoms():
    # TODO generate list of symptoms here
    return jsonify(all_symptoms=['a', 'b', 'c'])

@app.route('/api/diagnose', methods = ['POST'])
def diagnose():
    # TODO genearate list of symptoms here
    data = request.json
    symptoms = data['objawy']
    print(f'Received data: {symptoms}')
    return jsonify(data=data)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)