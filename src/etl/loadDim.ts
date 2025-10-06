import { extract } from "./extract";
import { transformDimensions } from "./transform";
import { load } from "./load";

export async function loadDimensions() {
    console.log("Loading Dimensions...");

    const rawCustomers = await extract(`
        SELECT 
            c.id, 
            c.full_name, 
            c.email, 
            c.phone, 
            c.gender, 
            a.city, 
            a.region, 
            a.country, 
            c.created_at, 
            c.updated_at
        FROM customers c
        LEFT JOIN addresses a ON 
            c.id = a.id_customer
        `);
    const customers = transformDimensions(rawCustomers, {
        key_customer: "id",
        full_name: "full_name",
        email: "email",
        phone: "phone",
        gender: "gender",
        city: "city",
        region: "region",
        country: "country",
        created_at: "created_at",
        updated_at: "updated_at",
    });
    await load("dim_customer", Object.keys(customers[0]), customers.map(Object.values));
    console.log("dim_customer loaded.");

    const rawProducts = await extract(`
        SELECT 
            p.id as id_product, 
            v.id as id_variant,
            p.name as product_name, 
            c.name as category, 
            p.brand, 
            v.colour, 
            v.size, 
            v.price, 
            p.is_active
        FROM products p
        LEFT JOIN categories c ON 
            p.id_category = c.id
        LEFT JOIN product_variants v ON 
            p.id = v.id_product
    `);
    const products = transformDimensions(rawProducts, {
        id_product: "id_product",
        id_variant: "id_variant",
        name: "product_name",
        category: "category",
        brand: "brand",
        color: "colour",
        size: "size",
        price: "price",
        is_active: "is_active",
    });
    await load("dim_product", Object.keys(products[0]), products.map(Object.values));
    console.log("dim_product loaded.");

    const rawPayments = await extract("SELECT * FROM payments");
    const payments = transformDimensions(rawPayments, {
        key_payment: "id",
        method: "method",
        status: "status",
        amount: "amount",
        provider_reference: "provider_reference",
    });
    await load("dim_payment", Object.keys(payments[0]), payments.map(Object.values));
    console.log("dim_payment loaded.");

    const rawShipments = await extract("SELECT * FROM shipments");
    const shipments = transformDimensions(rawShipments, {
        key_shipment: "id",
        carrier: "carrier",
        tracking_number: "tracking_number",
        status: "status",
        shipped_date: "shipped_at",
        delivered_date: "delivered_at",
    });
    await load("dim_shipment", Object.keys(shipments[0]), shipments.map(Object.values));
    console.log("dim_shipment loaded.");

    const rawDates = await extract(`
        SELECT DISTINCT DATE(updated_at) as full_date FROM orders
        UNION
        SELECT DISTINCT DATE(created_at) FROM returns
    `);
    const dates = transformDimensions(rawDates, {
        key_date: "full_date",
        full_date: "full_date",
        day: "full_date",
        month: "full_date",
        quarter: "full_date",
        year: "full_date",
        day_name: "full_date",
    }).map(d => {
        const date = new Date(d.full_date);
        if (isNaN(date.getTime())) {
            console.warn("Invalid date:", d.full_date);
            return null;
        }
        return {
            ...d,
            day: date.getDate(),
            month: date.getMonth() + 1,
            quarter: `Q${Math.floor(date.getMonth() / 3) + 1}`,
            year: date.getFullYear(),
            day_name: date.toLocaleDateString("en-US", { weekday: "long" }),
            key_date: parseInt(date.toISOString().split("T")[0].replace(/-/g, ""))
        };
    }).filter(Boolean);

    await load("dim_date", Object.keys(dates[0]), dates.map(Object.values));
    console.log("dim_date loaded.");

    const rawPromotions = await extract("SELECT * FROM promotions");
    const promotions = transformDimensions(rawPromotions, {
        key_promotion: "id",
        code: "code",
        description: "description",
        discount_percent: "discount_percent",
        active: "active",
        valid_from: "valid_from",
        valid_to: "valid_to",
    });
    await load("dim_promotion", Object.keys(promotions[0]), promotions.map(Object.values));
    console.log("dim_promotion loaded.");

    console.log("All dimensions loaded successfully!");
}
