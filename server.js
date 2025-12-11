const express = require('express');
const mysql = require('mysql2');
const session = require('express-session');
const path = require('path');
const app = express();
const port = 3000;

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
    console.log('Terkoneksi ke MySQL!');
});

app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(session({
    secret: "starsandwich_secret_key",
    resave: false,
    saveUninitialized: true,
    cookie: {
        maxAge: 24 * 60 * 60 * 1000
    }
}));

app.use(express.static('public'));

app.use((req, res, next) => {
    res.locals.user = req.session.user || null;
    next();
});

const orderLinks = [
    { name: 'WEBSITE', url: '/', icon: 'fa-globe', class: 'm1' },
    { name: 'DELIVERY BY COURIER (WHATSAPP)', url: 'https://wa.me/6281234567890', icon: 'fa-brands fa-whatsapp', class: 'm2' },
    { name: 'DELIVERY BY COURIER (INSTAGRAM)', url: 'https://instagram.com/starsandwich_official', icon: 'fa-brands fa-instagram', class: 'm3' },
    { name: 'SHOPEE', url: 'https://shopee.co.id/starsandwich', icon: 'fa-solid fa-store', class: 'm4' },
];

const socialLinks = [
    { icon: 'fa-youtube', url: 'https://youtube.com/@starsandwich' },
    { icon: 'fa-tiktok', url: 'https://tiktok.com/@starsandwich' },
    { icon: 'fa-x-twitter', url: 'https://twitter.com/starsandwich' },
];

app.get('/', (req, res) => {
    const sql = 'SELECT id, name, price, image_url, category FROM products ORDER BY id ASC';
    db.query(sql, (err, products) => {
        if (err) {
            console.error('Gagal memuat produk: ' + err.message);
            return res.status(500).render('index', { products: [], categories: [], error: 'Gagal memuat menu.' });
        }
        const categories = [...new Set(products.map(p => p.category))];
        res.render('index', { products, categories, error: null });
    });
});

app.get('/register', (req, res) => {
    res.render('register');
});

app.post('/register', (req, res) => {
    const { nama, username, password, address } = req.body;

    if (!nama || !username || !password || !address) {
        return res.status(400).send('Semua field harus diisi.');
    }

    const sql = 'INSERT INTO user (nama, username, password, alamat) VALUES (?, ?, ?, ?)';
    const values = [nama, username, password, address];
    db.query(sql, values, (err) => {
        if (err) {
            console.error('Kesalahan saat menyimpan data pengguna: ' + err.message);
            if (err.code === 'ER_DUP_ENTRY') {
                return res.status(409).send('Username sudah terdaftar.');
            }
            return res.status(500).send('Gagal mendaftar. Silakan coba lagi.');
        }
        res.redirect('/login');
    });

});

app.get('/login', (req, res) => {
    res.render('login', { error: null });
});

app.post('/login', (req, res) => {
    const { username, password } = req.body;

    if (!username || !password) {
        return res.status(400).render('login', { error: 'Username dan Password harus diisi.' });
    }

    const sql = 'SELECT id, nama, username, alamat, role FROM user WHERE username = ? AND password = ?';
    const values = [username, password];

    db.query(sql, values, (err, results) => {
        if (err) {
            console.error('Kesalahan saat memeriksa data pengguna: ' + err.message);
            return res.status(500).render('login', { error: 'Terjadi kesalahan server.' });
        }

        if (results.length > 0) {
            req.session.user = results[0];

            if (results[0].role === 'admin') {
                return res.redirect('/admin');
            } else {
                return res.redirect('/');
            }
        }

        res.render('login', { error: 'Username atau Password salah.' });
    });
});


app.get('/logout', (req, res) => {
    if (req.session) {
        req.session.destroy(err => {
            if (err) {
                console.error("Error saat logout:", err);
                return res.status(500).send('Gagal Logout');
            }
            res.redirect('/');
        });
    } else {
        res.redirect('/');
    }
});

app.get('/faq', (req, res) => { /* ... */ res.render('faq', { faqs: [], error: null }); });
app.get('/order', (req, res) => { res.render('order', { orderLinks, socialLinks }); });
app.get('/contact', (req, res) => { res.render('contact', { title: 'CONTACT US', message: null, error: null }); });
app.post('/contact', (req, res) => { /* ... */ res.render('contact', { title: 'CONTACT US', message: 'Pesan berhasil terkirim!', error: null }); });
app.get('/about', (req, res) => { res.render('about', { title: 'Tentang Kami - STAR SANDWICH' }); });
app.get('/cart', (req, res) => { res.render('cart'); });
app.get('/profile', (req, res) => { /* ... */ res.render('profile', { user: res.locals.user }); });
app.get('/privacy', (req, res) => {
    res.render('privacy');
});

