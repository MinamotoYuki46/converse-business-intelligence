import mysql from 'mysql2/promise';
import dotenv from 'dotenv';

dotenv.config();

const {
    DB_HOST,
    DB_USER,
    DB_PASS,
    OLTP_DB,
    DW_DB,
    DB_PORT
} = process.env;

export const oltpConnection = mysql.createPool({
    host: DB_HOST,
    user: DB_USER,
    password: DB_PASS,
    database: OLTP_DB,
    port: Number(DB_PORT),
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0,
});

export const dwConnection = mysql.createPool({
    host: DB_HOST,
    user: DB_USER,
    password: DB_PASS,
    database: DW_DB,
    port: Number(DB_PORT),
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0,
});
