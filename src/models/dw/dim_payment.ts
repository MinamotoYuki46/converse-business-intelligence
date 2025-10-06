export interface DimPayment {
    key_payment?: number;
    method?: string | null;
    status?: string | null;
    amount?: number | null;
    provider_reference?: string | null;
}
