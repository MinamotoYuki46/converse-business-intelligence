import { oltpConnection } from "../config/db";

export async function extract(query: string) {
    const [rows] = await oltpConnection.query(query);
    return rows;
}
