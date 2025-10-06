import {
    oltpConnection,
    dwConnection
} from './config/db';

async function testDB() {
    try {
        const [oltpResult] = await oltpConnection.query('SELECT DATABASE() AS db;');
        const [dwResult] = await dwConnection.query('SELECT DATABASE() AS db;');
        console.log('Connected to:', (oltpResult as any)[0].db, 'and', (dwResult as any)[0].db);
    } catch (err) {
        console.error('DB connection failed:', err);
    } finally {
        await oltpConnection.end();
        await dwConnection.end();
    }
}

testDB();
