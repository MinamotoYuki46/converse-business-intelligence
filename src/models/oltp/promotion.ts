export interface Promotion {
    id: number;
    code: string;
    description: string;
    discount_percent: number;
    active: boolean;
    valid_from: Date;
    valid_to: Date;
}
