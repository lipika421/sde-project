from flask import Flask, request, render_template,redirect,url_for,flash
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager, UserMixin , login_user,login_required,logout_user,current_user
import json


app = Flask(__name__,static_folder='static',template_folder='templates')
app.config["SQLALCHEMY_DATABASE_URI"]='postgresql://sarthak:sarthak123@localhost/foodorder' 
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config["SECRET_KEY"] = 'thisissecret'
db = SQLAlchemy(app)
login_manager = LoginManager()
login_manager.init_app(app)

menu = []


class User (UserMixin, db.Model):
    __tablename__ = "user"
    id = db.Column(db.Integer, primary_key = True, unique = True)
    username_ = db.Column(db.String(120), unique = False)
    email_ = db.Column(db.String(120), unique = True)
    password_ = db.Column(db.String(120), unique = False)
    address_ = db.Column(db.String(250), unique = False)
    usertype_ = db.Column(db.String(120))
    restname_ = db.Column(db.String(120))
    products = db.relationship('Products',backref = 'owner')

    def __init__(self, email_, username_, password_,address_,usertype_,restname_) :
        self.email_ = email_
        self.username_ = username_
        self.password_ = password_
        self.address_ = address_
        self.usertype_ = usertype_
        self.restname_ = restname_


class Products(db.Model):

    __tablename__ = "products"

    id = db.Column(db.Integer, primary_key = True, unique = True)
    prodname_ = db.Column(db.String(120))
    prodprice_ = db.Column(db.Integer)
    managerid_ = db.Column(db.Integer, db.ForeignKey('user.id'))

    def __init__(self, prodname_,prodprice_,managerid_):
        self.prodname_ = prodname_
        self.prodprice_ = prodprice_
        self.managerid_ = managerid_


class Cart(db.Model):

    __tablename__ = "cart"

    id = db.Column(db.Integer, primary_key = True, unique = True)
    name = db.Column(db.String(120))
    price = db.Column(db.Integer)

    def __init__(self, name, price) : 
        self.name = name
        self.price = price
    


url1 = "http://fonts.googleapis.com/css?family=Source+Sans+Pro:200,300,400,600,700,900,200italic,300italic,400italic,600italic,700italic,900italic"
url2 = "http://fonts.googleapis.com/css?family=Lobster+Two:400,400italic,700,700italic"


@login_manager.user_loader
def load_user(id):
    return User.query.get(id)



@app.route("/") 
def index() :
    print(current_user.is_authenticated)
    return render_template("index.html", font_url1 = url1 , font_url2 =url2)


@app.route("/about")
def about(): 
       return render_template("about.html", font_url1 = url1 , font_url2 =url2)

@app.route("/contact")
def contact () :
    return render_template("contact.html", font_url1=url1, font_url2=url2)

@app.route("/checkout")
def checkout() :
    return render_template("checkout.html", font_url1=url1, font_url2=url2)



@app.route("/login" , methods = ['POST'])
def login() :
    email = request.form['emailadd']
    password =request.form['passwd']
    usertype = request.form['usertype']
    print(usertype)

    user = User.query.filter_by(email_ = email, password_ = password).first()

    if not user :
        return render_template("login.html", font_url1=url1, font_url2=url2 ,text = "*Email, Password or User-Type is wrong")
     
    login_user(user)
    print(current_user.is_authenticated)
    print(current_user.usertype_)
    return render_template("index.html", font_url1=url1, font_url2=url2 ,text = "*Email, Password or User-Type is wrong")


@app.route("/form", methods = ['GET'])
def form() :
    return render_template("form.html",font_url1 = url1 , font_url2 = url2)

@app.route("/addItem", methods = ['POST'])
def addItem() :
    item = request.form['additem']
    price = request.form['price']
    user_id = current_user.id

    if db.session.query(Products).filter(Products.prodname_ == item).count() == 0 :
        data = Products(item,price,user_id)      
        db.session.add(data)
        db.session.commit()
        return redirect('/form')


@app.route("/delItem", methods = ['POST'])
def delItem() :
    item = request.form['itemname']

    query = Products.query.filter_by(prodname_ = item).first()

    db.session.delete(query)
    db.session.commit()

    return redirect('/form')

@app.route("/editItem", methods = ['POST'])
def editItem() :
    item = request.form['itemname']
    price = request.form['newPrice']

    query = Products.query.filter_by(prodname_ = item).first()

    query.prodprice_ = price
    db.session.commit()

    return redirect('/form')

@app.route("/login" , methods = ['GET'])
def signin():
    return render_template("login.html", font_url1= url1 , font_url2 = url2)

@app.route("/register",methods = ['POST'])
def register() :
    email = request.form['emailName']
    username = request.form["firstName"] + " " + request.form["lastName"]
    password = request.form["password"]
    cfrmpwd = request.form ["cpassword"]
    usertype = request.form ["userType"]
    address = request.form ["address"]
    restName = request.form ["restName"]


    if db.session.query(User).filter(User.email_ == email).count() == 0  and password == cfrmpwd:
        data = User(email,username,password,address,usertype,restName)      
        db.session.add(data)
        db.session.commit()
        return redirect('/login')
    elif db.session.query(User).filter(User.email_ == email).count() == 0  and password != cfrmpwd:
        return render_template("register.html", font_url1=url1, font_url2=url2 ,text = "*Passwords do not match")
    else :
        return render_template("register.html", font_url1=url1, font_url2=url2 ,text = "*An account is already linked with this email")

@app.route("/register" ,methods =['GET']) 
def signup() :
    return render_template("register.html", font_url1=url1, font_url2=url2)

@app.route("/order")
def order() :
    return render_template("order.html", font_url1=url1, font_url2=url2)

@app.route("/ordersList", methods = ['GET'])
def ordersList() :
    with open('menu.json') as f:
        menu = json.load(f)
    print(menu)
    return render_template("ordersList.html", font_url1 = url1 , font_url2 = url2 , menu  = menu)


@app.route("/ordersList", methods = ['POST'])
def restHandler() :
    name = request.form['name']
    query = User.query.filter_by(restname_ = name).first()
    menu_query = list(Products.query.filter_by(managerid_=query.id))
    menu = [{
        'name': prod.prodname_,
        'price': prod.prodprice_
    } for prod in menu_query]
    print(menu)
    with open('menu.json', 'w') as f:
        json.dump(menu, f)




@app.route ("/profile")
@login_required
def profile():
    return render_template("profile.html", font_url1 = url1 , font_url2 = url2)   

@app.route("/restaurants")
def restaurants():
    return render_template("restaurants.html", font_url1=url1, font_url2=url2)

@app.route("/manager")
def manager():
    return render_template("manager.html", font_url1=url1, font_url2=url2)

@app.route('/submit', methods=['POST'])
def handle_order():
    if request.method =='POST':
        print(request.get_json())

@app.route('/success')
def success():
    # if request.method == 'POST':Email id already in database
    return render_template("success.html")



@app.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect('/login')

if __name__ == '__main__':
    app.run(debug=True, port=3000)
	
