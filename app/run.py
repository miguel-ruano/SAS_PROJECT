import os

from flask import Flask, render_template, request, redirect, url_for
from flask.helpers import flash
from flask.wrappers import Request
from flask_mysqldb import MySQL

app = Flask(__name__)

# Mariadb connection
app.config['MYSQL_HOST']= os.environ.get('DB_HOST','localhost') 
app.config['MYSQL_USER']= os.environ.get('DB_USER','root')
app.config['MYSQL_PASSWORD']= os.environ.get('DB_PASSWORD','root')
app.config['MYSQL_DB']= os.environ.get('DB_NAME','beers_apps')
app.config['APP_ALIAS_HOST']= os.environ.get('APP_ALIAS_HOST','app1')
mysql = MySQL(app)

#settings
app.secret_key = 'mysecretkey'


@app.route("/")
@app.route("/index")
def Index():
    return render_template('/index.html', alias= app.config['APP_ALIAS_HOST'])

@app.route("/add_contact", methods=['POST'])
def add_contact():
    if request.method == 'POST':
        nombre = request.form['nombre']
        telefono = request.form['telefono']
        correo = request.form['correo']
        preg1 = request.form.get('olor')
        preg2 = request.form.get('color')
        preg3 = request.form.get('sabor')
        preg4 = request.form.get('artesanal')
        preg5 = request.form.get('lupulo')
        preg6 = request.form.get('aditivos')
        preg7 = request.form.get('tipoaditivos')
        preg8 = request.form.get('porcentaje')    

        print(nombre)
        print(telefono)
        print(correo)              

        cur = mysql.connection.cursor()
        cur.execute('INSERT INTO contactos(nombre, telefono, correo, R_pregunta1, R_pregunta2, R_pregunta3, R_pregunta4, R_pregunta5, R_pregunta6, R_pregunta7, R_pregunta8) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)',
        (nombre, telefono, correo, preg1, preg2, preg3, preg4, preg5, preg6, preg7, preg8))  

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


if __name__ == '__main__':
    app.run(host='0.0.0.0')