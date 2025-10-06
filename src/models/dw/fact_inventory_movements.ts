export interface FactInventoryMovements {
    id_fact_inventory: number;
    key_date: number;
    key_product: number;
    key_location: number;
    movement_type: string;
    quantity: number;
    remarks?: number | null;
}
