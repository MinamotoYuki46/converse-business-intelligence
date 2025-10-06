import { dwConnection } from "../config/db";

export async function load(table: string, columns: string[], data: any[][]) {
    const placeholders = columns.map(() => "?").join(", ");
    const query = `INSERT INTO ${table} (${columns.join(", ")}) VALUES (${placeholders})`;

    const connection = await dwConnection.getConnection();
    try {
        await connection.beginTransaction();
        for (const row of data) {
            await connection.execute(query, row);
        }
        await connection.commit();
    } catch (err) {
        await connection.rollback();
        throw err;
    } finally {
        connection.release();
    }
}
