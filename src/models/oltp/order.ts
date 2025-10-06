export interface Order {
    id: number;
    id_customer: number;
    id_billing_address: number;
    id_shipping_address: number;
    status: string;
    total: number;
    created_at: Date;
    updated_at: Date;
}