app.post('/checkout-process', (req, res) => {
    if (!req.session.user) {
        return res.status(401).json({ success: false, message: 'Anda harus login untuk menyelesaikan pesanan.' });
    }

    const { cartData, totalAmount, paymentMethod } = req.body;

    const userId = req.session.user.id;
    const customerName = req.session.user.nama;
    const shippingAddress = req.session.user.alamat || 'Alamat tidak tersedia';

    if (!cartData || cartData.length === 0 || !totalAmount || !paymentMethod) {
        return res.status(400).json({ success: false, message: 'Data pesanan tidak lengkap atau kosong.' });
    }

    const itemsJsonString = JSON.stringify(cartData);

    const orderSql = `
        INSERT INTO orders (user_id, customer_name, total_amount, payment_method, shipping_address, items_json) 
        VALUES (?, ?, ?, ?, ?, ?)
    `;

    const orderValues = [
        userId,
        customerName,
        totalAmount,
        paymentMethod,
        shippingAddress,
        itemsJsonString
    ];

    db.query(orderSql, orderValues, (err, result) => {
        if (err) {
            console.error('ERROR SAAT INSERT KE TABEL ORDERS:', err);
            return res.status(500).json({ success: false, message: 'Gagal memproses pesanan: Gagal menyimpan data pesanan.' });
        }

        const orderId = result.insertId;
        res.json({
            success: true,
            message: 'Pesanan berhasil diproses dan disimpan!',
            orderId: orderId
        });
    });
});
app.get('/history', (req, res) => {
    if (!res.locals.user) {
        return res.redirect('/login');
    }
    const userId = req.session.user.id;
    const sql = `
        SELECT 
            order_id, order_date, total_amount, payment_method, order_status, shipping_address, items_json, customer_name 
        FROM orders
        WHERE user_id = ?
        ORDER BY order_date DESC
    `;

    db.query(sql, [userId], (err, results) => {
        if (err) {
            console.error('Gagal memuat riwayat pesanan:', err);
            return res.status(500).render('history', { orders: [], error: 'Gagal memuat riwayat pesanan dari database.' });
        }

        const formattedOrders = results.map(row => {
            let items = [];
            try {
                items = JSON.parse(row.items_json);
            } catch (e) {
                console.error("Gagal parse items_json:", e);
            }
            return {
                order_id: row.order_id, date: row.order_date, total: row.total_amount, status: row.order_status,
                paymentMethod: row.payment_method, address: row.shipping_address, items: items, customerName: row.customer_name
            };
        });

        res.render('history', { orders: formattedOrders, error: null });
    });
});



app.get('/admin', (req, res) => {
    if (!req.session.user || req.session.user.role !== 'admin') {
        return res.status(403).send('Akses Ditolak: Anda tidak memiliki hak administrator.');
    }

    const sql = `
        SELECT 
            order_id, order_date, customer_name, total_amount, payment_method, order_status, shipping_address, items_json 
        FROM orders
        ORDER BY order_date DESC
    `;

    db.query(sql, (err, results) => {
        if (err) {
            console.error('Error saat mengambil semua pesanan untuk admin:', err);
            return res.status(500).send('Gagal memuat data admin. (Silakan periksa konsol server untuk detail kesalahan SQL).');
        }

        const allOrders = results.map(row => {
            let items;
            try {
                items = JSON.parse(row.items_json);
            } catch (e) {
                items = [{ name: 'Data item rusak', qty: 1, price: 0 }];
            }

            return {
                order_id: row.order_id, date: row.order_date, customerName: row.customer_name || 'N/A',
                total: row.total_amount, paymentMethod: row.payment_method, status: row.order_status,
                address: row.shipping_address, items: items
            };
        });

        res.render('admin', { orders: allOrders });
    });
});

app.post('/admin/update-status', (req, res) => {
    if (!req.session.user || req.session.user.role !== 'admin') {
        return res.status(403).send('Akses Ditolak.');
    }

    const { orderId, newStatus } = req.body;

    if (!orderId || !newStatus) {
        return res.status(400).send('Data tidak lengkap.');
    }

    const sql = 'UPDATE orders SET order_status = ? WHERE order_id = ?';
    const values = [newStatus, orderId];

    db.query(sql, values, (err) => {
        if (err) {
            console.error('Gagal update status pesanan:', err);
            return res.status(500).send('Kesalahan database saat update status.');
        }

        res.redirect('/admin');
    });
});

const midtransClient = require('midtrans-client');

const snap = new midtransClient.Snap({
    isProduction: false,, 
    clientKey: 'Mid-client-e_KLMEuUjbUGC0HO'  // GANTI dengan client key sandbox And
});



