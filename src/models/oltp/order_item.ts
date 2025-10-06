export interface OrderItem {
    id: number;
    id_order: number;
    id_products: number;
    id_variant_products: number;
    sku: string;
    quantity: number;
    unit_price: number;
    subtotal?: number;
    created_at: Date;
}
