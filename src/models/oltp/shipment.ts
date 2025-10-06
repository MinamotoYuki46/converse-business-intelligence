export interface Shipment {
    id: number;
    id_order: number;
    carrier: string;
    tracking_number: string;
    status: string;
    shipped_at?: Date;
    delivered_at?: Date;
}