// Route untuk generate Midtrans Snap token
app.post('/create-midtrans-token', async (req, res) => {
    console.log('=== CREATE MIDTRANS TOKEN REQUEST ===');
    
    // Cek session user
    if (!req.session.user) {
        console.log('❌ User not logged in');
        return res.status(401).json({ 
            success: false,
            message: 'Harus login untuk membayar.' 
        });
    }

    const { cartData, totalAmount, paymentMethod } = req.body;
    
    console.log('📦 Cart Data:', cartData);
    console.log('💰 Total Amount:', totalAmount);
    console.log('💳 Payment Method:', paymentMethod);
    console.log('👤 User:', req.session.user);

    // Validasi data
    if (!cartData || !Array.isArray(cartData) || cartData.length === 0) {
        console.log('❌ Cart data invalid');
        return res.status(400).json({ 
            success: false, 
            message: 'Keranjang belanja kosong.' 
        });
    }

    if (!totalAmount || isNaN(totalAmount) || totalAmount <= 0) {
        console.log('❌ Total amount invalid:', totalAmount);
        return res.status(400).json({ 
            success: false, 
            message: 'Total pembayaran tidak valid.' 
        });
    }

    // Jika metode pembayaran cash, tidak perlu token Midtrans
    if (paymentMethod === 'cash' || paymentMethod === 'CASH') {
        console.log('💵 Payment method is cash, skipping Midtrans');
        return res.json({ 
            success: true, 
            message: 'Metode pembayaran cash dipilih.',
            skipMidtrans: true 
        });
    }

    try {
        // Generate order ID unik untuk Midtrans
        const orderIdMidtrans = 'ORDER-' + Date.now() + '-' + Math.floor(Math.random() * 1000);
        console.log('🆔 Generated Midtrans Order ID:', orderIdMidtrans);

        // ✅ PERBAIKAN: Format data produk sesuai dengan database
        const item_details = cartData.map(item => ({
            id: item.id || `PROD-${Date.now()}-${Math.random()}`,
            price: parseInt(item.harga || item.price || 0),
            quantity: parseInt(item.qty || 1),
            name: item.nama || item.name || 'Product',
            category: 'food'
        }));

        // ✅ PERBAIKAN: Gunakan gross_amount sebagai integer
        const gross_amount = parseInt(totalAmount);
        
        // Pastikan gross_amount sama dengan total dari item_details
        const calculatedTotal = item_details.reduce((sum, item) => sum + (item.price * item.quantity), 0);
        
        if (gross_amount !== calculatedTotal) {
            console.warn(`⚠️ Amount mismatch: gross_amount=${gross_amount}, calculated=${calculatedTotal}`);
        }

        // Parameter untuk Midtrans
        const parameter = {
            transaction_details: {
                order_id: orderIdMidtrans,
                gross_amount: gross_amount
            },
            customer_details: {
                first_name: req.session.user.nama || 'Customer',
                email: req.session.user.email || req.session.user.username + '@example.com',
                phone: req.session.user.phone || '08123456789'
            },
            item_details: item_details,
            enabled_payments: getEnabledPayments(paymentMethod),
            credit_card: {
                secure: true
            }
        };

        console.log('📝 Midtrans Parameter:', JSON.stringify(parameter, null, 2));

        // ✅ SIMPAN DATA ORDER KE DATABASE DULU
        const userId = req.session.user.id;
        const customerName = req.session.user.nama;
        const shippingAddress = req.session.user.alamat || 'Alamat tidak tersedia';
        
        // Simpan sebagai JSON string
        const itemsJsonString = JSON.stringify(cartData);
        
        const orderSql = `
            INSERT INTO orders (
                user_id, 
                customer_name, 
                total_amount, 
                payment_method, 
                shipping_address, 
                items_json,
                order_status
            ) VALUES (?, ?, ?, ?, ?, ?, ?)
        `;

        const orderValues = [
            userId,
            customerName,
            totalAmount,
            paymentMethod,
            shippingAddress,
            itemsJsonString,
            'pending' // Status awal
        ];

        // Simpan ke database
        db.query(orderSql, orderValues, async (err, result) => {
            if (err) {
                console.error('❌ Database error:', err);
                return res.status(500).json({ 
                    success: false, 
                    message: 'Gagal menyimpan pesanan ke database.' 
                });
            }

            const orderId = result.insertId;
            console.log('✅ Order saved to database. ID:', orderId);

            try {
                // Sekarang buat token Midtrans
                console.log('🔄 Creating Midtrans transaction...');
                const transaction = await snap.createTransaction(parameter);
                
                console.log('✅ Midtrans Response:', {
                    token: transaction.token ? 'Available' : 'Missing',
                    redirect_url: transaction.redirect_url
                });

                if (!transaction.token) {
                    throw new Error('Token tidak ditemukan dalam respons Midtrans');
                }

                // ✅ UPDATE ORDER DENGAN MIDTRANS ORDER ID
                const updateSql = `UPDATE orders SET order_id_midtrans = ? WHERE order_id = ?`;
                db.query(updateSql, [orderIdMidtrans, orderId], (updateErr) => {
                    if (updateErr) {
                        console.error('⚠️ Failed to update Midtrans order ID:', updateErr);
                    }
                });

                // Kembalikan response sukses
                res.json({
                    success: true,
                    message: 'Token pembayaran berhasil dibuat',
                    token: transaction.token,
                    redirect_url: transaction.redirect_url,
                    orderId: orderId,
                    orderIdMidtrans: orderIdMidtrans
                });

            } catch (midtransError) {
                console.error('❌ Midtrans API Error:', {
                    message: midtransError.message,
                    apiResponse: midtransError.ApiResponse || 'No API response',
                    stack: midtransError.stack
                });

                // Update status order menjadi failed jika Midtrans error
                const updateStatusSql = `UPDATE orders SET order_status = 'failed' WHERE order_id = ?`;
                db.query(updateStatusSql, [orderId]);

                res.status(500).json({ 
                    success: false, 
                    message: 'Gagal membuat token pembayaran: ' + midtransError.message,
                    debug: process.env.NODE_ENV === 'development' ? midtransError.ApiResponse : undefined
                });
            }
        });

    } catch (error) {
        console.error('❌ Unexpected error:', error);
        res.status(500).json({ 
            success: false, 
            message: 'Terjadi kesalahan sistem: ' + error.message 
        });
    }
});

