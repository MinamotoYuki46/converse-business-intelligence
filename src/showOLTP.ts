import { oltpConnection } from "./config/db";

async function showOltp() {
    try {
        console.log("\n===================================================");
        console.log("DATABASE: converse_oltp");
        console.log("===================================================");

        const [tables] = await oltpConnection.query(`SHOW TABLES`);
        const tableRows = tables as { [key: string]: string }[];
        
        if (tableRows.length === 0) {
            console.log("No tables found in OLTP database.");
            return;
        }
        
        const tableKey = Object.keys(tableRows[0])[0];

        for (const row of tables as any[]) {
            const tableName = row[tableKey];
            console.log(`\nTable: ${tableName}`);
            console.log("---------------------------------------------------");

            const [rows] = await oltpConnection.query(`SELECT * FROM ${tableName}`);
            if ((rows as any[]).length === 0) {
                console.log("No data in this table.");
            } else {
                console.table(rows);
            }
        }
    } catch (err) {
        console.error("Error reading OLTP data:", err);
    } finally {
        await oltpConnection.end();
    }
}

showOltp();
