export interface FactSales {
    key_sales: number;
    id_order: number;
    key_order_date: number;
    key_customer: number;
    key_product: number;
    key_promotion?: number;
    key_shipment: number;
    key_payment: number;
    quantity: number;
    discount_percentage: number;
    unit_price: number;
    total_amount: number;
}
