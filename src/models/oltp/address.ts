export interface Address {
    id: number;
    id_customer: number;
    label: string;
    line: string;
    city: string;
    state: string;
    region: string;
    country: string;
    postal_code: string;
    is_default: boolean;
    created_at: Date;
}
