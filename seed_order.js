const mysql = require('mysql2');
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'starsandwich_db'
});

db.connect(err => {
    if (err) {
        console.error('Kesalahan koneksi MySQL: ' + err.stack);
        process.exit(1);
    }
    console.log('Terkoneksi ke MySQL untuk seeding...');
});

function generateMidtransId() {
    const prefix = 'SS';
    const date = new Date().toISOString().slice(0, 10).replace(/-/g, '');
    const random = Math.floor(Math.random() * 100000).toString().padStart(5, '0');
    return `${prefix}-${date}-${random}`;
}

function randomDate(start, end) {
    return new Date(start.getTime() + Math.random() * (end.getTime() - start.getTime()));
}

function randomCustomerName() {
    const firstNames = ['Budi', 'Ani', 'Roni', 'Siti', 'Ahmad', 'Dewi', 'Eka', 'Hendra', 'Indah', 'Joko'];
    const lastNames = ['Santoso', 'Wijaya', 'Pratama', 'Kusuma', 'Rahman', 'Suryanto', 'Hartono', 'Setiawan', 'Mahendra', 'Putra'];
    return firstNames[Math.floor(Math.random() * firstNames.length)] + ' ' + lastNames[Math.floor(Math.random() * lastNames.length)];
}

function randomAddress() {
    const streets = ['Jl. Merdeka', 'Jl. Ahmad Yani', 'Jl. Diponegoro', 'Jl. Sudirman', 'Jl. Gatot Subroto', 'Jl. Imam Bonjol', 'Jl. Gajah Mada', 'Jl. Hayam Wuruk'];
    const cities = ['Jakarta', 'Bandung', 'Surabaya', 'Medan', 'Semarang', 'Makassar', 'Palembang', 'Yogyakarta'];
    const street = streets[Math.floor(Math.random() * streets.length)];
    const number = Math.floor(Math.random() * 999) + 1;
    const city = cities[Math.floor(Math.random() * cities.length)];
    const postalCode = Math.floor(Math.random() * 89999) + 10000;
    return `${street} No. ${number}, ${city} ${postalCode}`;
}

function randomPaymentMethod() {
    const methods = ['Credit Card', 'Debit Card', 'Bank Transfer', 'E-Wallet', 'Cash on Delivery'];
    return methods[Math.floor(Math.random() * methods.length)];
}

function randomOrderStatus() {
    const statuses = ['Pending', 'Processing', 'Shipped', 'Completed', 'Cancelled'];
    return statuses[Math.floor(Math.random() * statuses.length)];
}

function randomTotalAmount() {
    return Math.floor(Math.random() * 450000) + 50000;
}

function randomItemsJson() {
    const productNames = [
        'Classic Star Sandwich',
        'Spicy Chicken Sandwich',
        'Premium Beef Sandwich',
        'Vegetarian Star Sandwich',
        'BBQ Chicken Sandwich',
        'Tuna Delight Sandwich',
        'Turkey & Cheese Sandwich',
        'Deluxe Mixed Sandwich'
    ];
    
    const itemCount = Math.floor(Math.random() * 3) + 1; 
    const items = [];
    
    for (let i = 0; i < itemCount; i++) {
        items.push({
            product_id: Math.floor(Math.random() * 8) + 1,
            product_name: productNames[Math.floor(Math.random() * productNames.length)],
            quantity: Math.floor(Math.random() * 5) + 1,
            price: Math.floor(Math.random() * 100000) + 30000
        });
    }
    
    return JSON.stringify(items);
}

function seedOrders() {
    const startDate = new Date('2024-01-01');
    const endDate = new Date('2025-12-31');
    
    const orders = [];
    
    console.log('Generating 100 dummy orders...');
    
    for (let i = 0; i < 100; i++) {
        const orderDate = randomDate(startDate, endDate);
        const updatedAt = new Date(orderDate.getTime() + Math.random() * (Date.now() - orderDate.getTime()));
        
        orders.push({
            order_id_midtrans: generateMidtransId(),
            user_id: Math.floor(Math.random() * 12) + 1, // user_id 1-50
            customer_name: randomCustomerName(),
            order_date: orderDate.toISOString().slice(0, 19).replace('T', ' '),
            total_amount: randomTotalAmount(),
            payment_method: randomPaymentMethod(),
            shipping_address: randomAddress(),
            order_status: randomOrderStatus(),
            items_json: randomItemsJson(),
            updated_at: updatedAt.toISOString().slice(0, 19).replace('T', ' ')
        });
    }
    
    console.log(`Generated ${orders.length} orders. Inserting into database...`);
    let inserted = 0;
    
    orders.forEach((order, index) => {
        const sql = 'INSERT INTO orders (order_id_midtrans, user_id, customer_name, order_date, total_amount, payment_method, shipping_address, order_status, items_json, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';
        
        const values = [
            order.order_id_midtrans,
            order.user_id,
            order.customer_name,
            order.order_date,
            order.total_amount,
            order.payment_method,
            order.shipping_address,
            order.order_status,
            order.items_json,
            order.updated_at
        ];
        
        db.query(sql, values, (err, result) => {
            if (err) {
                console.error(`Error inserting order ${index + 1}: `, err.message);
            } else {
                inserted++;
                if (inserted % 10 === 0) {
                    console.log(`Progress: ${inserted}/${orders.length} orders inserted`);
                }
            }
            
            if (inserted === orders.length || index === orders.length - 1) {
                setTimeout(() => {
                    console.log(`\n✓ Seeding completed! ${inserted} orders inserted successfully.`);
                    db.end();
                }, 500);
            }
        });
    });
}
seedOrders();
