export interface Payment {
    id: number;
    id_order: number;
    amount: number;
    method: string;
    status: string;
    provider_reference: string;
    created_at: Date;
}
