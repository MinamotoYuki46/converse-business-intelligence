export interface DimShipment {
    key_shipment?: number;
    id_shipment?: number | null;
    carrier?: string | null;
    tracking_number?: string | null;
    status?: string | null;
    shipped_date?: Date | null;
    delivered_date?: Date | null;
}
