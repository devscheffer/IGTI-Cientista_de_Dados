import json
from os import path

dir_path = path.dirname(__file__)

with open(f'{dir_path}\\dataset\\videogame_sales_mongo.json', 'r' , encoding='utf-8') as file:
    data = json.load(file)

    import psycopg2
    from config import config

    params = config()
    total = len(data)
    c = 0
    print(total)
    for i in range(len(data)):
        mydb = psycopg2.connect(**params)
        mycursor = mydb.cursor()
        name = str(data[i]['Name']).replace('\'','')
        publisher = str(data[i]['Publisher']).replace('\'','')
        sql = f"""
        INSERT INTO public.game(
    id, rank, name, platform, year, genre, publisher, na_sales, eu_sales, jp_sales, other_sales, global_sales)
    VALUES (
        '{data[i]['_id']['$oid']}'
        , {data[i]['Rank']}
        , '{name}'
        , '{str(data[i]['Platform'])}'
        , '{data[i]['Year']}'
        , '{str(data[i]['Genre'])}'
        , '{publisher}'
        , {data[i]['NA_Sales']}
        , {data[i]['EU_Sales']}
        , {data[i]['JP_Sales']}
        , {data[i]['Other_Sales']}
        , {data[i]['Global_Sales']}
        );
        """
        if mycursor != None:

            try:
                mycursor.execute( sql )
                c += 1
                print (f"\nfinished INSERT INTO execution \n {data[i]['Name']}\nProgress: {c/total*100:.2f}% - {total - c}")

            except (Exception, psycopg2.DatabaseError) as error:
                print(error)
                print(data[i])
                mydb.rollback()
                break
            finally:
                mydb.commit()
            # close the cursor and connection
        mycursor.close()
        mydb.close()

