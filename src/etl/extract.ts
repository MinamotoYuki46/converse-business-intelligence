import { oltpConnection } from "../config/db";
import { RowDataPacket } from "mysql2";

export async function extract(query: string): Promise<RowDataPacket[]> {
    const [rows] = await oltpConnection.query<RowDataPacket[]>(query);
    return rows;
}
