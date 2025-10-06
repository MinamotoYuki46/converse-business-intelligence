export interface Category {
    id: number;
    name: string;
    id_parent?: number;
    description?: string;
    created_at: Date;
    updated_at: Date;
}
