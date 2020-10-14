import json
from os import path

dir_path = path.dirname(__file__)

from datetime import date

def calculate_Age(birthDate):
    days_in_year = 365.2425
    age = int((date.today() - birthDate).days / days_in_year)
    return age

def calculate_birthYear(birthDate,age):
    days_in_year = 365.2425
    birthYear = (age * days_in_year - (date.today() - birthDate).days) / days_in_year
    return int(birthDate.year - birthYear)


with open(f'{dir_path}\\dataset\\pessoas.json', 'r' , encoding='utf-8') as file:
    data = json.load(file)
    # b
    print(len(data))
    c = 0
    for i in data:
        if i['idade'] == None:
            d,m,y = map(int,i['data_nasc'].split('/'))
            i['idade'] = calculate_Age(date(y,m,d))
            c += 1
            print(f"{c} : {i['idade']}")
        if len(i['data_nasc']) < 10:
            print(i['data_nasc'])
            d,m = map(int,i['data_nasc'].split('/'))
            y = date.today().year
            y_calc = calculate_birthYear(date(y,m,d),i['idade'])
            i['data_nasc'] = f'{d:02}/{m:02}/{y_calc}'
            c += 1
            print(f"{c} : {i['data_nasc']}")

    with open(f'{dir_path}\\data_out\\data_out.json', 'w', encoding='utf8') as outfile:
        json.dump(data, outfile, ensure_ascii=False)

import psycopg2
from config import config

params = config()

for i in range(len(data)):
    mydb = psycopg2.connect(**params)
    mycursor = mydb.cursor()
    d,m,y = data[i]['data_nasc'].split('/')
    sql = f"""
    INSERT INTO public.pessoa(
    nome
    , idade
    , data_nasc
    , sexo
    , signo
    , altura
    , peso
    , cidade
    , estado
    , cor
    , tipo_sanguineo
    )
        VALUES (
    '{data[i]['nome']}'
    , {data[i]['idade']}
    , '{y}/{m}/{d}'
    , '{data[i]['sexo']}'
    , '{data[i]['signo']}'
    , {float(str(data[i]['altura']).replace(',','.'))}
    , {float(str(data[i]['peso']).replace(',','.'))}
    , '{data[i]['cidade']}'
    , '{data[i]['estado']}'
    , '{data[i]['cor']}'
    , '{data[i]['tipo_sanguineo']}'
    );
    """

    if mycursor != None:

        try:
            mycursor.execute( sql )
            mydb.commit()

            print (f"\nfinished INSERT INTO execution \n {data[i]['nome']}")

        except (Exception, psycopg2.DatabaseError) as error:
            print(error)

        # close the cursor and connection
    mycursor.close()
    mydb.close()

