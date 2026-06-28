# 🚗 KIA FinTech — Garage Management System

A full frontend system built with **React**, **HTML**, **CSS**, and **JavaScript** that manages:
- Customer accounts
- KIA car registrations
- Service jobs (oil change, AC service, etc.)
- Payments & invoices
- Cashback offers & redemptions

---

## 📁 Folder Structure

```
kia-fintech/
│
├── public/
│   └── index.html          ← The HTML page (React mounts here)
│
├── src/
│   ├── index.js            ← React's starting point
│   ├── App.js              ← Main app, handles page routing
│   ├── styles.css          ← All global CSS styles
│   │
│   ├── components/
│   │   └── Sidebar.js      ← Left navigation bar
│   │
│   ├── data/
│   │   └── mockData.js     ← Fake database (JavaScript arrays)
│   │
│   └── pages/
│       ├── Dashboard.js    ← Home page with stats
│       ├── Customers.js    ← Customer management
│       ├── Cars.js         ← Car registration
│       ├── Services.js     ← Garage service jobs
│       ├── Payments.js     ← Payment records & invoices
│       └── Cashbacks.js    ← Cashbacks & offers
│
├── database_schema.sql     ← SQL file (for real backend later)
├── package.json            ← Project config & dependencies
└── README.md               ← This file!
```

---

## 🚀 How to Run

### Step 1 — Install Node.js
Download from: https://nodejs.org (choose "LTS" version)

### Step 2 — Open terminal in the project folder
```
cd kia-fintech
```

### Step 3 — Install dependencies
```
npm install
```
This downloads React and all required packages into a `node_modules` folder.

### Step 4 — Start the app
```
npm start
```
The app opens in your browser at: **http://localhost:3000**

---

## 🔧 How to Make Changes

| Want to...                    | Edit this file          |
|-------------------------------|-------------------------|
| Change colors / fonts         | `src/styles.css`        |
| Add/edit mock data            | `src/data/mockData.js`  |
| Change navigation items       | `src/components/Sidebar.js` |
| Edit the dashboard stats      | `src/pages/Dashboard.js`|
| Add a new field to customers  | `src/pages/Customers.js`|
| Add a new page entirely       | Create in `src/pages/`, then import in `App.js` |

---

## 🗄️ SQL Database (for later)

The file `database_schema.sql` contains:
- All 5 tables (customers, cars, services, payments, cashbacks)
- Sample data to insert
- Useful queries to run

You can run this in **MySQL Workbench**, **phpMyAdmin**, or **SQLiteOnline.com**.

---

## 💡 How It Works (for beginners)

1. `index.html` has one `<div id="root">` — that's where React lives
2. `index.js` tells React to start and render `App.js` into that div
3. `App.js` uses **useState** to track which page is active
4. Each page (Dashboard, Customers, etc.) is a separate React component
5. `mockData.js` holds fake data like a real database would

### Key React concept used: `useState`
```js
const [activePage, setActivePage] = useState("dashboard");
// activePage = current value
// setActivePage = function to change it
// "dashboard" = starting value
```

---

## 📚 Tech Stack

| Technology | Purpose                        |
|------------|--------------------------------|
| HTML       | Structure (index.html)         |
| CSS        | Styling (styles.css)           |
| JavaScript | Logic in all .js files         |
| React      | Component-based UI framework   |
| SQL        | Database design (schema file)  |

---

Made for learning purposes 🎓
