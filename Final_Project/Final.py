import sqlite3
from sqlite3 import Error

# the current number of reviewkeys in the database
num_reviewKeys = 59

def openConnection(_dbFile):
    # print("++++++++++++++++++++++++++++++++++")
    # print("Open database: ", _dbFile)

    conn = None
    try:
        conn = sqlite3.connect(_dbFile)
        # print("success")
    except Error as e:
        print(e)

    # print("++++++++++++++++++++++++++++++++++")

    return conn

def closeConnection(_conn, _dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Close database: ", _dbFile)

    try:
        _conn.close()
        print("success")
    except Error as e:
        print(e)

    # print("++++++++++++++++++++++++++++++++++")

def createBasket(_conn):
    try:
        restaurant = input("\nEnter a restaurant: ")

        # get the menukey for that restaurant
        sql = """select menukey
                from restaurant
                where name = ?"""

        cur = _conn.cursor()
        cur.execute(sql, [restaurant])

        # save the menukey into menu_Key
        rows = cur.fetchall()
        for row in rows:
            l = '{:1}'.format(row[0])
        menu_Key = "" + l

        # vars to use for the basket list
        item = "" # user input
        counter = 1 # label the number of items in the list
        counterString = str(counter) + "" # string form of the labeled list
        totalCost = 0.0 # total cost of the basket
        # prompt user to continue adding items to basket or 'f' for finish
        while item != "f":
            print("\nSelect an item:\n")

            # print the restaurant as a title for the menu
            format = '{:>20}'.format(restaurant)
            print(format + " MENU\n")

            # print the column headings
            l = '{:30} {:>10}'.format("ITEM", "COST")
            print(l + "\n" + "-----------------------------------------")

            # get the menu from that restaurant
            sql = """select *
                    from menu
                    where menukey = ?"""

            cur = _conn.cursor()
            cur.execute(sql, [menu_Key])
            rows = cur.fetchall()

            # print the menu
            for row in rows:
                l = '{:30} {:>7}'.format(row[0], row[1]) # 7 b/c numbered list takes up 3 chars
                print(counterString + ". " + l)
                counter += 1
                counterString = str(counter) + ""
            # reset the counters
            counter = 1
            counterString = str(counter) + ""
            print("f. finish \n")

            # get the item
            item = input("User Input: ")

            # get the costs only if user doesn't choose 'f'
            if item != "f":
                # get the cost of the item
                sql = """select menu.cost
                        from menu
                        where item = ?"""
                cur = _conn.cursor()
                cur.execute(sql, [item])

                rows = cur.fetchall()
                for row in rows:
                    l = '{:1}'.format(row[0])
                cost = "" + l

                # update the totalCost of the basket
                totalCost += float(cost)

                # insert that item into basket table
                sql = """insert into basket(item, cost)
                            values (?, ?);"""

                cur = _conn.cursor()
                cur.execute(sql, (item, cost))      

                # basket title
                print("")
                format = '{:>27}'.format("YOUR BASKET")
                print(format + "\n")

                # print the column headings
                l = '{:30} {:>10}'.format("ITEM", "COST")
                print(l + "\n" + "-----------------------------------------")

                # display the current basket
                sql = "select * from basket"
                cur = _conn.cursor()
                cur.execute(sql)

                rows = cur.fetchall()
                for row in rows:
                    l = '{:30} {:>7}'.format(row[0], row[1])
                    print(counterString + ". " + l)
                    counter += 1
                    counterString = str(counter) + ""

                # reset the counters
                counter = 1
                counterString = str(counter) + ""
                # print total
                l = '{:>41}'.format("TOTAL: " + str(totalCost))
                print(l)

        # clear the basket when the user is finished
        sql = "DROP TABLE basket"
        cur = _conn.cursor()
        cur.execute(sql)

        sql = """CREATE TABLE basket (
                item varchar(30),
                cost decimal(5, 2)
                );"""
        cur = _conn.cursor()
        cur.execute(sql)
        
        run(_conn)

    except Error as e:
        print(e)

# ********************************** SEARCHBY FUNCTION ********************************** #
# user picks how to search for restaurant...
def searchBy(_conn):
    # option menu
    print("\nSearch by: \n"
    + "1. ...Restaurant \n"
    + "2. ...Review \n"
    + "3. ...Location \n"
    + "4. ...Price Range \n"
    + "b. back \n")

    # get user input 
    choice = input("User Input: ")

    # 
    try:

        # user selects '...Restaurant' 
        if choice == "1":
            print ("\nRESTAURANT SEARCH\n")
            temp = input("Enter Restaurant: ")

            print("")

            sql = """select name, pricing, address
                     from restaurant r, location l
                     where r.locationkey = l.locationkey
                        and name = ?"""

            cur = _conn.cursor()
            cur.execute(sql, [temp])

            l = '{:20} {:20} {:20}' .format("RESTAURANT", "PRICING", "ADDRESS")
            print(l)
            print("----------------------------------------------------------------------------------")

            rows = cur.fetchall()
            for row in rows:
                l = '{:20} {:20} {:20}' .format(row[0], row[1], row[2])
                print(l)
            
            addInfo(_conn, temp)
            #searchBy(_conn) 

        # user selects '...Reviews'
        elif choice == "2":
            print ("\nREVIEW SEARCH\n")
            temp = input("Enter Stars: ")

            print("")

            sql = """select r.name, user, stars
                     from restaurant r, customer c, reviews rev
                     where rev.reviewkey = c.reviewkey
                        and c.restaurantkey = r.restaurantkey
                        and stars = ?;"""

            cur = _conn.cursor()
            cur.execute(sql, (temp))

            l = '{:30} {:20} {:20}' .format("RESTAURANT", "USER", "STARS")
            print(l)
            print("---------------------------------------------------------------")

            rows = cur.fetchall()
            for row in rows:
                l = '{:30} {:20} {:5}' .format(row[0], row[1], row[2])
                print(l) 

            searchBy(_conn) 

        # user selects '...Location'
        elif choice == "3":
            print ("\nLOCATION SEARCH\n")
            temp = input("Enter Location(input '%' before and after): ")

            print("")

            sql = """select name, address
                     from restaurant r, location l
                     where r.locationkey = l.locationkey
                        and address LIKE ?;"""

            cur = _conn.cursor()
            cur.execute(sql, [temp])

            l = '{:30} {:20}' .format("RESTAURANT", "ADDRESS")
            print(l)
            print("----------------------------------------------------------------------------------")

            rows = cur.fetchall()
            for row in rows:
                l = '{:30} {:20} ' .format(row[0], row[1])
                print(l) 

            searchBy(_conn) 

        # user selects '...Price Range'
        elif choice == "4":
            print ("\nPRICE RANGE SEARCH\n")
            temp = input("Enter Pricing: ")

            print("")

            sql = """select name, pricing, address
                     from restaurant r, location l
                     where r.locationkey = l.locationkey
                        and pricing = ?"""

            cur = _conn.cursor()
            cur.execute(sql, [temp])

            l = '{:32} {:20} {:5}' .format("RESTAURANT", "PRICING", "ADDRESS")
            print(l)
            print("----------------------------------------------------------------------------------")

            rows = cur.fetchall()
            for row in rows:
                l = '{:32} {:20} {:5}' .format(row[0], row[1], row[2])
                print(l) 

            searchBy(_conn) 

        # user selects 'back'
        elif choice == "b":
            run(_conn)

        else:
            searchBy(_conn)

    except Error as e:
        print(e)

# ********************************** ADDINFO FUNCTION ********************************** #
# choice given after user uses search by 
def addInfo(_conn, temp):
    print("\nView Additional Info: \n"
    + "(y). yes \n"
    + "(n). no \n")

    choice = input("User Input: ")

    try:
        # user input is yes
        if choice == "y":
            print("\nOptions: \n"
            + "1. View Menu\n"
            + "2. View Reviews\n")

            c2 = input("User Input: ")
            print("")

            # user picks to view menu
            if c2 == "1":
                sql = """SELECT item, cost
                         FROM menu m, restaurant r
                         WHERE m.menukey = r.menukey
                            AND name = ?"""
                
                args = [temp]

                cur = _conn.cursor()
                cur.execute(sql, args)

                l = '{:30} {:10}'.format("ITEM", "COST")
                print(l)
                print("---------------------------------------")

                rows = cur.fetchall()
                for row in rows:
                    l = '{:30} {:0}'.format(row[0], row[1])
                    print(l)

                searchBy(_conn)

            # user picks reviews
            elif c2 == "2":
                sql = """SELECT user, stars
                         FROM restaurant r, customer c, reviews rev
                         WHERE r.restaurantkey = c.restaurantkey
                            AND c.reviewkey = rev.reviewkey
                            AND r.name = ?"""

                args = [temp]

                cur = _conn.cursor()
                cur.execute(sql, args)

                l = '{:30} {:10}'.format("USER", "STARS")
                print(l)
                print("---------------------------------------")

                rows = cur.fetchall()
                for row in rows:
                    l = '{:30} {:0}'.format(row[0], row[1])
                    print(l)
                
                searchBy(_conn)

        elif choice == "n":
            searchBy(_conn)

    except Error as e:
        print(e)

# ********************************** INS_DEL_UPD FUNCTION ********************************** #
def ins_Del_Upd(_conn):
    # get the current number of review keys
    global num_reviewKeys

    try:
        print("\nSelect an option for your review: \n"
        + "1. insert \n"
        + "2. delete \n"
        + "3. update \n"
        + "b. back")    

        # get user input
        temp = input("User input: ")
        
        # if user chooses the insert option
        if(temp == "1"):
            restaurant = input("\nEnter a restaurant: ")

            # get the restaurantkey
            sql = """select restaurantkey
                    from restaurant
                    where name = ?"""

            cur = _conn.cursor()
            cur.execute(sql, [restaurant])

            # save the restaurantkey into restaurant
            rows = cur.fetchall()
            for row in rows:
                l = '{:1}'.format(row[0])
            restaurant_Key = "" + l

            name = input("\nEnter your name: ")
            stars = input("Enter your stars rating: ")            

            # insert the new review
            sql = """insert into reviews(user, stars, reviewkey)
                    values (?, ?, ?);"""

            num_reviewKeys += 1
            cur = _conn.cursor()
            cur.execute(sql, (name, stars, num_reviewKeys))     

            # insert to connect the review through customer
            sql = """insert into customer(name, restaurantkey, reviewkey)
                    values (?, ?, ?);"""

            cur = _conn.cursor()
            cur.execute(sql, (name, restaurant_Key, num_reviewKeys))

            print("\nInsert Success!")

            ins_Del_Upd(_conn)

        # if user chooses the delete option
        elif(temp == "2"):
            reviewkey = input("\nEnter your reviewkey: ")

            sql = """delete from reviews
                    where reviewkey = ?;"""

            cur = _conn.cursor()
            cur.execute(sql, [reviewkey])

            # change the customer's reviewkey to 0 since it's gone
            sql = """update customer
                    set reviewkey = 0
                    where reviewkey = ?"""
            cur = _conn.cursor()
            cur.execute(sql, [reviewkey])

            print("Delete Success!")

            ins_Del_Upd(_conn)

        # if user chooses the update option
        elif(temp == "3"):
            reviewkey = input("\nEnter your reviewkey: ")
            stars = input("Enter the updated number of stars: ")

            sql = """update reviews
                    set stars = ?
                    where reviewkey = ?;"""

            cur = _conn.cursor()
            cur.execute(sql, (stars, reviewkey))

            print("Update Success!")

            ins_Del_Upd(_conn)

        elif(temp == "b"):
            run(_conn)
        
        else:
            ins_Del_Upd(_conn)

    except Error as e:
        print(e)

# ********************************** ORDERBY FUNCTION ********************************** #
def orderBy(_conn):
    print("\nSelect an option to order by: \n"
    + "1. name \n"
    + "2. pricing \n"
    + "3. reviews \n"
    + "4. country \n"
    + "b. back \n")

    # get user input
    temp = input("User input: ")

    try:

        # if ordering by name
        if temp == "1":
            print("\nSelect an option to order by alphabetically: \n"
                + "1. ascending \n"
                + "2. descending \n")
            temp = input("User input: ")
            # if ordering by name ASC
            if temp == "1":
                sql = """select restaurant.name
                        from restaurant
                        order by name ASC;"""

                cur = _conn.cursor()
                cur.execute(sql)

                # print the column headings
                l = '{}'.format("\nRESTAURANT NAME")
                print(l + "\n" + "---------------")

                # print that entire specified table
                rows = cur.fetchall()
                for row in rows:
                    l = '{}'.format(row[0])
                    print(l)

            # else if ordering by name DESC
            elif temp == "2":
                sql = """select restaurant.name
                        from restaurant
                        order by name DESC;"""

                cur = _conn.cursor()
                cur.execute(sql)

                # print the column headings
                l = '{}'.format("\nRESTAURANT NAME")
                print(l + "\n" + "---------------")

                # print that entire specified table
                rows = cur.fetchall()
                for row in rows:
                    l = '{}'.format(row[0])
                    print(l)

            orderBy(_conn)

        # else if ordering by pricing
        elif temp == "2":
            print("\nSelect an option to order by price: \n"
                            + "1. ascending \n"
                            + "2. descending \n")
            temp = input("User input: ")
            # if ordering by ASC
            if temp == "1":
                sql = """select restaurant.name, restaurant.pricing
                        from restaurant
                        order by pricing ASC;"""

                cur = _conn.cursor()
                cur.execute(sql)
                print("\n")

                # print the column headings
                l = '{:30} {:>10}'.format("RESTAURANT NAME", "PRICE")
                print(l + "\n" + "-----------------------------------------")

                # print that entire specified table
                rows = cur.fetchall()
                for row in rows:
                    l = '{:30} {:>10}'.format(row[0], row[1])
                    print(l)

            # else if ordering by DESC
            elif temp == "2":
                sql = """select restaurant.name, restaurant.pricing
                        from restaurant
                        order by pricing DESC;"""

                cur = _conn.cursor()
                cur.execute(sql)
                print("\n")

                # print the column headings
                l = '{:30} {:>10}'.format("RESTAURANT NAME", "PRICE")
                print(l + "\n" + "-----------------------------------------")

                # print that entire specified table
                rows = cur.fetchall()
                for row in rows:
                    l = '{:30} {:>10}'.format(row[0], row[1])
                    print(l)

            orderBy(_conn)

        # else if ordering by reviews
        elif temp == "3":
            print("\nSelect an option to order by stars: \n"
                            + "1. ascending \n"
                            + "2. descending \n")
            temp = input("User input: ")
            # if ordering by ASC
            if temp == "1":
                sql = """select restaurant.name, round(avg(stars), 2)
                        from restaurant, customer, reviews
                        where restaurant.restaurantkey = customer.restaurantkey
                            and customer.reviewkey = reviews.reviewkey
                        group by restaurant.name
                        order by avg(stars) ASC;"""

                cur = _conn.cursor()
                cur.execute(sql)
                print("\n")

                # print the column headings
                l = '{:30} {:>10}'.format("RESTAURANT NAME", "STARS RATING")
                print(l + "\n" + "-------------------------------------------")

                # print that entire specified table
                rows = cur.fetchall()
                for row in rows:
                    l = '{:30} {:>10}'.format(row[0], row[1])
                    print(l)

            # if ordering by DESC
            elif temp == "2":
                sql = """select restaurant.name, round(avg(stars), 2)
                        from restaurant, customer, reviews
                        where restaurant.restaurantkey = customer.restaurantkey
                            and customer.reviewkey = reviews.reviewkey
                        group by restaurant.name
                        order by avg(stars) DESC;"""

                cur = _conn.cursor()
                cur.execute(sql)
                print("\n")

                # print the column headings
                l = '{:30} {:>10}'.format("RESTAURANT NAME", "STARS RATING")
                print(l + "\n" + "-------------------------------------------")

                # print that entire specified table
                rows = cur.fetchall()
                for row in rows:
                    l = '{:30} {:>10}'.format(row[0], row[1])
                    print(l)

            orderBy(_conn)

        # order by country
        elif temp == "4":
            sql = """select address
                    from restaurant, location, country
                    where restaurant.locationkey = location.locationkey
                        and location.countrykey = country.countrykey
                    order by location.countrykey ASC;"""

            cur = _conn.cursor()
            cur.execute(sql)
            print("\n")

            # print the column headings
            l = '{:30}'.format("ADDRESS")
            print(l + "\n" + "-------")

            # print that entire specified table
            rows = cur.fetchall()
            for row in rows:
                l = '{:30}'.format(row[0])
                print(l)

            orderBy(_conn)

        elif temp == "b":
            run(_conn)
                        
    except Error as e:
        print(e)

# ********************************** COMPAREBYPRICE FUNCTION ********************************** #
# compares the price range of two restaurants, or their ratings 
def compareBy(_conn):
    print("\nCompare by\n"
    + "1. ...Price Range\n"
    + "2. ...rating\n"
    + "b. back\n")

    choice = input("User Input: ")

    try:
        if choice == "1":
            print ("\nCOMPARE BY PRICE RANGE\n")

            first = input("Enter 1st Restaurant name: ")
            second = input("Enter 2st Restaurant name: ")
            print("")

            # get user input of 1st restaurant to compare
            sql = """SELECT res1.name, round(avg(m1.cost),2), res2.name, round(avg(m2.cost),2)
                     FROM restaurant res1, restaurant res2, menu m1, menu m2
                     WHERE m1.menukey = res1.menukey
                        AND m2.menukey = res2.menukey                
                        AND res1.name = ? 
                        AND res2.name = ?;"""
             
            cur = _conn.cursor()
            cur.execute(sql, (first, second))

            l = '{:20} {:>20}     {:<20} {:>20}'.format("RESTAURANT1", "AVERAGE1", "RESTAURANT2", "AVERAGE2")
            print(l)
            print("----------------------------------------------------------------------------------------")
        
            rows = cur.fetchall()
            for row in rows:
                l = '{:20} {:>20}     {:<20} {:>20}'.format(row[0], row[1], row[2], row[3])
                print(l)

            compareBy(_conn)
        
        elif choice == "2":
            print("\nCOMPARE BY RATINGS\n")

            first = input("Enter 1st Restaurant name: ")
            second = input("Enter 2st Restaurant name: ")

            print("")

            sql = """SELECT res1.name, round(avg(rev1.stars),2), res2.name, round(avg(rev2.stars),2)
                     FROM restaurant res1, restaurant res2, reviews rev1, reviews rev2, customer c1, customer c2
                     WHERE c1.restaurantkey = res1.restaurantkey
                        AND c2.restaurantkey = res2.restaurantkey  
                        AND c1.reviewkey = rev1.reviewkey
                        AND c2.reviewkey = rev2.reviewkey    
                        AND res1.name = ? 
                        AND res2.name = ?;"""
             
            cur = _conn.cursor()
            cur.execute(sql, (first, second))

            l = '{:20} {:>20}     {:<20} {:>20}'.format("RESTAURANT1", "STARS", "RESTAURANT2", "STARS")
            print(l)
            print("----------------------------------------------------------------------------------------")
        
            rows = cur.fetchall()
            for row in rows:
                l = '{:20} {:>20}     {:<20} {:>20}'.format(row[0], row[1], row[2], row[3])
                print(l)

            compareBy(_conn)

        elif choice == "b":
            run(_conn)

    except Error as e:
        print(e)

# ********************************** PRINTMENU FUNCTION ********************************** #
def printMenu():
    print("""                                        
          
  .   *   ..  . *  *
*  * @()Ooc()*   o  .           Select an option:
    (Q@*0CG*O()  ___            
   |\_________/|/ _ \           1. Search by  
   |  |  |  |  | / | |          2. Order by
   |  |  |  |  | | | |          3. Insert/Delete/Update Review
   |  |  |  |  | | | |          4. Compare by
   |  |  |  |  | | | |          5. Create Basket
   |  |  |  |  | | | |          6. Compare number of Restaurants
   |  |  |  |  | \_| |          7. Menu Size Filter
   |  |  |  |  |\___/           e. Exit
   |\_|__|__|_/|
    \_________/           
                                        
""")

def run(_conn):

    #print("\n")

    # declare userInput var
    userInput = ""

    printMenu()
    userInput = input("User Input: ")
    
    # user selects option 1
    if userInput == "1":
        searchBy(_conn)

    # user selects option 2
    elif userInput == "2":
        orderBy(_conn)

    # user selects option 3    
    elif userInput == "3":
        ins_Del_Upd(_conn)
    
    # user selects option 4
    elif userInput == "4":
        compareBy(_conn)

    # user selects option 5
    elif userInput == "5":
        createBasket(_conn)

    elif userInput == "6":
        countRestaurants(_conn)

    elif userInput == "7":
        menuSizeFilter(_conn)

    # user enters 'e' for exit
    elif userInput == "e":
        return

    else:
        run(_conn)

# useless query #1 - count number of restaurants in country
def countRestaurants(_conn):
    try:
        sql = """select c2.name, ifnull(sq.cnt, 0)
                from country c2
                left outer join
                -- subquery to count # of restaurants in a country, not counting the ones with 0
                (
                    select country.name, count(restaurant.name) as cnt
                    from country, restaurant, location
                    where restaurant.locationkey = location.locationkey
                        and location.countrykey = country.countrykey
                    group by country.name
                ) sq on c2.name = sq.name;"""

        cur = _conn.cursor()
        cur.execute(sql)

        # print the column headings
        l = '{:20} {:>10}'.format("\nCOUNTRY", "COUNT")
        print(l + "\n" + "------------------------------")

        rows = cur.fetchall()
        for row in rows:
            l = '{:20}{:>10}'.format(row[0], row[1])
            print(l)

        run(_conn)

    except Error as e:
        print(e)

# useless query #2 - get restaurants with menus larger than 2 items
def menuSizeFilter(_conn):
    try:
        sql = """select restaurant.name, count(menu.item) as menuSize
                from restaurant, menu
                where restaurant.menukey = menu.menukey
                group by restaurant.name
                having menuSize > 2;"""

        cur = _conn.cursor()
        cur.execute(sql)

        # print the column headings
        l = '{:30} {:>10}'.format("\nRESTAURANT", "MENU SIZE")
        print(l + "\n" + "-----------------------------------------")

        rows = cur.fetchall()
        for row in rows:
            l = '{:30}{:>10}'.format(row[0], row[1])
            print(l)

        run(_conn)

    except Error as e:
        print(e)

def main():
    database = r"data.sqlite"

    # create a database connection
    conn = openConnection(database)
    with conn:

        run(conn)

    closeConnection(conn, database)

if __name__ == '__main__':
    main()

# ******************* CURRENTLY UNUSED ********************
# def viewTables(_conn):
#     # menu for which table to view
#     print("\nSelect the table to view: \n"
#     + "1. country \n"
#     + "2. customer \n"
#     + "3. location \n"
#     + "4. menu \n"
#     + "5. restaurant \n"
#     + "6. reviews \n")

#     # get user input
#     table = input("User input: ")

#     # sql query based on response
#     try:
#         # line break so it looks nicer
#         print("\n")

#         # user selects 'country' table
#         if table == "1":
#             print("COUNTRY TABLE\n" + "--------------------------")
#             sql = "select * from country"

#             cur = _conn.cursor()
#             cur.execute(sql)

#             # print the column headings
#             l = '{:>10} {:>15}'.format("name", "countrykey")
#             print(l)

#             # print that entire specified table
#             rows = cur.fetchall()
#             for row in rows:
#                 l = '{:>10} {:>15}'.format(row[0], row[1])
#                 print(l)

#         # user selects 'customer' table
#         elif table == "2":
#             print("CUSTOMER TABLE\n" + "--------------------------")
#             sql = "select * from customer"

#             cur = _conn.cursor()
#             cur.execute(sql)

#             # print the column headings
#             l = '{:>15} {:>15} {:>15}'.format("name", "restaurantkey", "reviewkey")
#             print(l)

#             # print that entire specified table
#             rows = cur.fetchall()
#             for row in rows:
#                 l = '{:>15} {:>15} {:>15}'.format(row[0], row[1], row[2])
#                 print(l)
    
#         # user selects 'location' table
#         elif table == "3":
#             print("LOCATION TABLE\n" + "--------------------------")
#             sql = "select * from location"

#             cur = _conn.cursor()
#             cur.execute(sql)

#             # print the column headings
#             l = '{:>100} {:>15} {:>15}'.format("address", "locationkey", "countrykey")
#             print(l)

#             # print that entire specified table
#             rows = cur.fetchall()
#             for row in rows:
#                 l = '{:>100} {:>15} {:>15}'.format(row[0], row[1], row[2])
#                 print(l)

#         # user selects 'menu' table
#         elif table == "4":
#             print("MENU TABLE\n" + "--------------------------")
#             sql = "select * from menu"

#             cur = _conn.cursor()
#             cur.execute(sql)

#             # print the column headings
#             l = '{:>30} {:>15} {:>15}'.format("item", "cost", "menukey")
#             print(l)

#             # print that entire specified table
#             rows = cur.fetchall()
#             for row in rows:
#                 l = '{:>30} {:>15} {:>15}'.format(row[0], row[1], row[2])
#                 print(l)

#         # user selects 'restaurant' table
#         elif table == "5":
#             print("RESTAURANT TABLE\n" + "--------------------------")
#             sql = "select * from restaurant"

#             cur = _conn.cursor()
#             cur.execute(sql)

#             # print the column headings
#             l = '{:>30} {:>15} {:>15} {:>15} {:>15}'.format("name", "pricing", "menukey", "locationkey", "restaurantkey")
#             print(l)

#             # print that entire specified table
#             rows = cur.fetchall()
#             for row in rows:
#                 l = '{:>30} {:>15} {:>15} {:>15} {:>15}'.format(row[0], row[1], row[2], row[3], row[4])
#                 print(l)

#         # user selects 'reviews' table
#         elif table == "6":
#             print("REVIEWS TABLE\n" + "--------------------------")
#             sql = "select * from reviews"

#             cur = _conn.cursor()
#             cur.execute(sql)

#             # print the column headings
#             l = '{:>15} {:>15} {:>15}'.format("user", "stars", "reviewkey")
#             print(l)

#             # print that entire specified table
#             rows = cur.fetchall()
#             for row in rows:
#                 l = '{:>15} {:>15} {:>15}'.format(row[0], row[1], row[2])
#                 print(l)

#         # end
#         print("\n")
            
#     except Error as e:
#         print(e)
