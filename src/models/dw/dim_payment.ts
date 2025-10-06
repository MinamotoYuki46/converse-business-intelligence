export interface DimPayment {
    key_payment?: number;
    id_payment?: number | null;
    method?: string | null;
    status?: string | null;
    amount?: number | null;
    provider_reference?: string | null;
}
