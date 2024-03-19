const express = require('express');
const hbs = require('hbs');
const wax = require('wax-on');
require('dotenv').config();
const { createConnection } = require('mysql2/promise');

let app = express();
app.set('view engine', 'hbs');
app.use(express.static('public'));
app.use(express.urlencoded({extended:false}));

wax.on(hbs.handlebars);
wax.setLayoutPath('./views/layouts');

let connection;

async function main() {
    connection = await createConnection({
        'host': process.env.DB_HOST,
        'user': process.env.DB_USER,
        'database': process.env.DB_NAME,
        'password': process.env.DB_PASSWORD
    })

    app.get('/customers', async function  (req, res) {
        let [customers] = await connection.execute
        ('SELECT Customers.*, Companies.name AS company_name FROM Customers JOIN Companies ON Customers.company_id = Companies.company_id ORDER BY first_name');
        res.render('customers', {
            'customers': customers
        })
    })

    
    app.get('/create-customers', async function (req,res) {
        const customers =  await connection.execute("SELECT * FROM Companies")
        res.render('create-customers', {
            companies
        })
    });

    app.post('/create-customers', async function (req,res){
        // const {first_name: firstName, last_name: lastName, rating: rating, company_id: companyId} = req.body;
        const {first_name, last_name, rating, company_id} = req.body;
        const query = 'INSERT INTO Customers (first_name, last_name, rating, company_id) VALUES("$first_name", "$last_name", "$rating", "$company_id")'
    })
}

main();


app.listen(3000, ()=>{
    console.log('Server is running')
});