// Helper function untuk menentukan enabled payments berdasarkan metode
function getEnabledPayments(paymentMethod) {
    const methodMap = {
        'QRIS': ['qris'],
        'DANA': ['dana'],
        'SHOPEEPAY': ['shopeepay'],
        'GOPAY': ['gopay'],
        'BANK_TRANSFER': ['bank_transfer'],
        'CREDIT_CARD': ['credit_card']
    };
    
    return methodMap[paymentMethod] || ['qris', 'dana', 'shopeepay', 'gopay', 'bank_transfer'];
}

// Webhook dari Midtrans
app.post('/midtrans-notification', (req, res) => {
    console.log('=== 🛎️ MIDTRANS NOTIFICATION ===');
    console.log('Notification:', JSON.stringify(req.body, null, 2));
    
    const notification = req.body;
    
    // Validasi notifikasi
    if (!notification || !notification.order_id || !notification.transaction_status) {
        console.log('❌ Invalid notification format');
        return res.status(400).send('Invalid notification');
    }
    
    const orderIdMidtrans = notification.order_id;
    const transactionStatus = notification.transaction_status;
    const fraudStatus = notification.fraud_status || 'accept';
    
    console.log(`🔍 Processing: ${orderIdMidtrans}, Status: ${transactionStatus}, Fraud: ${fraudStatus}`);

    // Mapping status
    let orderStatus = 'pending';
    if (transactionStatus === 'capture') {
        orderStatus = (fraudStatus === 'accept') ? 'paid' : 'challenge';
    } else if (transactionStatus === 'settlement') {
        orderStatus = 'paid';
    } else if (transactionStatus === 'pending') {
        orderStatus = 'pending';
    } else if (transactionStatus === 'deny' || transactionStatus === 'expire' || transactionStatus === 'cancel') {
        orderStatus = 'failed';
    }

    console.log(`📊 Updating to status: ${orderStatus}`);

    // Update database berdasarkan order_id_midtrans
    const updateSql = `
        UPDATE orders 
        SET order_status = ?, 
            payment_method = COALESCE(?, payment_method)
        WHERE order_id_midtrans = ?
    `;
    
    db.query(updateSql, [orderStatus, notification.payment_type, orderIdMidtrans], (err, result) => {
        if (err) {
            console.error('❌ Database update error:', err);
            return res.status(500).send('Database error');
        }
        
        console.log(`✅ Updated ${result.affectedRows} row(s)`);
        
        // Midtrans mengharapkan response 200 OK
        res.status(200).send('OK');
    });
});

// Route untuk testing Midtrans
app.get('/test-midtrans', (req, res) => {
    res.json({
        status: 'Midtrans test endpoint',
        config: {
            isProduction: snap.apiConfig.isProduction,
            serverKey: snap.apiConfig.serverKey ? 'Configured' : 'Not configured',
            clientKey: snap.apiConfig.clientKey ? 'Configured' : 'Not configured'
        }
    });
});
// ===================================
// VII. START SERVER
// ===================================
app.listen(port, () => {
    console.log(`Server berjalan di http://localhost:${port}/`);
});
