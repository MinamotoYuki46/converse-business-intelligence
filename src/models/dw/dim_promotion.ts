export interface DimPromotion {
    key_promotion: number;
    id_promotion: number;
    code: string;
    description: string;
    discount_percent: number;
    active: boolean;
    valid_from: Date;
    valid_to: Date;
}
