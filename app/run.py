import os
from MySQLdb import Date

from flask import Flask, render_template, request, redirect, url_for
from flask.helpers import flash
from flask.wrappers import Request
from flask_mysqldb import MySQL
import datetime


# First, we'll import pandas, a data processing and CSV file I/O library
import pandas as pd
import numpy as np


from scipy.stats import pearsonr
from sklearn.linear_model import LinearRegression
#from sklearn import cross_validation, tree, linear_model
from sklearn.model_selection import train_test_split

#from sklearn.model_selection import train_test_split
#from sklearn.cross_validation import ShuffleSplit
from sklearn.metrics import explained_variance_score
from sklearn.model_selection import learning_curve   
from time import time
from sklearn.metrics import r2_score

from sklearn.preprocessing import StandardScaler, MinMaxScaler
from sklearn import preprocessing
min_max_scaler = preprocessing.MinMaxScaler()

import pickle
import random

app = Flask(__name__)

# Mariadb connection
app.config['MYSQL_HOST']= os.environ.get('DB_HOST','0.0.0.0') 
app.config['MYSQL_USER']= os.environ.get('DB_USER','root')
app.config['MYSQL_PASSWORD']= os.environ.get('DB_PASSWORD','rootAPP')
app.config['MYSQL_DB']= os.environ.get('DB_NAME','beers_apps')
app.config['APP_ALIAS_HOST']= os.environ.get('APP_ALIAS_HOST','app1')
app.config['MYSQL_PORT']= int(os.environ.get('DB_PORT','3308'))
print(app.config['MYSQL_PORT'])
mysql = MySQL(app)

app.config['PICKLE_FOLDER']= os.environ.get('PICKLE_FOLDER','/home/yesid')
#settings
app.secret_key = 'mysecretkey'


@app.route("/")
@app.route("/index")
def Index():
    return render_template('/index.html', alias= app.config['APP_ALIAS_HOST'])

@app.route("/add_contact", methods=['POST'])
def add_contact():
    print('add_contact')
    fullName = request.form['fullName']
    country = request.form['country']
    yearsOld = request.form['yearsOld']
    gender = request.form.get('gender')
    typeBeer = request.form.get('typeBeer')
    lupulo = request.form.get('lupulo')
    alcohol = request.form.get('alcohol')

    value = lupulo.split('-')
    lupulo_rand = random.uniform(float(value[0]), float(value[1]))

    cur = mysql.connection.cursor()
    cur.execute('INSERT INTO contactos(full_name, country, years_old, gender, type_beer, lupulo, alcohol) VALUES (%s, %s, %s, %s, %s, %s, %s)',
    (fullName, country, yearsOld, gender, typeBeer, lupulo_rand, alcohol))  
    mysql.connection.commit()
    flash('Información agregada satisfactoriamente')
    return redirect(url_for('Index'))

@app.route("/consulta")
def consulta():
    cur = mysql.connection.cursor()
    cur.execute('SELECT * FROM contactos')
    data = cur.fetchall()
    print(data)
    return render_template('/consulta.html', contactos = data)

@app.route("/delete")
def delete_contact():
    return 'delete contact'


@app.route("/trainer")
def add_trainer():
    #entrenar
    metrica, dataset, file_name = trainer()
    cur = mysql.connection.cursor()
    cur.execute('INSERT INTO entrenamiento(metricas_desempenio, tamanio_dataset, file_name) VALUES (%s, %s, %s)',
    (metrica, dataset, file_name)) 
    mysql.connection.commit()
    flash('Información de entrenamiento agregada satisfactoriamente')
    return redirect(url_for('/'))

@app.route("/consulta-trainers")
def consultaTrainer():
    last_trainer = load_last_trainer()
    response = { 'metricas_desempenio': last_trainer[0], 'tamanio_dataset':last_trainer[1],
     'fecha_entrenamiento':last_trainer[2]} if last_trainer != None else "not have trainer"
    return  response, 200

@app.route("/predict")
def predict():
    edad = 43
    genero = 1
    lupulo = 0.04
    alchol = 0.03
    data = load_last_trainer()
    file = data[3]
    model = load_model(file)
    predict = model.predict([[edad, genero, lupulo, alchol]])
    return predict[0], 200 

def persist_model(model):
    file_name = 'trainer-{}.sav'.format(datetime.datetime.now().strftime('%d-%m-%Y-%H-%M-%S'))
    pickle.dump(model, open("{}/{}".format(app.config['PICKLE_FOLDER'],file_name), 'wb'))
    return file_name

def load_model(file):
    return pickle.load(open("{}/{}".format(app.config['PICKLE_FOLDER'], file), 'rb'))

def load_last_trainer():
    cur = mysql.connection.cursor()
    cur.execute('SELECT metricas_desempenio, tamanio_dataset,fecha_entrenamiento, file_name FROM beers_apps.entrenamiento order by fecha_entrenamiento desc limit 1;')
    data = cur.fetchall()
    return data[0] if len(data) > 0 else None

def trainer():
    data = pd.read_sql_query("SELECT * FROM contactos;",mysql.connection)
    tamanioDataset = data.shape[0]
    # declaracion de modelo y clase
    features = ['years_old', 'gender', 'lupulo','alcohol']
    X = data[features] 
    y = data['type_beer']

    # declaracion del tamanio del aprendisaje en este saso tomamos el 30 porciento del dataset para entrenamiento
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3)
    
    # metodos de entrenamiento implementacion
    from sklearn.neighbors import KNeighborsClassifier

    # use 5 neighors
    knn = KNeighborsClassifier(n_neighbors=12)

    # train the model
    knn.fit(X_train, y_train)

    # metricas 
    from sklearn.metrics import accuracy_score, confusion_matrix
    acc = knn.score(X_test, y_test)
    accuracy = ((acc*100).round(2))
    print(f'Accuracy: {(acc*100).round(2)}%')


    # ????
    pred = knn.predict(X_test)

    #muestra el porcentaje del aprendisaje con los datos
    from sklearn.metrics import classification_report
    print(classification_report(y_test, pred))
    file_name = persist_model(knn)
    #edad, genero, lupulo, alchol
    #knn.predict([[43, 1, 0.04, 0.03]])
    #Abrahan McMechan	Japan	43	1	Malta_saborizada	0.0440	0.0300
    #Abba Shellum	France	47	1	Oscura	0.1517	0.0588
    return (accuracy, tamanioDataset, file_name)
    

if __name__ == '__main__':
    app.run(host='0.0.0.0',debug=True)