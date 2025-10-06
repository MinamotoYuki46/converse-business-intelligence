import { extract } from "./extract";
import { transformDimensions } from "./transform";
import { load } from "./load";

export async function loadDimensions() {
    console.log("Loading Dimensions...");

    const rawCustomers = await extract("SELECT * FROM customer");
    const customers = transformDimensions(rawCustomers, {
        key_customer: "id",
        id_customer: "id",
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
        SELECT p.is as product_id, p.name as product_name, c.name as category, p.brand, v.color, v.size, v.price, p.is_active
        FROM product p
        LEFT JOIN category c ON p.id_category = c.id
        LEFT JOIN product_variant v ON p.product_id = v.id_product
    `);
    const products = transformDimensions(rawProducts, {
        key_product: "product_id",
        id_product: "product_id",
        name: "product_name",
        category: "category",
        brand: "brand",
        color: "color",
        size: "size",
        price: "price",
        is_active: "is_active",
    });
    await load("dim_product", Object.keys(products[0]), products.map(Object.values));
    console.log("dim_product loaded.");

    const rawPayments = await extract("SELECT * FROM payment");
    const payments = transformDimensions(rawPayments, {
        key_payment: "id",
        payment_id: "id",
        method: "method",
        status: "status",
        amount: "amount",
        provider_reference: "provider_reference",
    });
    await load("dim_payment", Object.keys(payments[0]), payments.map(Object.values));
    console.log("dim_payment loaded.");

    const rawShipments = await extract("SELECT * FROM shipment");
    const shipments = transformDimensions(rawShipments, {
        key_shipment: "id",
        id_shipment: "id",
        carrier: "carrier",
        tracking_number: "tracking_number",
        status: "status",
        shipped_date: "shipped_at",
        delivered_date: "delivered_at",
    });
    await load("dim_shipment", Object.keys(shipments[0]), shipments.map(Object.values));
    console.log("dim_shipment loaded.");

    const rawDates = await extract(`
        SELECT DISTINCT DATE(order_date) as full_date FROM orders
        UNION
        SELECT DISTINCT DATE(return_date) FROM returns
    `);
    const dates = transformDimensions(rawDates, {
        key_date: "full_date",
        date_value: "full_date",
        day: "full_date",
        month: "full_date",
        quarter: "full_date",
        year: "full_date",
        day_name: "full_date",
    }).map(d => ({
        ...d,
        day: new Date(d.full_date).getDate(),
        month: new Date(d.full_date).getMonth() + 1,
        quarter: `Q${Math.floor(new Date(d.full_date).getMonth() / 3) + 1}`,
        year: new Date(d.full_date).getFullYear(),
        day_name: new Date(d.full_date).toLocaleDateString("en-US", { weekday: "long" }),
        date_key: parseInt(new Date(d.full_date).toISOString().split("T")[0].replace(/-/g, ""))
    }));
    await load("dim_date", Object.keys(dates[0]), dates.map(Object.values));
    console.log("dim_date loaded.");

    const rawPromotions = await extract("SELECT * FROM promotion");
    const promotions = transformDimensions(rawPromotions, {
        key_promotion: "id",
        id_promotion: "id",
        code: "code",
        description: "description",
        discount_percent: "discount_percent",
        active: "active",
        valid_from: "valid_from",
        valid_to: "valid_to",
    });
    await load("dim_promotion", Object.keys(promotions[0]), promotions.map(Object.values));
    console.log("dim_promotion loaded.");

    const rawLocations = await extract("SELECT * FROM inventory_location");
    const locations = transformDimensions(rawLocations, {
        key_location: "id",
        id_location: "id",
        address: "address",
        city: "city",
        region: "region",
        country: "country",
    });
    await load("dim_inventory_location", Object.keys(locations[0]), locations.map(Object.values));
    console.log("dim_inventory_location loaded.");

    console.log("All dimensions loaded successfully!");
}
