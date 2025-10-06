import { extract } from "./extract";
import { transformFacts } from "./transform";
import { load } from "./load";

export async function loadFacts() {
    console.log("Loading Facts...");

    const rawSales = await extract(`
        SELECT 
            o.id AS id_order,
            dd.key_date AS key_date,
            dc.key_customer AS key_customer,
            dp.key_product AS key_product,
            promo.key_promotion AS key_promotion,
            ds.key_shipment AS key_shipment,
            dpay.key_payment AS key_payment,
            oi.quantity,
            oi.unit_price,
            COALESCE(pr.discount_percent, 0) AS discount,
            (oi.quantity * oi.unit_price * (1 - COALESCE(pr.discount_percent, 0) / 100)) AS total_amount

        FROM orders o
        JOIN order_items oi ON o.id = oi.id_order
        LEFT JOIN shipments sh ON sh.id_order = o.id
        LEFT JOIN payments py ON py.id_order = o.id
        LEFT JOIN promotions pr ON pr.id = o.id_promotion
        
        LEFT JOIN converse_dw.dim_date dd ON dd.full_date = DATE(o.created_at)
        LEFT JOIN converse_dw.dim_customer dc ON dc.key_customer = o.id_customer
        LEFT JOIN converse_dw.dim_product dp ON 
            dp.id_product = oi.id_product AND dp.id_variant = oi.id_variant_products
        LEFT JOIN converse_dw.dim_promotion promo ON promo.key_promotion = pr.id
        LEFT JOIN converse_dw.dim_shipment ds ON ds.key_shipment = sh.id
        LEFT JOIN converse_dw.dim_payment dpay ON dpay.key_payment = py.id
    `);
    const sales = transformFacts(rawSales, {
        id_order: "id_order",
        key_order_date: "key_date",
        key_customer: "key_customer",
        key_product: "key_product",
        key_promotion: "key_promotion",
        key_shipment: "key_shipment",
        key_payment: "key_payment",
        discount_percentage: "discount",
        quantity: "quantity",
        unit_price: "unit_price",
        total_amount: "total_amount"
    });
    await load("fact_sales", Object.keys(sales[0]), sales.map(Object.values));
    console.log("fact_sales loaded.");

    const rawReturns = await extract(`
        SELECT 
            oi.id as id_order_item,
            dc.key_customer AS key_customer,
            dp.key_product AS key_product,
            dd.key_date AS key_date,
            r.quantity,
            r.reason,
            r.status
        FROM returns r
        JOIN order_items oi ON r.id_order_item = oi.id
        JOIN orders o ON oi.id_order = o.id

        LEFT JOIN converse_dw.dim_customer dc 
            ON dc.key_customer = o.id_customer

        LEFT JOIN converse_dw.dim_product dp 
            ON dp.id_product = oi.id_product AND dp.id_variant = oi.id_variant_products

        LEFT JOIN converse_dw.dim_date dd 
            ON dd.full_date = DATE(r.created_at)
    `);
    const returns = transformFacts(rawReturns, {
        id_order_item: "id_order_item",
        key_customer: "key_customer",
        key_date: "key_date",
        key_product: "key_product",
        quantity: "quantity",
        reason: "reason",
        status: "status",
    });
    await load("fact_returns", Object.keys(returns[0]), returns.map(Object.values));
    console.log("fact_returns loaded.");

    console.log("All facts loaded successfully!");
}
