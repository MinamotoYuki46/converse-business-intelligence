export interface ProductVariant {
    id: number;
    id_product: number;
    name: string;
    sku: string;
    size: string;
    colour: string;
    mrsp: number;
    price: number;
    created_at: Date;
    updated_at: Date;
}
