import { RowDataPacket } from "mysql2";

export function transformDimensions(raw: RowDataPacket[], mapping: Record<string, string>) {
    return raw.map(row => {
        const transformed: any = {};
        for (const [targetKey, sourceKey] of Object.entries(mapping)) {
            transformed[targetKey] = row[sourceKey] ?? null;
        }
        return transformed;
    });
}

export function transformFacts(raw: RowDataPacket[], mapping: Record<string, string>, extraFields: Record<string, any> = {}) {
    return raw.map(row => {
        const transformed: any = {};
        for (const [targetKey, sourceKey] of Object.entries(mapping)) {
            transformed[targetKey] = row[sourceKey] ?? null;
        }
        return { ...transformed, ...extraFields };
    });
}
