import { extract } from "./extract";
import { transformFacts } from "./transform";
import { load } from "./load";

export async function loadFacts() {
    console.log("Loading Facts...");

    const rawSales = await extract(`
        SELECT o.id as order_id, o.id_customer, o.created_at as order_date, oi.id_variant_product as product_id, oi.quantity, oi.unit_price, o.id_promotion
        FROM orders o
        JOIN order_items oi ON o.id = oi.id_order
    `);
    const sales = transformFacts(rawSales, {
        key_sales: "order_id",
        date_key: "order_date",
        key_customer: "id_customer",
        key_product: "product_id",
        key_promotion: "id_promotion",
        quantity: "quantity",
        unit_price: "unit_price",
    }, { total_amount: rawSales.map(r => r.quantity * r.unit_price) });
    await load("fact_sales", Object.keys(sales[0]), sales.map(Object.values));
    console.log("fact_sales loaded.");

    const rawReturns = await extract(`
        SELECT r.id as return_id, r.id_order_item, o.id_customer, ri.id_variant_products as product_id, r.created_at as return_date, r.quantity, r.reason, r.status
        FROM returns r
        JOIN order_items ri ON r.order_item_id = ri.order_item_id
        JOIN orders o ON ri.id_order = o.id
    `);
    const returns = transformFacts(rawReturns, {
        id_fact_return: "return_id",
        key_return: "return_id",
        id_order_item: "id_order_item",
        key_customer: "customer_id",
        key_date: "return_date",
        key_product: "product_id",
        quantity: "quantity",
        reason: "reason",
        status: "status",
    });
    await load("fact_returns", Object.keys(returns[0]), returns.map(Object.values));
    console.log("fact_returns loaded.");

    const rawPromotions = await extract(`
        SELECT o.order_id, o.id_promotion, o.customer_id, oi.product_id, o.order_date, oi.unit_price, oi.quantity
        FROM orders o
        JOIN order_item oi ON o.order_id = oi.order_id
        WHERE o.promotion_id IS NOT NULL
    `);
    const promotions = transformFacts(rawPromotions, {
        id_fact_promotion: "id"
        key_promotion_fact: "promotion_id",
        promotion_id: "promotion_id",
        order_id: "order_id",
        key_product: "product_id",
        key_customer: "customer_id",
        applied_date_key: "order_date",
        discount_percent: "discount_percent"
    }, { discount_amount: rawPromotions.map(r => (r.unit_price * r.quantity) * (r.discount_percent ?? 0) / 100) });
    await load("fact_promotions", Object.keys(promotions[0]), promotions.map(Object.values));
    console.log("fact_promotions loaded.");

    const rawInventory = await extract(`
        SELECT im.inventory_movement_id, im.product_id, im.location_id, im.date, im.movement_type, im.quantity, im.remarks
        FROM inventory_movement im
    `);
    const inventory = transformFacts(rawInventory, {
        key_inventory: "inventory_movement_id",
        key_product: "product_id",
        key_location: "location_id",
        date_key: "date",
        movement_type: "movement_type",
        quantity: "quantity",
        remarks: "remarks",
    });
    await load("fact_inventory_movement", Object.keys(inventory[0]), inventory.map(Object.values));
    console.log("fact_inventory_movement loaded.");

    console.log("All facts loaded successfully!");
}
