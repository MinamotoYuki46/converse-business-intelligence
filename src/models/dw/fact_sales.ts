export interface FactSales {
    id_fact_sales: number;
    id_order: number;
    id_order_item: number;
    key_date: number;
    key_customer: number;
    key_product: number;
    key_promotion?: number;
    key_shipment: number;
    key_payment: number;
    quantity: number;
    unit_price: number;
    total_amount: number;
}
